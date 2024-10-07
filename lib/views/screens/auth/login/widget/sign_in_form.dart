import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/auth/login/login_controller.dart';
import 'package:signal_lab/views/components/buttons/rounded_button.dart';
import 'package:signal_lab/views/components/buttons/rounded_loading_button.dart';
import 'package:signal_lab/views/components/text_field/custom_text_form_field.dart';
import 'package:signal_lab/views/screens/auth/login/widget/switch_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              labelText: MyStrings.userName.tr,
              onChanged: (value) {},
              controller: controller.usernameController,
              focusNode: controller.usernameFocusNode,
              nextFocus: controller.passwordFocusNode,
              validator: (value) {
                if (value?.isEmpty) {
                  return MyStrings.pleaseFillOutTheField.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 35),
            CustomTextFormField(
              labelText: MyStrings.password.tr,
              onChanged: (value) {},
              controller: controller.passwordController,
              focusNode: controller.passwordFocusNode,
              isShowSuffixIcon: true,
              isPassword: true,
              inputAction: TextInputAction.done,
              validator: (value) {
                if (value?.isEmpty) {
                  return MyStrings.pleaseFillOutTheField.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SwitchButton(controller: controller)),
                TextButton(
                  onPressed: () {
                    controller.forgetPassword();
                  },
                  child: Text(MyStrings.forgotPassword.tr,
                      textAlign: TextAlign.center,
                      style: interNormalDefault.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            const SizedBox(height: 25),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(MyStrings.dontAccount.tr,
                    style: interNormalDefault.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                // const SizedBox(
                //   height: 2,
                // ),

                InkWell(
                  onTap: () {
                    Get.offAndToNamed(RouteHelper.signUpScreen);
                  },
                  child: Text(" ${MyStrings.registerNow.tr} ",
                      style: interSemiBoldLarge.copyWith(
                          fontSize: Dimensions.fontDefault,
                          color: MyColor.primaryColor)),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            controller.isSubmit
                ? const RoundedLoadingBtn()
                : RoundedButton(
                    text: MyStrings.signIn,
                    press: () async {
                      

                      if (formKey.currentState!.validate()) {
                        controller.loginUser();
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
