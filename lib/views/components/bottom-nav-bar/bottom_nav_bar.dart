import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/route/route.dart';
import 'package:alwegdany/core/utils/my_images.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:alwegdany/core/utils/style.dart';
import '../../../core/utils/my_color.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final autoSizeGroup = AutoSizeGroup();
  var bottomNavIndex = 0;

  List<String> iconList = [
    MyImages.homeIcon,
    MyImages.priceIcon,
    MyImages.transaction,
    MyImages.signalIcon,
    MyImages.menuIcon
  ];
  List<String> labelList = [
    MyStrings.home.tr,
    MyStrings.package.tr,
    MyStrings.transaction.tr,
    'التوصيات'.tr,
    MyStrings.menu.tr
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      //todo: If bottom Nav looks funny or gives error
      // safeAreaBottom: false,
      elevation: 0,
      height: 65,
      itemCount: 5,
      // itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        print(isActive.toString());
        final color = isActive ? MyColor.primaryColor : MyColor.colorWhite;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconList[index],
              height: 20,
              width: 20,
              fit: BoxFit.cover,
              color: isActive ? MyColor.primaryColor : Colors.black,
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AutoSizeText(
                labelList[index],
                maxLines: 1,
                style: interNormalSmall.copyWith(
                  color: isActive ? MyColor.primaryColor : Colors.black,
                ),
                group: autoSizeGroup,
              ),
            )
          ],
        );
      },
      backgroundColor: MyColor.backgroundColor,
      splashColor: Colors.grey,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.none,
      leftCornerRadius: 0,
      rightCornerRadius: 0,
      onTap: (index) {
        _onTap(index);
      },
      activeIndex: bottomNavIndex,
    );
  }

  void _onTap(int index) {
    log(widget.currentIndex.toString());
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAndToNamed(RouteHelper.homeScreen);
      }
    } else if (index == 1) {
      log(widget.currentIndex.toString());

      if (!(widget.currentIndex == 1)) {
        Get.offAndToNamed(RouteHelper.pricingScreen);
      }
    } else if (index == 2) {
      log(widget.currentIndex.toString());

      if (!(widget.currentIndex == 2)) {
        Get.offAndToNamed(RouteHelper.transactionHistoryScreen);
      }
    } else if (index == 3) {
      log(widget.currentIndex.toString());

      if (!(widget.currentIndex == 3)) {
        Get.offAndToNamed(RouteHelper.tradeSignalScreen);
        // Get.off(() => const TradeSignalScreen());
      }
    } else if (index == 4) {
      log(widget.currentIndex.toString());

      if (!(widget.currentIndex == 4)) {
        Get.offAndToNamed(RouteHelper.menuScreen);
      }
    }
  }
}
