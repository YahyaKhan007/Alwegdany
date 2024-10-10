import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alwegdany/core/helper/shared_pref_helper.dart';
import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/data/model/general_setting/general_setting_main_model.dart';
import 'package:alwegdany/data/model/global/response_model/response_model.dart';
import 'package:alwegdany/data/repo/auth/general_setting_repo.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';

class SplashController extends GetxController {
  GeneralSettingRepo repo;
  SplashController({
    required this.repo,
  }) {
    gotoNext();
  }
  bool check = false;

  void gotoNext() async {
    bool isRemember = repo.apiClient.sharedPreferences
            .getBool(SharedPreferenceHelper.rememberMeKey) ??
        false;
    getGsData(isRemember);
  }

  Future<void> getGsData(bool isRemember) async {
    ResponseModel response = await repo.getGeneralSetting();

    if (response.statusCode == 200) {
      GeneralSettingMainModel model =
          GeneralSettingMainModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == "success") {
        repo.storeGeneralSetting(model);
        checkAndGo(isRemember);
      } else {
        MySnackbar.error(
          errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
        );
      }
    } else {
      MySnackbar.error(errorList: [response.message]);
    }
  }

  void checkAndGo(bool isRemember) async {
    if (isRemember) {
      Get.offAndToNamed(RouteHelper.homeScreen);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('onboarding_seen') != null) {
        check = prefs.getBool('onboarding_seen')!;
        check
            ? Get.offAndToNamed(RouteHelper.signInScreen)
            : Get.offAndToNamed(RouteHelper.onBoardScreen);
      } else {
        Get.offAndToNamed(RouteHelper.onBoardScreen);
      }

      // Get.offAndToNamed(RouteHelper.signInScreen);
    }
  }
}
