import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/helper/my_converter.dart';
import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/core/utils/dimensions.dart';
import 'package:alwegdany/core/utils/my_images.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/data/controller/bottom_nav/home/home_controller.dart';
import 'package:alwegdany/views/screens/bottom_nav_screens/home/widget/renew_plan_bottomSheet.dart';

import 'home_single_card.dart';

class TradeSignalCardList extends StatelessWidget {
  const TradeSignalCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => SizedBox(
        // height: 130,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              HomeSingleCard(
                  firstText: controller.totalTrx.padLeft(2, '0'),
                  secondText: MyStrings.totalTransaction,
                  imageUrl: MyImages.totalTrxIcon,
                  press: () =>
                      Get.toNamed(RouteHelper.transactionHistoryScreen)),
              const SizedBox(width: Dimensions.space10),
              HomeSingleCard(
                  isSvg: false,
                  firstText: controller.packageTime,
                  secondText: controller.packageName,
                  imageUrl: MyImages.plan,
                  press: () {
                    if (controller.packageTime != '---' &&
                        controller.packageTime.isNotEmpty) {
                      RenewPlanBottomSheet.showBottomSheet(context, controller);
                    }
                  }),
              const SizedBox(width: Dimensions.space10),
              HomeSingleCard(
                  firstText: controller.totalSignal.padLeft(2, '0'),
                  secondText: MyStrings.totalSignal,
                  imageUrl: MyImages.totalSignalIcon,
                  press: () => Get.toNamed(RouteHelper.signalScreen)),
              const SizedBox(width: Dimensions.space10),
              HomeSingleCard(
                  firstText:
                      "${controller.currencySymbol} ${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.totalDeposit)}",
                  secondText: MyStrings.totalDeposit,
                  imageUrl: MyImages.totalDepositIcon,
                  press: () => Get.toNamed(RouteHelper.depositHistoryScreen)),
              const SizedBox(width: Dimensions.space10),
              HomeSingleCard(
                  firstText: controller.totalReferral.padLeft(2, '0'),
                  secondText: MyStrings.totalReferral,
                  imageUrl: MyImages.totalReferralIcon,
                  press: () => Get.toNamed(RouteHelper.referralScreen)),
            ],
          ),
        ),
      ),
    );
  }
}
