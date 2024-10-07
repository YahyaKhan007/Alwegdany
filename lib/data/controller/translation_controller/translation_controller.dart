import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class TranslationController extends GetxController {
  // static TranslationController instance = TranslationController();

  var english = false.obs;

  changeLanguage({required bool isEnglish}) {
    english.value = isEnglish;
  }

  changeLocal({required String langCode}) {
    var locale = Locale(langCode);
    Get.updateLocale(locale);

    prefs!.setString('Language_Code', langCode);
    // prefs!.setString('Country_Code', countryCode);
  }

  @override
  void onInit() {
    english = prefs?.getString('Language_Code') == 'ar' ? false.obs : true.obs;
    super.onInit();
  }
}
