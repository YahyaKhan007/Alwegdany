import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/data/controller/deposit_controller/deposit_controller.dart';
import 'package:signal_lab/views/components/search_button.dart';
import 'package:signal_lab/views/components/search_text_field.dart';

class DepositHistoryTop extends StatefulWidget {
  const DepositHistoryTop({Key? key}) : super(key: key);

  @override
  State<DepositHistoryTop> createState() => _DepositHistoryTopState();
}

class _DepositHistoryTopState extends State<DepositHistoryTop> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: SearchTextField(
                        controller: controller.searchController,
                        hintText: MyStrings.searchByTransactions.tr)),
              ],
            ),
          ),
          const SizedBox(width: Dimensions.space10),
          SearchBtn(
            press: () {
              controller.filterData();
            },
          )
        ],
      ),
    );
  }
}
