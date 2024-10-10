import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/helper/date_converter.dart';
import 'package:alwegdany/core/helper/my_converter.dart';
import 'package:alwegdany/core/utils/dimensions.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/utils/util.dart';
import 'package:alwegdany/data/controller/deposit_controller/deposit_controller.dart';
import 'package:alwegdany/data/repo/deposit_repo/deposit_repo.dart';
import 'package:alwegdany/data/services/api_service.dart';
import 'package:alwegdany/views/components/appbar/custom_appbar.dart';
import 'package:alwegdany/views/components/custom_loader.dart';
import 'package:alwegdany/views/components/no_data_found_screen.dart';
import 'package:alwegdany/views/screens/deposit/deposit-history/widget/custom_deposit_card.dart';
import 'package:alwegdany/views/screens/deposit/deposit-history/widget/deposit_history_top.dart';

class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<DepositController>().hasNext()) {
        Get.find<DepositController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    MyUtil.makePortraitOnly();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    final controller =
        Get.put(DepositController(depositHistoryRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    MyUtil.makePortraitAndLandscape();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyColor.backgroundColor,
          appBar: CustomAppBar(
            title: MyStrings.depositHistory.tr,
            isShowActionBtn: true,
            icon: controller.isSearch ? Icons.clear : Icons.search,
            actionPress: () {
              controller.changeSearchStatus();
            },
          ),
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: MyColor.primaryColor),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.space20,
                      horizontal: Dimensions.space15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: controller.isSearch,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            DepositHistoryTop(),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller.depositHistoryList.isEmpty &&
                                controller.filterLoading == false
                            ? NoDataFoundScreen(
                                title: MyStrings.noDepositFound,
                                height: controller.isSearch ? 0.75 : 0.8)
                            : controller.filterLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: MyColor.primaryColor),
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      controller: scrollController,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          controller.depositHistoryList.length +
                                              1,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                              height: Dimensions.space10),
                                      itemBuilder: (context, index) {
                                        if (controller
                                                .depositHistoryList.length ==
                                            index) {
                                          return controller.hasNext()
                                              ? SizedBox(
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: const Center(
                                                    child: CustomLoader(),
                                                  ),
                                                )
                                              : const SizedBox();
                                        }
                                        return CustomDepositCard(
                                          trxData: controller
                                                  .depositHistoryList[index]
                                                  .trx ??
                                              "",
                                          initiatedData: DateConverter
                                              .isoStringToLocalDateOnly(
                                                  controller
                                                          .depositHistoryList[
                                                              index]
                                                          .createdAt ??
                                                      ""),
                                          gatewayData: controller
                                                  .depositHistoryList[index]
                                                  .gateway
                                                  ?.name ??
                                              "",
                                          conversionData:
                                              "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.depositHistoryList[index].finalAmo ?? "")} ${controller.depositHistoryList[index].methodCurrency}",
                                          amountConversion:
                                              "1 ${controller.currency} = ${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.depositHistoryList[index].rate ?? "")} ${controller.depositHistoryList[index].methodCurrency}",
                                          amountData:
                                              "${controller.getAmount(index)} ${controller.currency}",
                                          statusData:
                                              controller.getStatus(index),
                                          statusColor:
                                              controller.getStatusColor(index),
                                        );
                                      },
                                    ),
                                  ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
