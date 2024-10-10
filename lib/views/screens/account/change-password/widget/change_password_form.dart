import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/data/controller/account/change_password_controller.dart';
import 'package:alwegdany/views/components/buttons/rounded_button.dart';
import 'package:alwegdany/views/components/buttons/rounded_loading_button.dart';
import 'package:alwegdany/views/components/text_field/custom_text_form_field.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
        builder: (controller) => Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: MyStrings.currentPassword.tr,
                    onChanged: (value) {
                      return;
                    },
                    controller: controller.currentPassController,
                    isShowSuffixIcon: true,
                    focusNode: controller.currentPassFocusNode,
                    nextFocus: controller.passwordFocusNode,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    labelText: MyStrings.newPassword.tr,
                    onChanged: (value) {
                      return;
                    },
                    controller: controller.passController,
                    isShowSuffixIcon: true,
                    isPassword: true,
                    focusNode: controller.passwordFocusNode,
                    nextFocus: controller.confirmPassFocusNode,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    labelText: MyStrings.confirmPassword.tr,
                    onChanged: (value) {
                      return;
                    },
                    controller: controller.confirmPassController,
                    isShowSuffixIcon: true,
                    focusNode: controller.confirmPassFocusNode,
                    inputAction: TextInputAction.done,
                    isPassword: true,
                  ),
                  const SizedBox(height: 30),
                  controller.submitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                          text: MyStrings.resetPassword,
                          press: () {
                            FocusScope.of(context).unfocus();
                            controller.changePassword();
                          },
                          width: double.infinity,
                          textColor: MyColor.textColor,
                        )
                ],
              ),
            ));
  }
}
