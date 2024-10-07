import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';

import '../../../data/services/api_service.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowBackBtn;
  final bool isShowActionBtn;
  final Color bgColor;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool fromSignalScreen;
  final bool isProfileCompleted;
  final VoidCallback? actionPress;
  final IconData icon;

  const CustomAppBar(
      {Key? key,
      this.isProfileCompleted = false,
      this.fromAuth = false,
      this.isTitleCenter = false,
      this.bgColor = MyColor.appBarBgColor,
      this.isShowBackBtn = true,
      this.actionPress,
      this.icon = Icons.search,
      this.isShowActionBtn = false,
      this.fromSignalScreen = false,
      required this.title})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late ApiClient client;

  @override
  void initState() {
    client = Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowBackBtn
        ? AppBar(
            elevation: 0,
            leading: widget.isShowBackBtn
                ? InkWell(
                    onTap: () async {
                      if (widget.fromAuth) {
                        await client.clearSharedData();
                        Get.offAllNamed(RouteHelper.signInScreen);
                      } else if (widget.isProfileCompleted) {
                        await client.clearSharedData();
                        Get.offAllNamed(RouteHelper.signInScreen);
                      } else {
                        String previousRoute = Get.previousRoute;
                        if (previousRoute == '/splash-screen') {
                          Get.offAndToNamed(RouteHelper.homeScreen);
                        } else {
                          Get.back();
                        }
                      }
                    },
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 22))
                : const SizedBox.shrink(),
            backgroundColor: MyColor.backgroundColor,
            title: Text(widget.title.tr,
                style: interNormalDefault.copyWith(color: Colors.black)),
            centerTitle: widget.isTitleCenter,
            actions: [
              widget.isShowActionBtn
                  ? Padding(
                      padding: const EdgeInsets.only(left: Dimensions.space15),
                      child: GestureDetector(
                        onTap: widget.actionPress,
                        child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.04)),
                            child: Icon(widget.icon,
                                color: Colors.black, size: 18)),
                      ),
                    )
                  : const SizedBox()
            ],
          )
        : AppBar(
            elevation: 0,
            backgroundColor: widget.bgColor,
            title: Text(
              widget.title.tr,
              style: interNormalDefault.copyWith(color: Colors.black),
            ),
            automaticallyImplyLeading: false,
            actions: [
              widget.isShowActionBtn
                  ? Padding(
                      padding: const EdgeInsets.only(left: Dimensions.space15),
                      child: GestureDetector(
                        onTap: widget.actionPress,
                        child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.04)),
                            child: Icon(widget.icon,
                                color: Colors.black, size: 18)),
                      ),
                    )
                  : const SizedBox()
            ],
          );
  }
}
