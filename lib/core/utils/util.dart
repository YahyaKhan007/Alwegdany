import 'package:flutter/services.dart';
import 'package:signal_lab/core/utils/my_color.dart';

class MyUtil{

   static changeTheme(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: MyColor.colorWhite,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: MyColor.bgColorLight,
        systemNavigationBarIconBrightness: Brightness.light));
  }

  static makePortraitOnly(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

   static makePortraitAndLandscape(){
     SystemChrome.setPreferredOrientations([
       DeviceOrientation.portraitUp,
       DeviceOrientation.portraitDown,
       DeviceOrientation.landscapeLeft,
       DeviceOrientation.landscapeRight,
     ]);
   }
}