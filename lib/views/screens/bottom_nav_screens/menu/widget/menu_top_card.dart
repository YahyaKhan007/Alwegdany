import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/views/components/divider/custom_divider.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/menu/widget/icon_with_text_widget.dart';

class MenuTopCard extends StatefulWidget {
  const MenuTopCard({Key? key}) : super(key: key);

  @override
  State<MenuTopCard> createState() => _MenuTopCardState();
}

class _MenuTopCardState extends State<MenuTopCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: MyColor.primaryColor,
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.userProfileScreen);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWithTextWidget(
                        icon: MyImages.userProfileIcon,
                        text: MyStrings.userProfile.tr),
                    const CustomDivider(space: 20),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.changePasswordScreen);
                },
                child: Column(
                  children: [
                    IconWithTextWidget(
                        icon: MyImages.changePasswordIcon,
                        text: MyStrings.changePassword.tr),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimensions.space15),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: MyColor.primaryColor,
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                splashColor: MyColor.colorWhite,
                onTap: () {
                  Get.toNamed(RouteHelper.depositHistoryScreen);
                },
                child: Column(
                  children: [
                    IconWithTextWidget(
                        icon: MyImages.depositHistoryIcon,
                        text: MyStrings.depositHistory.tr),
                    const CustomDivider(space: 20),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.depositNowScreen);
                },
                child: Column(
                  children: [
                    IconWithTextWidget(
                        icon: MyImages.depositNowIcon,
                        text: MyStrings.depositNow.tr),
                    const CustomDivider(space: 20),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.signalScreen);
                },
                child: Column(
                  children: [
                    IconWithTextWidget(
                        icon: MyImages.signalIcon, text: MyStrings.signals.tr),
                    const CustomDivider(space: 20),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.referralScreen);
                },
                child: IconWithTextWidget(
                    icon: MyImages.referralIcon, text: MyStrings.referrals.tr),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
