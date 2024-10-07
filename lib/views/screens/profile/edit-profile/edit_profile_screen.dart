import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/data/controller/profile/user_profile_controller.dart';
import 'package:signal_lab/data/repo/profile/user_profile_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/appbar/custom_appbar.dart';
import 'package:signal_lab/views/components/custom_loader.dart';
import 'package:signal_lab/views/screens/profile/edit-profile/widget/edit_profile_form.dart';

import 'package:signal_lab/core/utils/my_strings.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

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
        appBar: const CustomAppBar(title:MyStrings.editProfile,bgColor: MyColor.appBarBgColor,),
        body: GetBuilder<UserProfileController>(
          builder: (controller) => controller.isLoading?const Center(
            child: SizedBox(
              height:30,
              width:30,
              child: CustomLoader()),)
              :const SingleChildScrollView(
                 padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                 child:EditProfileForm(),
          ),
        ),
      ),
    );
  }
}

