import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:signal_lab/core/utils/method.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/helper/shared_pref_helper.dart';
import 'package:signal_lab/core/utils/url_container.dart';
import 'package:signal_lab/data/model/auth/verification/email_verification_model.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  ApiClient apiClient;

  LoginRepo({required this.apiClient});

  Future<ResponseModel> loginUser(
      {required String username, required String password, required String deviceToken}) async {
    Map<String, String> map = {"username": username, "password": password, 'deviceToken' : deviceToken};
    String url = "${UrlContainer.baseUrl}${UrlContainer.loginEndPoint}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.postMethod, map, passHeader: false);

    await apiClient.loadFaqs();

    return responseModel;
  }

  Future<String> forgetPassword(String type, String value) async {
    final map = modelToMap(value, type);
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.forgetPasswordEndPoint}';
    final response = await apiClient.request(url, Method.postMethod, map,
        isOnlyAcceptType: true, passHeader: true);

    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.responseJson));

    if (model.message?.success != null) {
      apiClient.sharedPreferences.setString(
          SharedPreferenceHelper.userEmailKey, model.data?.email ?? '');
      String token = model.data?.token ?? '';
      apiClient.sharedPreferences
          .setString(SharedPreferenceHelper.resetPassTokenKey, token);

      MySnackbar.success(
        msg: [
          '${MyStrings.passResetMailSendTo} ${model.data?.email ?? MyStrings.toYourEmail}'
        ],
      );
      return model.data?.email ?? '';
    } else {
      MySnackbar.error(
        errorList: model.message!.error ?? [MyStrings.somethingWentWrong],
      );
      return '';
    }
  }

  Map<String, String> modelToMap(String value, String type) {
    Map<String, String> map = {'type': type, 'value': value};
    return map;
  }

  Future<EmailVerificationModel> verifyForgetPassCode(String code) async {
    String? email = apiClient.sharedPreferences
            .getString(SharedPreferenceHelper.userEmailKey) ??
        '';
    Map<String, String> map = {'code': code, 'email': email};
    Uri url = Uri.parse(
        '${UrlContainer.baseUrl}${UrlContainer.passwordVerifyEndPoint}');

    final response = await http.post(url, body: map, headers: {
      "Accept": "application/json",
    });

    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.body));
    if (model.message?.success != null) {
      model.setCode(200);
      return model;
    } else {
      model.setCode(400);
      return model;
    }
  }

  Future<EmailVerificationModel> resetPassword(
      String email, String password) async {
    String token = apiClient.sharedPreferences
            .getString(SharedPreferenceHelper.resetPassTokenKey) ??
        '';
    Map<String, String> map = {
      'token': token,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };
    String url = '${UrlContainer.baseUrl}${UrlContainer.resetPasswordEndPoint}';
    ResponseModel response = await apiClient.request(
        url, Method.postMethod, map,
        passHeader: true, isOnlyAcceptType: true);

    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.responseJson));

    if (model.status.toLowerCase() == 'success') {
      MySnackbar.success(
        msg: [model.message?.success.toString() ?? ''],
      );
      model.setCode(200);
      return model;
    } else {
      MySnackbar.error(
          errorList: model.message?.error ?? [MyStrings.requestFail]);
      model.setCode(400);
      return model;
    }
  }

  Future<bool> sendUserToken() async {
    String deviceToken = apiClient.sharedPreferences
            .getString(SharedPreferenceHelper.fcmDeviceKey) ??
        '';

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    bool success = false;

    if (deviceToken.isEmpty) {
      // If device token is empty, retrieve the token
      String? fcmDeviceToken = await firebaseMessaging.getToken();
      if (fcmDeviceToken != null) {
        success = await sendUpdatedToken(fcmDeviceToken);
      }
    } else {
      // Listen for token refresh events
      firebaseMessaging.onTokenRefresh.listen((fcmDeviceToken) async {
        // Update the device token
        apiClient.sharedPreferences
            .setString(SharedPreferenceHelper.fcmDeviceKey, fcmDeviceToken);
        success = await sendUpdatedToken(fcmDeviceToken);
      });
    }
    return success;
  }

  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String, String> map = deviceTokenMap(deviceToken);
    ResponseModel responseModel =
        await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return true;
  }

  Map<String, String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }
}
