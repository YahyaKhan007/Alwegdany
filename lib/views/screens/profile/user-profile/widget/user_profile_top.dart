import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_images.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/core/utils/dimensions.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/style.dart';
import 'package:alwegdany/data/controller/profile/user_profile_controller.dart';

class UserProfileTop extends StatefulWidget {
  const UserProfileTop({Key? key}) : super(key: key);

  @override
  State<UserProfileTop> createState() => _UserProfileTopState();
}

class _UserProfileTopState extends State<UserProfileTop> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.space15, horizontal: Dimensions.space15),
        decoration: BoxDecoration(
            color: MyColor.primaryColor,
            borderRadius: BorderRadius.circular(3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            MyImages.profile,
                          ),
                          fit: BoxFit.fill)),
                ),
                const SizedBox(width: Dimensions.space15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.username,
                      style: interNormalDefault.copyWith(
                          color: MyColor.colorWhite),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.cityController.text,
                      style: interNormalSmall.copyWith(
                          color: MyColor.colorWhite.withOpacity(0.8)),
                    )
                  ],
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.editProfileScreen)?.then((value) {
                  controller.loadProfileInfo();
                });
              },
              child: Container(
                height: 25,
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: MyColor.backgroundColor,
                    borderRadius: BorderRadius.circular(3)),
                child: Text(MyStrings.editProfile.tr,
                    textAlign: TextAlign.center,
                    style:
                        interNormalSmall.copyWith(color: MyColor.colorBlack)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
