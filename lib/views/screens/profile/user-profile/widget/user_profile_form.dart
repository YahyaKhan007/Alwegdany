import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/data/controller/profile/user_profile_controller.dart';
import 'package:signal_lab/views/screens/profile/user-profile/widget/user_info_field.dart';

class UserProfileForm extends StatefulWidget {

  const UserProfileForm({Key? key}) : super(key: key);

  @override
  State<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<UserProfileController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          UserInfoField(
            icon: MyImages.userIcon,
            label: MyStrings.username,
            value: controller.username,
          ),
          const SizedBox(height: Dimensions.space5),

          UserInfoField(
            icon: MyImages.emailIcon,
            label: MyStrings.email,
            value: controller.emailController.text,
          ),
          const SizedBox(height: Dimensions.space5),

          UserInfoField(
            icon: MyImages.phoneIcon,
            label: MyStrings.phoneNumber,
            value: controller.mobileNoController.text
          ),
          const SizedBox(height: Dimensions.space5),

          UserInfoField(
            icon: MyImages.countryIcon,
            label: MyStrings.country,
            value: controller.countryName
          ),
          const SizedBox(height: Dimensions.space5),

          UserInfoField(
            icon: MyImages.addressIcon,
            label: MyStrings.address,
            value: controller.addressController.text
          ),
          const SizedBox(height: Dimensions.space5),

          UserInfoField(
            icon: MyImages.stateIcon,
            label: MyStrings.state,
            value: controller.stateController.text
          ),
          const SizedBox(height: Dimensions.space5),

          UserInfoField(
              icon: MyImages.cityIcon,
              label: MyStrings.city,
              value: controller.cityController.text
          ),
          const SizedBox(height: Dimensions.space5),

          UserInfoField(
              icon: MyImages.zipCodeIcon,
              label: MyStrings.zipCode,
              value: controller.zipCodeController.text
          ),
          const SizedBox(height: Dimensions.space5),

          UserInfoField(
              icon: MyImages.telegramUserIcon,
              label: MyStrings.telegramUsername,
              value: controller.telegramController.text
          ),
        ],
      ),
    );
  }
}
