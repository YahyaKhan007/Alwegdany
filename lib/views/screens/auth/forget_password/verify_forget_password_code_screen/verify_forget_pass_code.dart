import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:alwegdany/core/utils/dimensions.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/my_images.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/utils/style.dart';
import 'package:alwegdany/data/controller/auth/forget_password_controller.dart';
import 'package:alwegdany/data/repo/auth/login/login_repo.dart';
import 'package:alwegdany/views/components/appbar/custom_appbar.dart';
import 'package:alwegdany/views/components/buttons/rounded_button.dart';

import '../../../../../data/services/api_service.dart';
import '../../../../components/buttons/rounded_loading_button.dart';

class VerifyForgetPassScreen extends StatefulWidget {
  const VerifyForgetPassScreen({super.key});

  @override
  State<VerifyForgetPassScreen> createState() => _VerifyForgetPassScreenState();
}

class _VerifyForgetPassScreenState extends State<VerifyForgetPassScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(ForgetPasswordController(loginRepo: Get.find()));
    controller.email = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColor.backgroundColor,
        appBar: const CustomAppBar(
          title: MyStrings.passVerification,
          fromAuth: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GetBuilder<ForgetPasswordController>(
              builder: (controller) => controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: MyColor.primaryColor,
                    ))
                  : Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColor.backgroundColor,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: Dimensions.space35,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: MyColor.cardBgColor,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(MyImages.messageImage,
                                height: 50, width: 50),
                          ),
                          const SizedBox(height: Dimensions.space15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 8),
                                  child: Text(
                                    MyStrings.verifyEmailMsg,
                                    style: interNormalDefaultLarge.copyWith(
                                        color: MyColor.whiteTextColor),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 17),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 30),
                              child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: interNormalDefault.copyWith(
                                    color: MyColor.primaryColor),
                                length: 6,
                                textStyle: interNormalDefault.copyWith(
                                    color: MyColor.primaryColor),
                                obscureText: false,
                                obscuringCharacter: '*',
                                blinkWhenObscuring: false,
                                animationType: AnimationType.none,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderWidth: 1,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 40,
                                    fieldWidth: 40,
                                    inactiveColor: MyColor.whiteTextColor,
                                    inactiveFillColor: MyColor.transparentColor,
                                    activeFillColor: MyColor.transparentColor,
                                    activeColor: MyColor.primaryColor,
                                    selectedFillColor: MyColor.transparentColor,
                                    selectedColor: MyColor.primaryColor),
                                cursorColor: Colors.white,
                                animationDuration:
                                    const Duration(milliseconds: 100),
                                enableActiveFill: true,
                                keyboardType: TextInputType.number,
                                beforeTextPaste: (text) {
                                  return true;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    controller.currentText = value;
                                  });
                                },
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: controller.verifyLoading
                                ? const RoundedLoadingBtn()
                                : RoundedButton(
                                    text: MyStrings.verify,
                                    press: () {
                                      if (controller.currentText.length != 6) {
                                        controller.hasError = true;
                                      } else {
                                        controller.verifyForgetPasswordCode(
                                            controller.currentText);
                                      }
                                    }),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                MyStrings.noCodeReceive,
                                style: interNormalDefault.copyWith(),
                              ),
                              controller.isResendLoading
                                  ? Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 20,
                                      width: 20,
                                      child: const CircularProgressIndicator(
                                        color: MyColor.primaryColor,
                                      ))
                                  : GestureDetector(
                                      onTap: () {
                                        controller.resendForgetPassCode();
                                      },
                                      child: Text(MyStrings.requestAgain,
                                          style: interSemiBoldLarge.copyWith(
                                              fontSize: Dimensions.fontDefault,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: MyColor.primaryColor))),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
