import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/core/utils/util.dart';
import 'package:signal_lab/data/controller/plan_controller/plan_controller.dart';
import 'package:signal_lab/data/repo/plan_repo/plan_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:signal_lab/views/components/custom-indicator/custom_indicator.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/pricing-plan/widget/plan_bottom_sheet.dart';

import '../../../../core/utils/dimensions.dart';
import 'widget/plan_card.dart';

// class PlanScreen extends StatefulWidget {
//   final bool showBack;
//   const PlanScreen({Key? key, required this.showBack}) : super(key: key);

//   @override
//   State<PlanScreen> createState() => _PlanScreenState();
// }

// class _PlanScreenState extends State<PlanScreen> {
class PlanScreen extends GetView<PlanController> {
  // @override
  // void initState() {

  //   pageController = PageController(initialPage: 0, viewportFraction: .8);

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) { MyUtil.makePortraitOnly();
  //   Get.put(ApiClient(sharedPreferences: Get.find()));
  //   Get.put(PlanRepo(apiClient: Get.find()));
  //   Get.lazyPut(()=>PlanController(planRepo: Get.find()));
  //   final controller = Get.find<PlanController>()..getAllPackageData();
  //   super.initState();
  //   });
  // }

  // late PageController pageController;

  // @override
  // void dispose() {
  //   MyUtil.makePortraitAndLandscape();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Get.put(PlanRepo(apiClient: Get.find()));
    Get.put(PlanRepo(apiClient: Get.find()));
    // Get.put(PlanController(planRepo: PlanRepo(apiClient: apiClient)));
    Get.lazyPut(() => PlanController(planRepo: Get.find()));
    final controller = Get.find<PlanController>()..getAllPackageData();

    print(Get.find<PlanController>().balance);
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: MyColor.backgroundColor,
          centerTitle: false,
          title: Text(MyStrings.packagesPlan.tr,
              style: interNormalDefaultLarge.copyWith(color: Colors.black)),
          elevation: 0,
          leading: Visibility(
            // visible: controller.showBack,
            visible: false,
            child: Padding(
              padding: const EdgeInsets.only(right: Dimensions.space15),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: GetBuilder<PlanController>(builder: (controller) {
          log(controller.packageList.length.toString());

          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: MyColor.primaryColor),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: PageView.builder(
                              onPageChanged: (index) {
                                controller.changeSelectedIndex(index);
                                if (index ==
                                    controller.packageList.length - 1) {
                                  controller.loadPaginationData();
                                }
                              },
                              controller: controller.pageController,
                              itemCount: controller.packageList.length,
                              itemBuilder: (_, index) {
                                var scale = controller.selectedIndex == index
                                    ? 1.0
                                    : 0.85;

                                return TweenAnimationBuilder(
                                    duration: const Duration(milliseconds: 400),
                                    tween: Tween(begin: scale, end: scale),
                                    curve: Curves.ease,
                                    child: PlanCard(
                                      cardName:
                                          controller.packageList[index].name ??
                                              '',
                                      price:
                                          "${controller.curSymbol}${controller.packageList[index].price}",
                                      packageTime:
                                          "${controller.packageList[index].validity} ${MyStrings.days.tr}",
                                      featureList: controller
                                              .packageList[index].features ??
                                          [],
                                      onPressed: () {
                                        PlanBottomSheet.showBottomSheet(
                                            context,
                                            index,
                                            controller.packageList[index],
                                            controller.currency,
                                            controller.balance.value);
                                      },
                                    ),
                                    builder: (context, double value, child) =>
                                        Transform.scale(
                                          scale: value,
                                          child: child,
                                        ));
                              }),
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                  controller.packageList.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          controller.pageController
                                              .animateToPage(index,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOut);
                                        },
                                        child: CustomIndicator(
                                          isActive:
                                              index == controller.selectedIndex
                                                  ? true
                                                  : false,
                                          activeColor: MyColor.primaryColor,
                                          inactiveColor: MyColor.dividerColor,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          onChanged: () {
                                            controller
                                                .changeSelectedIndex(index);
                                          },
                                        ),
                                      ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
        }),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      ),
    );
  }
}
