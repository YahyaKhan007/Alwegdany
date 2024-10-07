import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/helper/date_converter.dart';
import 'package:signal_lab/core/helper/my_converter.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/core/utils/util.dart';
import 'package:signal_lab/data/controller/transaction/transaction_controller.dart';
import 'package:signal_lab/data/repo/transaction/transaction_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/appbar/custom_appbar.dart';
import 'package:signal_lab/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:signal_lab/views/components/no_data_found_screen.dart';
import 'package:signal_lab/views/components/search_button.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/transaction-history/widget/bottom_sheet.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/transaction-history/widget/custom_transaction_card.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/transaction-history/widget/filter_row_widget.dart';

import '../../../components/search_text_field.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<TransactionController>().loadTransaction();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<TransactionController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    MyUtil.makePortraitAndLandscape();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    MyUtil.makePortraitOnly();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransactionRepo(apiClient: Get.find()));
    final controller =
        Get.put(TransactionController(transactionRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page = 0;
      controller.initData();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
        builder: (controller) => GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: Scaffold(
                  // backgroundColor: MyColor.backgroundColor,
                  backgroundColor: Colors.white,
                  resizeToAvoidBottomInset: true,
                  appBar: CustomAppBar(
                    isShowBackBtn: false,
                    title: MyStrings.transactionHistory,
                    actionPress: () {
                      controller.changeSearchIcon();
                    },
                    bgColor: MyColor.backgroundColor,
                    icon: controller.isSearch ? Icons.clear : Icons.search,
                    isShowActionBtn: true,
                  ),
                  body: GetBuilder<TransactionController>(
                      builder: (controller) => controller.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: MyColor.primaryColor))
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: controller.isSearch,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(MyStrings.type.tr,
                                                      style: interNormalSmall
                                                          .copyWith(
                                                              color: Colors
                                                                  .black)),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space10),
                                                  SizedBox(
                                                    height: 40,
                                                    child: FilterRowWidget(
                                                        fromTrx: true,
                                                        text: controller
                                                                .selectedTrxType
                                                                .isEmpty
                                                            ? MyStrings.trxType
                                                            : controller
                                                                .selectedTrxType,
                                                        press: () {
                                                          showTrxBottomSheet(
                                                              controller
                                                                  .transactionTypeList,
                                                              1,
                                                              context: context);
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                                width: Dimensions.space15),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(MyStrings.remark.tr,
                                                      style: interNormalSmall
                                                          .copyWith(
                                                              color: Colors
                                                                  .black)),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space10),
                                                  SizedBox(
                                                    height: 40,
                                                    child: FilterRowWidget(
                                                        fromTrx: true,
                                                        text: MyConverter
                                                            .replaceUnderscoreWithSpace(
                                                                controller
                                                                        .selectedRemark
                                                                        .isEmpty
                                                                    ? 'Any'
                                                                    : controller
                                                                        .selectedRemark),
                                                        press: () {
                                                          showTrxBottomSheet(
                                                              controller
                                                                  .remarksList
                                                                  .map((e) => e
                                                                      .remark
                                                                      .toString())
                                                                  .toList(),
                                                              2,
                                                              context: context);
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      MyStrings
                                                          .transactionNumber.tr,
                                                      style: interNormalSmall
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space5),
                                                  SizedBox(
                                                    height: 45,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: SearchTextField(
                                                      controller: controller
                                                          .trxController,
                                                      hintText: MyStrings
                                                          .enterTransactionNumber
                                                          .tr,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                                width: Dimensions.space10),
                                            SearchBtn(
                                              press: () {
                                                controller.filterData();
                                              },
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space20),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: controller
                                                  .transactionList.isEmpty &&
                                              controller.filterLoading == false
                                          ? NoDataFoundScreen(
                                              title: MyStrings.noTrxlFound,
                                              topMargin: 0,
                                              bottomMargin: 20,
                                              height: controller.isSearch
                                                  ? 0.6
                                                  : 0.75,
                                            )
                                          : controller.filterLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: MyColor
                                                              .primaryColor),
                                                )
                                              : SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  child: ListView.separated(
                                                    controller: _controller,
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: controller
                                                            .transactionList
                                                            .length +
                                                        1,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const SizedBox(
                                                                height: 15),
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (controller
                                                              .transactionList
                                                              .length ==
                                                          index) {
                                                        return controller
                                                                .hasNext()
                                                            ? Container(
                                                                height: 40,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    const Center(
                                                                  child: CircularProgressIndicator(
                                                                      color: MyColor
                                                                          .primaryColor),
                                                                ),
                                                              )
                                                            : const SizedBox();
                                                      }
                                                      return CustomTransactionCard(
                                                          index: index,
                                                          detailsText: controller
                                                                  .transactionList[
                                                                      index]
                                                                  .details ??
                                                              "",
                                                          trxData: controller
                                                                  .transactionList[
                                                                      index]
                                                                  .trx ??
                                                              "",
                                                          dateData: DateConverter
                                                              .isoStringToLocalDateOnly(controller
                                                                      .transactionList[
                                                                          index]
                                                                      .createdAt ??
                                                                  ""),
                                                          amountData:
                                                              "${controller.transactionList[index].trxType} ${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.transactionList[index].amount.toString())} USD",
                                                          postBalanceData:
                                                              "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.transactionList[index].postBalance.toString())} USD");
                                                    },
                                                  ),
                                                ))
                                ],
                              ),
                            )),
                  bottomNavigationBar:
                      const CustomBottomNavBar(currentIndex: 2),
                ),
              ),
            ));
  }
}
