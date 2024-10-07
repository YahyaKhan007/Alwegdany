import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/deposit_controller/new_deposit_controller.dart';
import 'package:signal_lab/data/model/deposit/deposit_method/deposit_method_model.dart';
import 'package:signal_lab/data/repo/deposit_repo/deposit_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/appbar/custom_appbar.dart';
import 'package:signal_lab/views/components/buttons/rounded_button.dart';
import 'package:signal_lab/views/components/buttons/rounded_loading_button.dart';
import 'package:signal_lab/views/components/custom_loader.dart';
import 'package:signal_lab/views/components/text_field/custom_text_form_field.dart';
import 'package:signal_lab/views/screens/deposit/deposit-now/widget/info_widget.dart';

class DepositNowScreen extends StatefulWidget {
  const DepositNowScreen({Key? key}) : super(key: key);

  @override
  State<DepositNowScreen> createState() => _DepositNowScreenState();
}

class _DepositNowScreenState extends State<DepositNowScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    Get.put(NewDepositController(depositHistoryRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.backgroundColor,
        appBar: const CustomAppBar(title: MyStrings.depositNow),
        body: GetBuilder<NewDepositController>(
          builder: (controller) => controller.isLoading
              ? const Center(
                  child: CustomLoader(),
                )
              : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField<Methods>(
                                borderRadius: BorderRadius.circular(20),
                                dropdownColor: MyColor.backgroundColor,
                                onChanged: (Methods? method) {
                                  controller.setPaymentMethod(method);
                                },
                                items: controller.methodList.map((value) {
                                  return DropdownMenuItem<Methods>(
                                    value: value,
                                    child: Text(value.name.toString().tr,
                                        style: interNormalSmall.copyWith(
                                            color: MyColor.colorBlack)),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                    label: Text(
                                      MyStrings.selectGateway.tr,
                                      style: interNormalDefault.copyWith(
                                          color: MyColor.colorBlack,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    hintText: MyStrings.selectOne.tr,
                                    hintStyle: interNormalDefault.copyWith(
                                        color: MyColor.colorBlack
                                            .withOpacity(0.8)),
                                    contentPadding:
                                        const EdgeInsets.only(top: -5),
                                    border: InputBorder.none,

                                    //  const UnderlineInputBorder(
                                    //     borderSide: BorderSide(
                                    //         color: MyColor.dividerColor)),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    fillColor: Colors.grey.shade300,
                                    filled: true),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.space20,
                          ),
                          CustomTextFormField(
                            labelText: MyStrings.amount,
                            textInputType: TextInputType.number,
                            controller: controller.amountController,
                            onChanged: (value) {
                              if (value.toString().isEmpty) {
                                controller.changeInfoWidgetValue(0);
                              } else {
                                double amount =
                                    double.tryParse(value.toString()) ?? 0;
                                controller.changeInfoWidgetValue(amount);
                              }
                            },
                          ),
                          const SizedBox(height: Dimensions.space20),
                          controller.mainAmount > 0
                              ? const InfoWidget()
                              : const SizedBox(),
                          const SizedBox(height: 35),
                          controller.submitLoading
                              ? const RoundedLoadingBtn()
                              : RoundedButton(
                                  text: MyStrings.submit.tr,
                                  textColor: MyColor.textColor,
                                  width: double.infinity,
                                  press: () {
                                    controller.submitDeposit();
                                  },
                                )
                        ],
                      )),
                ),
        ),
      ),
    );
  }
}
