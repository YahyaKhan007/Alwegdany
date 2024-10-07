import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/data/model/auth/verification/email_verification_model.dart';
import 'package:signal_lab/data/repo/auth/login/login_repo.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';
import 'package:signal_lab/views/screens/auth/registration/model/error_model.dart';


class ForgetPasswordController extends GetxController {
  LoginRepo loginRepo;


  List<String> errors = [];
  String email='';
  String password='';
  String confirmPassword='';
  bool isLoading = false;
  bool remember = false;
  bool hasError = false;
  String currentText = "";

  ForgetPasswordController({required this.loginRepo}){
    checkPasswordStrength = loginRepo.apiClient.needSecurePassword();
  }

  addError({required String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
      update();
    }
  }

  removeError({required String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
      update();
    }
  }

  void submitForgetPassCode() async {
    if(email.isEmpty){
      MySnackbar.error(errorList: [MyStrings.emailOrUsernameEmptyMsg]);
      return;
    }
    isLoading = true;
    update();
    String value = email;
    String type = value.contains('@') ? 'email' : 'username';
    String responseEmail = await loginRepo.forgetPassword(type, value);

    if(responseEmail.isNotEmpty){
      Get.toNamed(RouteHelper.verifyPassCodeScreen,arguments: responseEmail);
    }

    isLoading = false;
    update();

  }

  bool isResendLoading=false;
  void resendForgetPassCode() async {
    isResendLoading = true;
    update();
    String value = email;
    String type = 'email';
    await loginRepo.forgetPassword(type, value);
    isResendLoading = false;
    update();
  }

  bool verifyLoading=false;

  void verifyForgetPasswordCode(String value) async{
    if(value.isNotEmpty){
      verifyLoading = true;
      update();
      EmailVerificationModel model = await loginRepo.verifyForgetPassCode(value);

      if(model.status == 'success'){
        verifyLoading = false;
        Get.offAndToNamed(RouteHelper.resetPasswordScreen,arguments: email);
        clearAllData();
      }else{
        verifyLoading = false;
        update();
        List<String>errorList = [MyStrings.verificationFailed];
        MySnackbar.error(errorList: model.message?.error??errorList);
      }
    }
  }


  bool checkPasswordStrength = false;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  void resetPassword() async {
    if(errors.isEmpty && password.isNotEmpty && email.isNotEmpty){
      if(checkPasswordStrength && validatePassword(password)!=null){
        MySnackbar.error(errorList: [validatePassword(password)??'Please enter a valid password']);
        return;
      }
      isLoading = true;
      update();
      EmailVerificationModel model = await loginRepo.resetPassword(email,password);
      isLoading = false;
      update();
      if(model.code == 200){
        Get.offAndToNamed(RouteHelper.signInScreen);
      }
    }else if(password.isEmpty){
      MySnackbar.error(errorList: [MyStrings.passwordEmptyMsg]);
    }
  }

  clearAllData(){
    isLoading = false;
    currentText = '';
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

  void updateValidationList(String value){
    passwordValidationRulse[0].hasError = value.contains(RegExp(r'[A-Z]'))?false:true;
    passwordValidationRulse[1].hasError = value.contains(RegExp(r'[a-z]'))?false:true;
    passwordValidationRulse[2].hasError = value.contains(RegExp(r'[0-9]'))?false:true;
    passwordValidationRulse[3].hasError = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))?false:true;
    passwordValidationRulse[4].hasError = value.length>=6?false:true;

    update();
  }

  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{6,}$');
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return null;
    } else {
      if(checkPasswordStrength){
        if (!regex.hasMatch(value)) {
          String message = MyStrings.strongPass;
          return message;
        } else {
          return null;
        }
      }else{
        return null;
      }
    }
  }


}
