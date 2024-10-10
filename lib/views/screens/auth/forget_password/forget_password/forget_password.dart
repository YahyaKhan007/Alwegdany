import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/data/controller/auth/forget_password_controller.dart';
import 'package:alwegdany/data/repo/auth/login/login_repo.dart';
import 'package:alwegdany/views/components/appbar/custom_appbar.dart';
import 'package:alwegdany/views/components/buttons/rounded_button.dart';
import 'package:alwegdany/views/components/buttons/rounded_loading_button.dart';
import 'package:alwegdany/views/screens/auth/forget_password/forget_password/widget/heading_text_widget.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/text_field/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ForgetPasswordController>().isLoading = false;
      Get.find<ForgetPasswordController>().email = '';
    });
  }

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
      child: SafeArea(
          child: Scaffold(
              appBar: const CustomAppBar(
                title: MyStrings.forgetPassword,
                fromAuth: true,
              ),
              backgroundColor: MyColor.backgroundColor,
              body: GetBuilder<ForgetPasswordController>(
                builder: (auth) => SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeadingTextWidget(
                              header: MyStrings.recoverAccount,
                              body: MyStrings.resetPassMsg,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .1,
                            ),
                            CustomTextFormField(
                              isPassword: false,
                              labelText: MyStrings.emailOrUserName.tr,
                              isShowSuffixIcon: false,
                              inputAction: TextInputAction.done,
                              onSuffixTap: () {},
                              onChanged: (value) {
                                auth.email = value;
                                return;
                              },
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            auth.isLoading
                                ? const RoundedLoadingBtn()
                                : RoundedButton(
                                    press: () {
                                      auth.submitForgetPassCode();
                                    },
                                    text: MyStrings.submit.tr,
                                  ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
