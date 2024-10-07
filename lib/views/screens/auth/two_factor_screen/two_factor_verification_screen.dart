import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/auth/two_factor_controller.dart';
import 'package:signal_lab/data/repo/auth/two_factor_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/appbar/custom_appbar.dart';
import 'package:signal_lab/views/components/buttons/rounded_button.dart';
import 'package:signal_lab/views/components/buttons/rounded_loading_button.dart';

class TwoFactorVerificationScreen extends StatefulWidget {

  final bool isProfileCompleteEnable;
  const TwoFactorVerificationScreen({
    Key? key,
    required this.isProfileCompleteEnable
  }) : super(key: key);

  @override
  State<TwoFactorVerificationScreen> createState() => _TwoFactorVerificationScreenState();
}

class _TwoFactorVerificationScreenState extends State<TwoFactorVerificationScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TwoFactorRepo(apiClient: Get.find()));
    final controller = Get.put(TwoFactorController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isProfileCompleteEnable=widget.isProfileCompleteEnable;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.backgroundColor,
        appBar: CustomAppBar(title:MyStrings.twoFactorAuth,fromAuth: true,bgColor: MyColor.transparentColor,),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space20),
          child: GetBuilder<TwoFactorController>(
              builder: (controller) =>  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: Dimensions.space20,),
                    Container(
                      height: 100, width: 100,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(

                          color: MyColor.cardBgColor,
                          shape: BoxShape.circle
                      ),
                      child: SvgPicture.asset(MyImages.messageImage, height: 50, width: 50),
                    ),
                    const SizedBox(height: Dimensions.space50),
                    Text("Enter 6-digit code from your two factor authenticator APP.", style: interNormalDefault.copyWith(fontSize:Dimensions.font15,color: MyColor.colorWhite), textAlign: TextAlign.center),
                    const SizedBox(height: Dimensions.space30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: interNormalDefault.copyWith(color: MyColor.primaryColor),
                        length: 6,
                        textStyle: interNormalDefault.copyWith(color: MyColor.colorWhite),
                        obscureText: false,
                        obscuringCharacter: '*',
                        blinkWhenObscuring: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 40,
                            fieldWidth: 40,
                            inactiveColor:  MyColor.dividerColor,
                            inactiveFillColor: MyColor.backgroundColor,
                            activeFillColor: MyColor.backgroundColor,
                            activeColor: MyColor.primaryColor,
                            selectedFillColor: MyColor.backgroundColor,
                            selectedColor: MyColor.primaryColor
                        ),
                        cursorColor: MyColor.colorWhite,
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
                      ),
                    ),

                    const SizedBox(height: Dimensions.space30),

                    controller.submitLoading?const RoundedLoadingBtn():RoundedButton(
                      press: (){
                        controller.verifyYourSms(controller.currentText);
                      },
                      text: MyStrings.verify,
                    ),
                    const SizedBox(height: Dimensions.space30),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
