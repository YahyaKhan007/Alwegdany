import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/signal/signal_controller.dart';
import 'package:signal_lab/data/repo/signal_repo/signal_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/appbar/custom_appbar.dart';
import 'package:signal_lab/views/components/custom_loader.dart';
import 'package:signal_lab/views/components/no_data_found_screen.dart';
import 'package:signal_lab/views/components/search_button.dart';
import 'package:signal_lab/views/screens/signal/widget/list_item.dart';

class SignalScreen extends StatefulWidget {
  const SignalScreen({Key? key}) : super(key: key);

  @override
  State<SignalScreen> createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {

  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<SignalsController>().loadPaginationData();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<SignalsController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SignalsRepo(apiClient: Get.find()));
    final controller = Get.put(SignalsController(signalsRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page = 0;
      controller.initData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignalsController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                backgroundColor: MyColor.backgroundColor,
                appBar: CustomAppBar(
                  title: MyStrings.signals,
                  fromSignalScreen: true,
                  bgColor: MyColor.appBarBgColor,
                  icon: controller.iconPress?Icons.clear:Icons.search,
                  actionPress: (){
                    controller.changeIcon();
                  },
                ),
                body: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: MyColor.primaryColor))
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space20,
                            horizontal: Dimensions.space15),
                        child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: controller.iconPress,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(MyStrings.signalName, style: interNormalSmall.copyWith(color: MyColor.colorWhite, fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: Dimensions.space5 + 3),
                                                  SizedBox(
                                                    height: 45,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: TextFormField(
                                                      controller: controller.searchController,
                                                      cursorColor: MyColor.primaryColor,
                                                      style: interNormalSmall.copyWith(color: MyColor.colorWhite),
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                          hintText: MyStrings.searchBySignalName,
                                                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                                          hintStyle: interNormalSmall.copyWith(color: MyColor.hintTextColor),
                                                          filled: true,
                                                          fillColor: MyColor.backgroundColor,
                                                          border: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5)),
                                                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5)),
                                                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5))),
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
                                        const SizedBox(height: Dimensions.space20),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: controller.dataList.isEmpty && controller.filterLoading == false
                                        ? const NoDataFoundScreen(title: MyStrings.noSignalFound,)
                                        : controller.filterLoading
                                            ? const Center(child: CustomLoader(),)
                                            : SizedBox(
                                                height: MediaQuery.of(context).size.height,
                                                child: ListView.separated(
                                                  shrinkWrap: true,
                                                  controller: scrollController,
                                                  physics: const AlwaysScrollableScrollPhysics(),
                                                  itemCount: controller.dataList.length + 1,
                                                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                                                  itemBuilder: (context, index) {
                                                    if (controller.dataList.length == index) {
                                                      return controller.hasNext() ?
                                                      SizedBox(
                                                        height: 40,
                                                        width: MediaQuery.of(context).size.width,
                                                        child: const Center(child: CustomLoader()),
                                                     ) : const SizedBox();
                                                    }

                                                    return SignalListItem(
                                                        index: index,
                                                        date: controller.dataList[index].createdAt ?? '',
                                                        signalName: controller.dataList[index].signal?.name??'',
                                                        details: controller.dataList[index].signal?.signal??'',
                                                    );
                                                  },
                                                ),
                                              ),
                                  ),
                                ],
                              )),
              ),
            ));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
