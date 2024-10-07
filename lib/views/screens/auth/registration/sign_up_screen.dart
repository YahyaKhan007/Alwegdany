import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/auth/registration/registration_controller.dart';
import 'package:signal_lab/data/repo/auth/registration/registration_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/custom_loader.dart';
import 'package:signal_lab/views/components/text/small_text.dart';
import 'package:signal_lab/views/components/will_pop_widget.dart';
import 'package:signal_lab/views/screens/auth/registration/widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    final controller = Get.put(RegistrationController(
        registrationRepo: Get.find(), generalSettingRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.signInScreen,
      child: GetBuilder<RegistrationController>(
          builder: (controller) => SafeArea(
                child: Scaffold(
                  backgroundColor: MyColor.backgroundColor,
                  body: controller.isLoading
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(child: CustomLoader()))
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(MyStrings.signUpTitle.tr,
                                    style: interNormalOverLarge.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                const SizedBox(height: 15),
                                SmallText(
                                    title: MyStrings.signUpSologan.tr,
                                    textAlign: TextAlign.left),
                                const SizedBox(height: 40),
                                const SignUpForm(),
                              ],
                            ),
                          ),
                        ),
                ),
              )),
    );
  }
}
