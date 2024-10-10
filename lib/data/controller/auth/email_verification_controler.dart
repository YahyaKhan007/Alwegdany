import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/data/model/authorization/authorization_response_model.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/repo/auth/sms_email_verification_repo.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';

class EmailVerificationController extends GetxController {
  bool isLoading = false;
  SmsEmailVerificationRepo repo;

  EmailVerificationController({required this.repo});

  bool hasError = false;
  String currentText = "";
  bool needSmsVerification = false;
  bool isProfileCompleteEnable = false;
  bool needTwoFactor = false;
  bool submitLoading = false;

  loadData() async {
    isLoading = true;
    update();
    await repo.sendAuthorizationRequest();
    isLoading = false;
    update();
  }

  Future<void> verifyEmail(String text) async {
    if (text.isEmpty) {
      MySnackbar.error(errorList: [MyStrings.otpEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(text);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));

      if (model.status == MyStrings.success) {
        if (needSmsVerification) {
          Get.offAndToNamed(RouteHelper.smsVerificationScreen,
              arguments: [isProfileCompleteEnable, needTwoFactor]);
        } else if (needTwoFactor) {
          Get.offAndToNamed(RouteHelper.twoFactorScreen,
              arguments: isProfileCompleteEnable);
        } else {
          Get.offAndToNamed(
            isProfileCompleteEnable
                ? RouteHelper.profileCompleteScreen
                : RouteHelper.homeScreen,
          );
        }
      } else {
        MySnackbar.error(
            errorList: model.message?.error ??
                ['${MyStrings.email} ${MyStrings.verificationFailed}']);
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
    await repo.resendVerifyCode(isEmail: true);
    resendLoading = false;
    update();
  }
}
