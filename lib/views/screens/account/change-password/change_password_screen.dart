import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/account/change_password_controller.dart';
import 'package:signal_lab/data/repo/account/change_password_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/screens/account/change-password/widget/change_password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ChangePasswordRepo(apiClient: Get.find()));
    Get.put(ChangePasswordController(changePasswordRepo: Get.find()));
    super.initState();
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
        appBar: AppBar(
            title: Text(MyStrings.changePassword.tr,
                style: interNormalDefaultLarge.copyWith(
                    color: MyColor.colorWhite)),
            backgroundColor: MyColor.backgroundColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(MyImages.backIcon,
                  color: Colors.black, height: 15, width: 15),
            )),
        body: GetBuilder<ChangePasswordController>(
          builder: (controller) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.createNewPass.tr,
                    style: interNormalExtraLarge.copyWith(
                        color: MyColor.colorBlack, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    MyStrings.createNewPassDescription.tr,
                    style: interNormalSmall.copyWith(
                        color: Colors.black.withOpacity(.5)),
                  ),
                  const SizedBox(height: 50),
                  const ChangePasswordForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
