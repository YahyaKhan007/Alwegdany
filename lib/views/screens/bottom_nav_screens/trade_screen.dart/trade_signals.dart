import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/views/components/will_pop_widget.dart';

import '../../../../data/controller/bottom_nav/home/home_controller.dart';
import '../../../../data/repo/bottom_nav/home/dashboard_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/bottom-nav-bar/bottom_nav_bar.dart';
import '../home/widget/home_screen_card_list/home_screen_card_list.dart';
import 'widget/trade_signal_wigdet.dart';

class TradeSignalWiddget extends StatefulWidget {
  final bool showBack;
  const TradeSignalWiddget({super.key, required this.showBack});

  @override
  State<TradeSignalWiddget> createState() => _TradeSignalWiddgetState();
}

class _TradeSignalWiddgetState extends State<TradeSignalWiddget> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));

    final controller = Get.put(HomeController(dashboardRepo: Get.find()));

    // Get.put(PlanRepo(apiClient: Get.find()));
    // final pController = Get.put(PlanController(planRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDashboardData();
      // pController.getAllPackageData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopWidget(
        nextRoute: '',
        child: Scaffold(
          backgroundColor: MyColor.backgroundColor,
          body: GetBuilder<HomeController>(builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Visibility(
                    visible: widget.showBack,
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
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const TradeSignalCardList(),

                  //  ^ Signals
                  const TradeSignalList(),
                ],
              ),
            );
          }),
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
        ));
  }
}
