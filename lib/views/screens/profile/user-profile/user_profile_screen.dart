import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/dimensions.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/data/controller/profile/user_profile_controller.dart';
import 'package:alwegdany/data/repo/profile/user_profile_repo.dart';
import 'package:alwegdany/data/services/api_service.dart';
import 'package:alwegdany/views/components/appbar/custom_appbar.dart';
import 'package:alwegdany/views/screens/profile/user-profile/widget/user_profile_form.dart';
import 'package:alwegdany/views/screens/profile/user-profile/widget/user_profile_top.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(UserProfileRepo(apiClient: Get.find()));
    Get.put(UserProfileController(userProfileRepo: Get.find()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.backgroundColor,
        appBar: const CustomAppBar(
          title: MyStrings.userProfile,
          bgColor: MyColor.appBarBgColor,
        ),
        body: GetBuilder<UserProfileController>(
          builder: (controller) => controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: MyColor.primaryColor),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.space20,
                      horizontal: Dimensions.space15),
                  child: Column(
                    children: const [
                      UserProfileTop(),
                      SizedBox(height: Dimensions.space25),
                      UserProfileForm()
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
