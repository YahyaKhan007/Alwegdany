import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/helper/shared_pref_helper.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/data/model/auth/registration_response_model.dart';
import 'package:signal_lab/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:signal_lab/data/model/country_model/country_model.dart';
import 'package:signal_lab/data/model/general_setting/general_settings_response_model.dart';
import 'package:signal_lab/data/model/global/response_model/response_model.dart';
import 'package:signal_lab/data/repo/auth/general_setting_repo.dart';
import 'package:signal_lab/data/repo/auth/registration/registration_repo.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';
import 'package:signal_lab/views/screens/auth/registration/model/error_model.dart';

class RegistrationController extends GetxController {
  RegistrationRepo registrationRepo;
  GeneralSettingRepo generalSettingRepo;

  RegistrationController(
      {required this.registrationRepo, required this.generalSettingRepo});

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  bool isLoading = true;
  bool agreeTC = false;

  GeneralSettingsResponseModel generalSettingsResponseModel =
      GeneralSettingsResponseModel();

  //it will come from general setting api
  bool checkPasswordStrength = false;
  bool needAgree = true;

  bool submitLoading = false;

  String? username;
  String? email;
  String? countryName;
  String? mobile;
  String? password;
  String? confirmPassword;
  String? countryCode;
  String? mobileCode;

  registerUser() async {
    List<String> error = checkError();
    if (error.isNotEmpty) {
      MySnackbar.error(errorList: error);
      return;
    }

    submitLoading = true;
    update();

    SignUpModel signUpModel = await getUserData();
    ResponseModel response = await registrationRepo.registerUser(signUpModel);

    if (response.statusCode == 200) {
      RegistrationResponseModel registrationModel =
          RegistrationResponseModel.fromJson(jsonDecode(response.responseJson));
      if (registrationModel.status.toString().toLowerCase() == "success") {
        MySnackbar.success(
          msg: registrationModel.message?.success ?? [MyStrings.requestSuccess],
        );
        await checkAndGotoNextStep(registrationModel);
      } else {
        MySnackbar.error(
          errorList: registrationModel.message?.error ??
              [MyStrings.somethingWentWrong],
        );
      }
    } else {
      MySnackbar.error(errorList: [response.message]);
    }
    submitLoading = false;
    update();
  }

  List<String> checkError() {
    List<String> error = [];
    if (countryName == null) {
      error.add(MyStrings.plsSelectACountry);
    }
    if (mobileController.text.toString().isEmpty) {
      error.add(MyStrings.mobileEmptyMsg);
    }
    return error;
  }

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }

  Future<SignUpModel> getUserData() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String deviceToken = '';
    try {
      await messaging.requestPermission();

      messaging.getToken().then((token) {
        deviceToken = token.toString();
        log('FCM Token: $deviceToken');
      });
    } catch (e) {
      log("$e");
    }
    SignUpModel model = SignUpModel(
      mobile: mobileController.text.toString(),
      email: emailController.text.toString(),
      agree: agreeTC ? true : false,
      username: usernameController.text.toString(),
      password: passwordController.text.toString(),
      country: countryName.toString(),
      mobileCode: mobileCode != null ? mobileCode!.replaceAll("[+]", "") : "",
      countryCode: countryCode ?? '',
      deviceToken: deviceToken,
    );

    return model;
  }

  Future<void> checkAndGotoNextStep(
      RegistrationResponseModel responseModel) async {
    bool needEmailVerification =
        responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification =
        responseModel.data?.user?.sv == "1" ? false : true;
    bool isTwoFactorEnable = false;

    SharedPreferences preferences =
        registrationRepo.apiClient.sharedPreferences;
    await preferences.setString(SharedPreferenceHelper.userIdKey,
        responseModel.data?.user?.id.toString() ?? '-1');
    await preferences.setString(SharedPreferenceHelper.accessTokenKey,
        responseModel.data?.accessToken ?? '');
    await preferences.setString(SharedPreferenceHelper.accessTokenType,
        responseModel.data?.tokenType ?? '');
    await preferences.setString(SharedPreferenceHelper.userEmailKey,
        responseModel.data?.user?.email ?? '');
    await preferences.setString(SharedPreferenceHelper.userNameKey,
        responseModel.data?.user?.username ?? '');
    await preferences.setString(SharedPreferenceHelper.userPhoneNumberKey,
        responseModel.data?.user?.mobile ?? '');

    await registrationRepo.sendUserToken();

    bool isProfileCompleteEnable = true;

    if (needEmailVerification == false && needSmsVerification == false) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification == true && needSmsVerification == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,
          arguments: [true, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,
          arguments: [false, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen,
          arguments: [isProfileCompleteEnable, isTwoFactorEnable]);
    }
  }

  void initData() async {
    isLoading = true;
    update();
    await getCountryData();

    ResponseModel response = await generalSettingRepo.getGeneralSetting();

    if (response.statusCode == 200) {
      GeneralSettingsResponseModel model =
          GeneralSettingsResponseModel.fromJson(
              jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == 'success') {
        generalSettingsResponseModel = model;
        registrationRepo.apiClient.storeGeneralSetting(model);
        if (model.data?.generalSetting?.registration?.toLowerCase() == '0') {
          MySnackbar.error(errorList: ['Registration is currently disabled']);
          Get.offAllNamed(RouteHelper.signInScreen);
          return;
        }
      } else {
        String message = MyStrings.somethingWentWrong;
        MySnackbar.error(errorList: model.message?.error ?? [message]);
        return;
      }
    } else {
      if (response.statusCode == 503) {
        noInternet = true;
        update();
      }
      MySnackbar.error(errorList: [response.message]);
      return;
    }

    needAgree =
        generalSettingsResponseModel.data?.generalSetting?.agree.toString() ==
                '0'
            ? false
            : true;
    checkPasswordStrength = generalSettingsResponseModel
                .data?.generalSetting?.securePassword
                .toString() ==
            '0'
        ? false
        : true;

    isLoading = false;
    update();
  }

  bool countryLoading = true;
  List<Countries> countryList = [];

  Future<dynamic> getCountryData() async {
    ResponseModel model = await registrationRepo.getCountryData();
    if (model.statusCode == 200) {
      CountryModel countryModel =
          CountryModel.fromJson(jsonDecode(model.responseJson));
      List<Countries>? tempList = countryModel.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
      }
      countryLoading = false;
      update();
      return;
    } else {
      MySnackbar.error(errorList: [model.message]);
      countryLoading = false;
      update();
      return;
    }
  }

  bool noInternet = false;

  void changeInternetStatus(bool hasInternet) {
    noInternet = false;
    initData();
    update();
  }

  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{6,}$');

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return MyStrings.enterYourPassword;
    } else {
      if (checkPasswordStrength) {
        if (!regex.hasMatch(value)) {
          return MyStrings.invalidPassMsg;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  List<ErrorModel> passwordValidationRulse = [
    ErrorModel(text: MyStrings.hasUpperLetter, hasError: true),
    ErrorModel(text: MyStrings.hasLowerLetter, hasError: true),
    ErrorModel(text: MyStrings.hasDigit, hasError: true),
    ErrorModel(text: MyStrings.hasSpecialChar, hasError: true),
    ErrorModel(text: MyStrings.minSixChar, hasError: true),
  ];

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }

  void updateValidationList(String value) {
    passwordValidationRulse[0].hasError =
        value.contains(RegExp(r'[A-Z]')) ? false : true;
    passwordValidationRulse[1].hasError =
        value.contains(RegExp(r'[a-z]')) ? false : true;
    passwordValidationRulse[2].hasError =
        value.contains(RegExp(r'[0-9]')) ? false : true;
    passwordValidationRulse[3].hasError =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ? false : true;
    passwordValidationRulse[4].hasError = value.length >= 6 ? false : true;

    update();
  }
}
