import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/utils/style.dart';
import 'package:alwegdany/data/controller/auth/registration/registration_controller.dart';
import 'package:alwegdany/views/components/buttons/rounded_button.dart';
import 'package:alwegdany/views/components/buttons/rounded_loading_button.dart';
import 'package:alwegdany/views/components/text_field/another_custom_text_field.dart';
import 'package:alwegdany/views/components/text_field/custom_text_form_field.dart';
import 'package:alwegdany/views/components/text_field/custom_text_form_field2.dart';
import 'package:alwegdany/views/screens/auth/registration/widgets/validation_widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              labelText: MyStrings.userName.tr,
              onChanged: (value) {},
              controller: controller.usernameController,
              focusNode: controller.usernameFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.enterYourUsername.tr;
                } else if (value.length < 6) {
                  return MyStrings.kShortUserNameError.tr;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 25),
            CustomTextFormField(
              labelText: MyStrings.emailAddress.tr,
              controller: controller.emailController,
              focusNode: controller.emailFocusNode,
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return MyStrings.enterYourEmail.tr;
                } else if (!MyStrings.emailValidatorRegExp
                    .hasMatch(value ?? '')) {
                  return MyStrings.enterAValidEmail.tr;
                } else {
                  return null;
                }
              },
              onChanged: (value) {},
            ),
            const SizedBox(height: 25),
            AnotherCustomTextField(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * .8,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Center(
                              child: Container(
                                height: 5,
                                width: 100,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(.3),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Flexible(
                              child: ListView.builder(
                                  itemCount: controller.countryList.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          controller.countryController.text =
                                              controller.countryList[index]
                                                      .country ??
                                                  '';
                                          controller.setCountryNameAndCode(
                                              controller.countryList[index]
                                                      .country ??
                                                  '',
                                              controller.countryList[index]
                                                      .countryCode ??
                                                  '',
                                              controller.countryList[index]
                                                      .dialCode ??
                                                  '');

                                          Navigator.pop(context);

                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(.3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(color:MyColor.colorHint),
                                          ),
                                          child: Text(
                                              '+${controller.countryList[index].dialCode}  ${controller.countryList[index].country}',
                                              style: interNormalSmall.copyWith(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      );
                    });
              },
              child: CustomTextFormField2(
                labelText: MyStrings.selectCountry.tr,
                focusNode: controller.countryFocusNode,
                inputType: TextInputType.phone,
                isEnabled: false,
                fillColor: Colors.black,
                isShowSuffixIcon: true,
                isCountryPicker: true,
                isIcon: true,
                controller: controller.countryController,
                suffixIconUrl: '',
                hintText: MyStrings.selectCountry.tr,
                onChanged: (value) {
                  return;
                },
              ),
            ),
            const SizedBox(height: 25),
            controller.countryName == null
                ? const SizedBox()
                : Column(
                    children: [
                      AnotherCustomTextField(
                        isShowSuffixView: true,
                        isShowBorder: false,
                        prefixWidgetValue: '+${controller.mobileCode?.tr}',
                        child: CustomTextFormField2(
                          labelText: MyStrings.phoneNumber.tr,
                          controller: controller.mobileController,
                          focusNode: controller.mobileFocusNode,
                          inputType: TextInputType.phone,
                          onChanged: (value) {},
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
            Visibility(
                visible: controller.hasPasswordFocus &&
                    controller.checkPasswordStrength,
                child: ValidationWidget(
                  list: controller.passwordValidationRulse,
                )),
            Focus(
              onFocusChange: (hasFocus) {
                controller.changePasswordFocus(hasFocus);
              },
              child: CustomTextFormField(
                isShowSuffixIcon: true,
                isPassword: true,
                labelText: MyStrings.password.tr,
                controller: controller.passwordController,
                focusNode: controller.passwordFocusNode,
                validator: (value) {
                  return controller.validatePassword(value ?? '');
                },
                onChanged: (value) {
                  if (controller.checkPasswordStrength) {
                    controller.updateValidationList(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 25),
            CustomTextFormField(
              labelText: MyStrings.confirmPassword.tr,
              isShowSuffixIcon: true,
              isPassword: true,
              controller: controller.confirmPasswordController,
              focusNode: controller.confirmPasswordFocusNode,
              validator: (value) {
                if (controller.passwordController.text.toLowerCase() !=
                    controller.confirmPasswordController.text
                        .toLowerCase()
                        .tr) {
                  return MyStrings.kMatchPassError.tr;
                } else {
                  return null;
                }
              },
              onChanged: (String? value) {},
            ),
            const SizedBox(height: 25),
            controller.needAgree
                ? Row(
                    children: [
                      Checkbox(
                        checkColor: MyColor.textColor,
                        fillColor:
                            MaterialStateProperty.all(MyColor.primaryColor),
                        activeColor: MyColor.primaryColor,
                        value: controller.agreeTC,
                        onChanged: (bool? value) {
                          controller.updateAgreeTC();
                        },
                      ),
                      Row(
                        children: [
                          Text(MyStrings.iAgreeWith,
                              style: interNormalDefault.copyWith(
                                  color: MyColor.colorWhite)),
                          const SizedBox(width: 3),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.privacyPolicyScreen);
                            },
                            child: Text(MyStrings.policies.toLowerCase().tr,
                                style: GoogleFonts.inter(
                                    color: MyColor.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: MyColor.primaryColor)),
                          ),
                          const SizedBox(width: 3),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 25),
            controller.submitLoading
                ? const RoundedLoadingBtn()
                : RoundedButton(
                    text: MyStrings.signUp,
                    press: () {
                      if (formKey.currentState!.validate()) {
                        controller.registerUser();
                      }
                    },
                  ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(MyStrings.alreadyAccount,
                    style: interNormalDefault.copyWith(color: Colors.black)),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(RouteHelper.signInScreen);
                  },
                  child: Text(MyStrings.signInNow.tr,
                      style: interNormalDefault.copyWith(
                          color: MyColor.primaryColor)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
