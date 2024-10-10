import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/data/model/authorization/authorization_response_model.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/repo/auth/sms_email_verification_repo.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';

class SmsVerificationController extends GetxController {
  SmsEmailVerificationRepo repo;
  SmsVerificationController({required this.repo});

  bool hasError = false;
  bool isLoading = true;
  String currentText = '';
  bool isProfileCompleteEnable = false;
  bool isTwoFactorEnable = false;

  Future<void> loadBefore() async {
    isLoading = true;
    update();
    await repo.sendAuthorizationRequest();
    isLoading = false;
    update();
    return;
  }

  bool submitLoading = false;
  verifyYourSms(String currentText) async {
    if (currentText.isEmpty) {
      MySnackbar.error(errorList: [MyStrings.otpEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel =
        await repo.verify(currentText, isEmail: false, isTFA: false);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));

      if (model.status == MyStrings.success) {
        MySnackbar.success(
          msg: model.message?.success ?? [MyStrings.requestSuccess],
        );
        if (isTwoFactorEnable) {
          Get.offAndToNamed(RouteHelper.twoFactorScreen,
              arguments: isProfileCompleteEnable);
        } else {
          Get.offAndToNamed(isProfileCompleteEnable
              ? RouteHelper.profileCompleteScreen
              : RouteHelper.homeScreen);
        }
      } else {
        MySnackbar.error(
            errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      MySnackbar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }

  bool resendLoading = false;
  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: false);
    resendLoading = false;
    update();
  }
}
