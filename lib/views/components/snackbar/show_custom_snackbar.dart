import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/helper/my_converter.dart';
import '../../../../core/utils/my_color.dart';

class MySnackbar{
  static success({required List<String> msg,int duration=5}){
    String message='';
      if(msg.isEmpty){
        message = 'success';
      }else{
        for (var element in msg) {
          message=message.isEmpty?'$message$element':"$message\n$element";
        }
      }

    message=MyConverter.removeQuotationAndSpecialCharacterFromString(message);

    Get.rawSnackbar(
      progressIndicatorBackgroundColor: MyColor.primaryColor,
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: MyColor.greenSuccessColor,
      borderRadius: 2,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      duration:  Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
  static  error({required List<String>errorList,int duration=5}){

    String message='';

      if(errorList.isEmpty){
        message = 'unknown error';
      }else{
        for (var element in errorList) {
          message = message.isEmpty?'$message$element':"$message\n$element";
        }
      }


    message = MyConverter.removeQuotationAndSpecialCharacterFromString(message);

    Get.rawSnackbar(
      progressIndicatorBackgroundColor: MyColor.primaryColor,
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      borderRadius: 2,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      duration:  Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

}