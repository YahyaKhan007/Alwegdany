
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import '../../../core/utils/my_color.dart';
import '../buttons/rounded_button.dart';


  showExitDialog(BuildContext context){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: MyColor.otpBgColor,
      width: 300,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      onDismissCallback: (type) {},
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: MyStrings.exitTitle,
      titleTextStyle:interNormalDefault.copyWith(color: MyColor.colorWhite,fontSize: Dimensions.fontDefaultLarge),
      showCloseIcon: false,
      btnCancel: RoundedButton(text: MyStrings.no, press: (){
        Navigator.pop(context);
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.colorHint,),
      btnOk: RoundedButton(text: MyStrings.yes, press: (){
        SystemNavigator.pop();
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.closeRedColor,),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemNavigator.pop();
      },
    ).show();
  }
