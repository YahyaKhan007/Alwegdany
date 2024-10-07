import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/views/components/divider/custom_divider.dart';

class CustomDepositCard extends StatelessWidget {
  final String trxData;
  final String initiatedData;
  final String gatewayData;
  final String conversionData;
  final String amountData;
  final String statusData;
  final Color statusColor;
  final String amountConversion;

  const CustomDepositCard({
    Key? key,
    required this.trxData,
    required this.initiatedData,
    required this.gatewayData,
    required this.conversionData,
    required this.amountData,
    required this.statusData,
    required this.amountConversion,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: MyColor.primaryColor, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(MyStrings.trx,
                      style: interNormalSmall.copyWith(
                          color: MyColor.colorWhite.withOpacity(0.8))),
                  const SizedBox(height: Dimensions.space5),
                  Text(trxData,
                      style: interNormalDefault.copyWith(
                          color: MyColor.colorWhite))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(MyStrings.initiated.tr,
                      style: interNormalSmall.copyWith(
                          color: MyColor.colorWhite.withOpacity(0.8))),
                  const SizedBox(height: Dimensions.space5),
                  Text(initiatedData,
                      style: interNormalDefault.copyWith(
                          color: MyColor.colorWhite))
                ],
              )
            ],
          ),
          const CustomDivider(space: Dimensions.space10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(MyStrings.amount.tr,
                          style: interNormalSmall.copyWith(
                              color: MyColor.colorWhite.withOpacity(0.8))),
                      const SizedBox(height: Dimensions.space5),
                      Text(amountData.tr,
                          style: interNormalDefault.copyWith(
                              color: MyColor.colorWhite))
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(MyStrings.gateway.tr,
                      style: interNormalSmall.copyWith(
                          color: MyColor.colorWhite.withOpacity(0.8))),
                  const SizedBox(height: 8),
                  Text(gatewayData.tr,
                      style: interNormalDefault.copyWith(
                          color: MyColor.colorWhite))
                ],
              )
            ],
          ),
          const CustomDivider(space: Dimensions.space10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("${MyStrings.conversion.tr}: ",
                          style: interNormalSmall.copyWith(
                              color: MyColor.colorWhite.withOpacity(0.8))),
                      Text("($amountConversion)",
                          style: interNormalExtraSmall.copyWith(
                              color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Text(conversionData,
                      style: interNormalDefault.copyWith(
                          color: MyColor.colorWhite))
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: MyColor.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: statusColor, width: 0.5)),
                child: Text(statusData.tr,
                    style: interNormalExtraSmall.copyWith(color: statusColor),
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ],
      ),
    );
  }
}
