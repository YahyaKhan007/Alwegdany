import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/auth/login/login_controller.dart';
import 'package:signal_lab/data/repo/auth/login/login_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/will_pop_widget.dart';
import 'package:signal_lab/views/screens/auth/login/widget/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.backgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 50, horizontal: Dimensions.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(MyStrings.loginTitle,
                  //     style: interNormalOverLarge.copyWith(
                  //         fontWeight: FontWeight.w500, color: Colors.black)),
                  // const SizedBox(height: 15),
                  // Text(MyStrings.loginSologan,
                  //     style: interNormalDefault.copyWith(color: Colors.black)),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/images/app_logo2.png',
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  const SignInForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
