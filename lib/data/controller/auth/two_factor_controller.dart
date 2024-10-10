import 'dart:convert';

import 'package:get/get.dart';
import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/data/model/authorization/authorization_response_model.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/repo/auth/two_factor_repo.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';

class TwoFactorController extends GetxController {
  TwoFactorRepo repo;
  TwoFactorController({required this.repo});
  bool isProfileCompleteEnable = false;

  bool submitLoading = false;
  String currentText = '';
  verifyYourSms(String currentText) async {
    if (currentText.isEmpty) {
      MySnackbar.error(errorList: [MyStrings.otpEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(currentText);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));

      if (model.status == MyStrings.success) {
        MySnackbar.success(
          msg: model.message?.success ?? [MyStrings.requestSuccess],
        );
        Get.offAndToNamed(isProfileCompleteEnable
            ? RouteHelper.profileCompleteScreen
            : RouteHelper.homeScreen);
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
}
