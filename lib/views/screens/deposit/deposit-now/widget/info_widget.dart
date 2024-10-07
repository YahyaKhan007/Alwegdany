import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/data/controller/deposit_controller/new_deposit_controller.dart';

import 'custom_row.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewDepositController>(builder: (controller){
      bool showRate = controller.isShowRate();
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MyColor.appBarBgColor,
          borderRadius: BorderRadius.circular(Dimensions.space10),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            CustomRow(firstText: MyStrings.depositLimit, lastText: controller.depositLimit,),
            CustomRow(firstText: MyStrings.charge, lastText: controller.charge,),
            CustomRow(firstText: MyStrings.payable, lastText: controller.payableText,showDivider: showRate,),
            showRate?CustomRow(firstText: MyStrings.conversionRate, lastText: controller.conversionRate,showDivider: showRate,): const SizedBox.shrink(),
            showRate?CustomRow(firstText: 'in ${controller.paymentMethod?.currency}', lastText: controller.inLocal,showDivider: false,):const SizedBox.shrink(),
            const SizedBox(height: 10,),
          ],
        ),
      );
    });
  }
}
