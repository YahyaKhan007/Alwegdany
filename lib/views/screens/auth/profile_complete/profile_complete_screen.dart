import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/data/controller/account/profile_complete/profile_complete_controller.dart';
import 'package:alwegdany/data/repo/auth/profile_complete/profile_complete_repo.dart';
import 'package:alwegdany/data/services/api_service.dart';
import 'package:alwegdany/views/components/appbar/custom_appbar.dart';
import 'package:alwegdany/views/components/will_pop_widget.dart';
import 'package:alwegdany/views/screens/auth/profile_complete/widget/profile_complete_form.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileCompleteRepo(
      apiClient: Get.find(),
    ));
    Get.put(ProfileCompleteController(profileRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
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
          appBar: const CustomAppBar(
            title: MyStrings.profileComplete,
            isProfileCompleted: true,
          ),
          body: GetBuilder<ProfileCompleteController>(
            builder: (controller) => const SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Center(
                child: ProfileCompleteForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
