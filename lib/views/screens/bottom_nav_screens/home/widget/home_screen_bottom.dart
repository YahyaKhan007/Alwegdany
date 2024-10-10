import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/utils/style.dart';
import 'package:alwegdany/data/controller/bottom_nav/home/home_controller.dart';
import 'package:alwegdany/data/controller/plan_controller/plan_controller.dart';
import 'package:alwegdany/views/components/snackbar/show_custom_snackbar.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../data/repo/bottom_nav/home/dashboard_repo.dart';
import '../../../../../data/services/api_service.dart';

class HomeScreenBottom extends StatefulWidget {
  const HomeScreenBottom({super.key});

  @override
  State<HomeScreenBottom> createState() => _HomeScreenBottomState();
}

class _HomeScreenBottomState extends State<HomeScreenBottom> {
  // late final HomeController controller;
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));

    final controller = Get.put(HomeController(dashboardRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            elevation: 20,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    MyStrings.referralLink.tr,
                    textAlign: TextAlign.center,
                    style: interNormalSmall.copyWith(color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: DottedBorder(
                      color: Colors.greenAccent.withOpacity(0.8),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Text(
                                controller.referralLink,
                                textAlign: TextAlign.center,
                                style: interNormalSmall.copyWith(
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              )),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: controller.referralLink));
                                  MySnackbar.success(
                                      msg: [MyStrings.referralLinkCopied]);
                                },
                                child: const Icon(Icons.copy,
                                    color: Colors.greenAccent, size: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ^ *********************
          // ^ *********************
          // ^ *********************
          // ^ *********************
          // ^ *********************
          // ^ *********************
          //   ^  New design Container
        ],
      ),
    );
  }
}
