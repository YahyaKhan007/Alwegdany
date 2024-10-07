import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/data/controller/auth/forget_password_controller.dart';
import 'package:signal_lab/data/repo/auth/login/login_repo.dart';
import 'package:signal_lab/views/components/appbar/custom_appbar.dart';
import 'package:signal_lab/views/components/buttons/rounded_button.dart';
import 'package:signal_lab/views/components/text_field/custom_text_form_field.dart';
import 'package:signal_lab/views/screens/auth/registration/widgets/validation_widget.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/buttons/rounded_loading_button.dart';
import '../../../../components/from_errors.dart';

import '../forget_password/widget/heading_text_widget.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find()));
    final controller =Get.put(ForgetPasswordController(loginRepo: Get.find()));

    try{
      controller.email=Get.arguments;
    }finally{}

    super.initState();


  }

  @override
  void dispose() {
    Get.find<ForgetPasswordController>().errors.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Get.find<ForgetPasswordController>().isLoading=false;
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColor.backgroundColor,
        appBar: const CustomAppBar(title:MyStrings.resetPassword, fromAuth: true,),
        body: GetBuilder<ForgetPasswordController>(
          builder: (controller) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
              shrinkWrap: true,
                children: [
                  const HeadingTextWidget(header:MyStrings.resetYourPassword ,body:MyStrings.resetLabelText,),
                  const SizedBox(height: 40,),
                  Column(
                    children: [
                      Visibility(
                          visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                          child: ValidationWidget(list: controller.passwordValidationRulse,fromReset: true,)),

                      Focus(
                        onFocusChange: (hasFocus){
                          controller.changePasswordFocus(hasFocus);
                        },
                        child: CustomTextFormField(
                          labelText: MyStrings.password,
                          focusNode: controller.passwordFocusNode,
                          nextFocus: controller.confirmPasswordFocusNode,
                          isShowSuffixIcon: true,
                          isPassword: true,
                          onChanged: (value) {
                            if(controller.checkPasswordStrength){
                              controller.updateValidationList(value);
                            }
                              controller.password=value;
                              if (value.isNotEmpty) {
                                controller.removeError(
                                    error: MyStrings.passwordEmptyMsg);
                              }else{
                                controller.addError(
                                    error: MyStrings.passwordEmptyMsg);
                              }
                              if(controller.password.toString()==controller.confirmPassword.toString()){
                                controller.removeError(error: MyStrings.kMatchPassError);
                                return;
                              }else{
                                controller.addError(error: MyStrings.kMatchPassError);
                                return;
                              }
                            }),
                      ),
                      const SizedBox(height: 35,),
                      CustomTextFormField(
                          labelText: MyStrings.confirmPassword,
                          focusNode: controller.confirmPasswordFocusNode,
                          isShowSuffixIcon: true,
                          isPassword: true,
                          onChanged: (value){
                            controller.confirmPassword=value;
                            if(controller.password.toString()==controller.confirmPassword.toString()){
                              controller.removeError(error: MyStrings.kMatchPassError);
                              return;
                            }else{
                              controller.addError(error: MyStrings.kMatchPassError);
                              return;
                            }
                          }),
                      const SizedBox(height: 10,),
                      FormError(errors: controller.errors),
                      const SizedBox(height: 50,),
                      controller.isLoading
                          ? const RoundedLoadingBtn()
                          : RoundedButton(
                        width: 1,
                        text: MyStrings.submit,
                        press: () {
                          controller.resetPassword();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

