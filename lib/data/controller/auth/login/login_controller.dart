import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/data/model/auth/login/login_response_model.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/repo/auth/login/login_repo.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';
import '../../../../../core/helper/shared_pref_helper.dart';
import '../../../../../core/route/route.dart';

class LoginController extends GetxController {
  LoginRepo loginRepo;

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool remember = false;

  LoginController({required this.loginRepo}) {
    isLoading = false;
    remember = false;
  }

  bool isSubmit = false;
  Future<void> loginUser() async {
    isSubmit = true;

    String deviceToken = '';

    log("click on login button");
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      await messaging.requestPermission();

      messaging.getToken().then((token) {
        log('FCM Token: $token');
        deviceToken = token.toString();
        log('FCM Token: $deviceToken');
      });
    } catch (e) {
      log("$e");
    }

    update();
    ResponseModel response = await loginRepo.loginUser(
        deviceToken: deviceToken,
        username: usernameController.text.toString(),
        password: passwordController.text.toString());

    if (response.statusCode == 200) {
      LoginResponseModel model =
          LoginResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status.toString().toLowerCase() == "success") {
        await checkAndGotoNextStep(model);
      } else {
        MySnackbar.error(
            errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      MySnackbar.error(errorList: [response.message]);
    }
    isSubmit = false;
    update();
  }

  void forgetPassword() {
    Get.toNamed(RouteHelper.forgotPasswordScreen);
  }

  Future<void> checkAndGotoNextStep(LoginResponseModel responseModel) async {
    bool needEmailVerification =
        responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification =
        responseModel.data?.user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = responseModel.data?.user?.tv == '1' ? false : true;

    if (remember) {
      await loginRepo.apiClient.sharedPreferences
          .setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await loginRepo.apiClient.sharedPreferences
          .setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userIdKey,
        responseModel.data?.user?.id.toString() ?? '-1');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey,
        responseModel.data?.accessToken ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenType,
        responseModel.data?.tokenType ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userEmailKey,
        responseModel.data?.user?.email ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userPhoneNumberKey,
        responseModel.data?.user?.mobile ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userNameKey,
        responseModel.data?.user?.username ?? '');

    //todo: check this one out, when i comment this user logins
    await loginRepo.sendUserToken();

    bool isProfileCompleteEnable =
        responseModel.data?.user?.regStep == '0' ? true : false;

    if (needSmsVerification == false &&
        needEmailVerification == false &&
        isTwoFactorEnable == false) {
      if (isProfileCompleteEnable) {
        Get.offAndToNamed(RouteHelper.profileCompleteScreen);
      } else {
        Get.offAndToNamed(RouteHelper.homeScreen);
      }
    } else if (needSmsVerification == true &&
        needEmailVerification == true &&
        isTwoFactorEnable == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,
          arguments: [true, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needSmsVerification == true && needEmailVerification == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,
          arguments: [true, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen,
          arguments: [isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,
          arguments: [false, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorScreen,
          arguments: isProfileCompleteEnable);
    }

    if (remember) {
      changeRememberMe();
    }
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }
}
