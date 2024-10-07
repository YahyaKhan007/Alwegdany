import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/privacy/privacy_controller.dart';
import 'package:signal_lab/data/repo/privacy_repo/privacy_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/appbar/custom_appbar.dart';
import 'package:signal_lab/views/components/buttons/category_button.dart';
import 'package:signal_lab/views/components/custom_loader.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PrivacyRepo(apiClient: Get.find()));
    final controller = Get.put(PrivacyController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.backgroundColor,
        appBar: CustomAppBar(
          title: MyStrings.policies,
          bgColor: MyColor.transparentColor,
          isShowActionBtn: false,
        ),
        body: GetBuilder<PrivacyController>(
          builder: (controller) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: SizedBox(
                          height: 35, width: 35, child: CustomLoader()),
                    ))
                : Container(
                    color: MyColor.backgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            height: 30,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  controller.list.length,
                                  (index) => Row(
                                    children: [
                                      CategoryButton(
                                          color:
                                              controller.selectedIndex == index
                                                  ? MyColor.primaryColor
                                                  : Colors.grey.shade400,
                                          horizontalPadding: 8,
                                          verticalPadding: 7,
                                          textSize: Dimensions.fontDefault,
                                          text: controller.list[index]
                                                  .dataValues?.title?.tr ??
                                              '',
                                          press: () {
                                            controller.changeIndex(index);
                                          }),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Container(
                                    padding: const EdgeInsets.all(20),
                                    width: double.infinity,
                                    color: MyColor.backgroundColor
                                        .withOpacity(0.8),
                                    child: HtmlWidget(controller.selectedHtml,
                                        textStyle: interNormalDefault.copyWith(
                                            color: Colors.white),
                                        onLoadingBuilder: (context, element,
                                                loadingProgress) =>
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: const Center(
                                                    child: CustomLoader()))))))
                      ],
                    ),
                  ),
          ),
        ));
  }
}
