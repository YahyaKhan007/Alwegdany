import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/helper/my_converter.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/bottom_nav/home/home_controller.dart';
import 'package:signal_lab/data/controller/plan_controller/plan_controller.dart';
import 'package:signal_lab/data/repo/plan_repo/plan_repo.dart';
import 'package:signal_lab/views/components/buttons/rounded_button.dart';
import 'package:signal_lab/views/components/buttons/rounded_loading_button.dart';
import 'package:signal_lab/views/components/divider/custom_divider.dart';
import 'package:signal_lab/views/components/snackbar/show_custom_snackbar.dart';

class RenewPlanBottomSheet {
  static void showBottomSheet(BuildContext context, HomeController controller) {
    Get.put(PlanRepo(apiClient: Get.find()));
    Get.put(PlanController(planRepo: Get.find()));

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (context) => GetBuilder<PlanController>(
            builder: (planController) => SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.space10,
                        horizontal: Dimensions.space15),
                    decoration: const BoxDecoration(
                        // color: Colors.black,
                        color: MyColor.backgroundColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  height: 4,
                                  width: 50,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space15),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${MyStrings.areYourSureToRenew} ${controller.packageName}",
                                overflow: TextOverflow.ellipsis,
                                style: interNormalDefaultLarge.copyWith(
                                    color: MyColor.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      shape: BoxShape.circle),
                                  child: SvgPicture.asset(
                                    MyImages.closeIcon,
                                    width: 15,
                                    height: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const CustomDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyStrings.package,
                                    style: interNormalSmall.copyWith(
                                        color: MyColor.colorWhite
                                            .withOpacity(0.8)),
                                  ),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(
                                    controller.packageName,
                                    style: interNormalDefault.copyWith(
                                        color: MyColor.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyStrings.price,
                                    style: interNormalSmall.copyWith(
                                        color: MyColor.primaryColor
                                            .withOpacity(0.8)),
                                  ),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(
                                    "${controller.packagePrice} ${controller.currencySymbol}",
                                    style: interNormalDefault.copyWith(
                                        color: MyColor.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.space15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyStrings.validity,
                                    style: interNormalSmall.copyWith(
                                        color: MyColor.primaryColor
                                            .withOpacity(0.8)),
                                  ),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(
                                    "${controller.packageValidity} ${MyStrings.days}",
                                    style: interNormalDefault.copyWith(
                                        color: MyColor.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyStrings.yourBalance,
                                    style: interNormalSmall.copyWith(
                                        color: MyColor.primaryColor
                                            .withOpacity(0.8)),
                                  ),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(
                                    "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.balance)} ${controller.currency}",
                                    style: interNormalDefault.copyWith(
                                        color: MyColor.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const CustomDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RoundedButton(
                                  verticalPadding: 14,
                                  color: MyColor.colorGrey.withOpacity(0.1),
                                  text: MyStrings.close,
                                  press: () {
                                    Get.back();
                                  }),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Expanded(
                                child: planController.renewPlanLoading
                                    ? const RoundedLoadingBtn(
                                        verticalPadding: 14,
                                        color: MyColor.greenP,
                                      )
                                    : RoundedButton(
                                        verticalPadding: 14,
                                        color: MyColor.greenP,
                                        text: MyStrings.confirm,
                                        press: () async {
                                          Map<String, dynamic> result =
                                              await planController.renewPackage(
                                                  packageId: int.parse(
                                                      controller.packageId));
                                          Get.back();
                                          if (result['status'] == true) {
                                            MySnackbar.success(
                                                msg: result['list']);
                                          } else {
                                            MySnackbar.error(
                                                errorList: result['list']);
                                          }

                                          controller.getDashboardData();
                                        })),
                          ],
                        )
                      ],
                    ),
                  ),
                )));
  }
}
