import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/transaction/transaction_controller.dart';
import 'package:signal_lab/views/components/animated_widget/expanded_widget.dart';
import 'package:signal_lab/views/components/divider/custom_divider.dart';

class CustomTransactionCard extends StatelessWidget {
  final String trxData;
  final String dateData;
  final String amountData;
  final String detailsText;
  final String postBalanceData;
  final int index;

  const CustomTransactionCard(
      {Key? key,
      required this.index,
      required this.trxData,
      required this.dateData,
      required this.amountData,
      required this.postBalanceData,
      required this.detailsText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.changeTrxIndex(index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
          decoration: BoxDecoration(
              color: MyColor.primaryColor,
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(MyStrings.trx.tr,
                          style: interNormalExtraSmall.copyWith(
                              color: MyColor.colorWhite)),
                      const SizedBox(height: 2),
                      Text(trxData,
                          style: interNormalDefault.copyWith(
                              color: MyColor.colorWhite))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(MyStrings.date.tr,
                          style: interNormalExtraSmall.copyWith(
                              color: MyColor.colorWhite)),
                      const SizedBox(height: 2),
                      Text(dateData.tr,
                          style: interNormalDefault.copyWith(
                              color: MyColor.colorWhite,
                              fontStyle: FontStyle.italic))
                    ],
                  )
                ],
              ),
              const CustomDivider(space: Dimensions.space15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(MyStrings.amount.tr,
                          style: interNormalExtraSmall.copyWith(
                              color: MyColor.colorWhite)),
                      const SizedBox(height: 8),
                      Text(amountData,
                          style: interNormalDefault.copyWith(
                              color: changeTextColor(
                                  controller.transactionList[index].trxType
                                      .toString(),
                                  controller)))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(MyStrings.postBalance.tr,
                          style: interNormalExtraSmall.copyWith(
                              color: MyColor.colorWhite)),
                      const SizedBox(height: 8),
                      Text(postBalanceData,
                          style: interNormalDefault.copyWith(
                              color: MyColor.colorWhite))
                    ],
                  )
                ],
              ),
              ExpandedSection(
                  expand: controller.selectedTrxIndex == index,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomDivider(space: Dimensions.space15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(MyStrings.details.tr,
                              style: interNormalExtraSmall.copyWith(
                                  color: MyColor.colorWhite)),
                          const SizedBox(height: 8),
                          Text(detailsText.tr,
                              style: interNormalDefault.copyWith(
                                  color: MyColor.colorWhite))
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Color changeTextColor(String trxType, TransactionController controller) {
    trxType = controller.transactionList[index].trxType ?? "";
    return trxType == "-" ? Colors.black : Colors.black;
  }
}
