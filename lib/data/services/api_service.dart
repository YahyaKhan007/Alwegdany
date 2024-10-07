import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signal_lab/core/helper/shared_pref_helper.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/method.dart';
import 'package:signal_lab/data/model/authorization/authorization_response_model.dart';
import 'package:signal_lab/data/model/general_setting/general_settings_response_model.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';

class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
      String uri, String methodRequest, Map<String, dynamic>? params,
      {bool passHeader = false, bool isOnlyAcceptType = false}) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (methodRequest == Method.postMethod) {
        if (passHeader) {
          initToken();
          if (isOnlyAcceptType) {
            response = await http.post(url, body: params, headers: {
              "Accept": "application/json",
            });
          } else {
            response = await http.post(url, body: params, headers: {
              "Accept": "application/json",
              "Authorization": "$tokenType $token"
            });
          }
        } else {
          response = await http.post(url, body: params);
        }
      } else if (methodRequest == Method.postMethod) {
        if (passHeader) {
          initToken();
          response = await http.post(url, body: params, headers: {
            "Accept": "application/json",
            "Authorization": "$tokenType $token"
          });
        } else {
          response = await http.post(url, body: params);
        }
      } else if (methodRequest == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (methodRequest == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();
          response = await http.get(url, headers: {
            "Accept": "application/json",
            "Authorization": "$tokenType $token"
          });
        } else {
          response = await http.get(url);
        }
      }

      print(url.toString());
      print(response.statusCode);
      print(response.body.toString());

      if (response.statusCode == 200) {
        try {
          AuthorizationResponseModel model =
              AuthorizationResponseModel.fromJson(jsonDecode(response.body));
          if (model.remark == 'profile_incomplete') {
            Get.toNamed(RouteHelper.profileCompleteScreen);
          }
          if (model.remark == 'unauthenticated') {
            sharedPreferences.setBool(
                SharedPreferenceHelper.rememberMeKey, false);
            Get.offAllNamed(RouteHelper.signInScreen);
          }
        } finally {}
        return ResponseModel(true, 'Success', 200, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.signInScreen);
        return ResponseModel(false, 'Unauthorized', 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(false, 'Server Error', 500, response.body);
      } else {
        return ResponseModel(false, 'Something Wrong', 499, response.body);
      }
    } on SocketException catch (e) {
      return ResponseModel(false, 'No Internet Connection', 503, '');
    } on FormatException {
      return ResponseModel(false, 'Bad Response Format!', 400, '');
    } catch (e) {
      return ResponseModel(false, 'Something Went Wrong', 499, '');
    }
  }

  String token = '';
  String tokenType = '';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t =
          sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType =
          sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  storeGeneralSetting(GeneralSettingsResponseModel model) {
    String json = jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingsResponseModel getGSData() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingsResponseModel model =
        GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    return model;
  }

  String getCurrencyOrUsername(
      {bool isCurrency = true, bool isSymbol = false}) {
    if (isCurrency) {
      String pre = sharedPreferences
              .getString(SharedPreferenceHelper.generalSettingKey) ??
          '';
      GeneralSettingsResponseModel model =
          GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
      String currency = isSymbol
          ? model.data?.generalSetting?.curSym ?? ''
          : model.data?.generalSetting?.curText ?? '';
      return currency;
    } else {
      String username =
          sharedPreferences.getString(SharedPreferenceHelper.userNameKey) ?? '';
      return username;
    }
  }

  bool needSecurePassword() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingsResponseModel model =
        GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    return model.data?.generalSetting?.securePassword.toString() == '0'
        ? false
        : true;
  }

  Future<void> clearSharedData() async {
    await sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey, '');
    await sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenType, '');
    await sharedPreferences.setBool(
        SharedPreferenceHelper.rememberMeKey, false);
  }

  // ^ Faqs

  Future<void> loadFaqs() async {}
}
