import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/dimensions.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/style.dart';

class UserInfoField extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const UserInfoField(
      {Key? key, required this.icon, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.space10 + 2, horizontal: Dimensions.space15),
      decoration: BoxDecoration(
          color: MyColor.primaryColor, borderRadius: BorderRadius.circular(5)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 20,
              width: 20,
              color: Colors.white,
            ),
            const SizedBox(width: Dimensions.space15),
            const SizedBox(
                height: 25,
                child:
                    VerticalDivider(color: MyColor.dividerColor, thickness: 1)),
            const SizedBox(width: Dimensions.space15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.tr,
                  style: interNormalSmall.copyWith(
                      color: MyColor.colorWhite, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: Dimensions.space5),
                Text(
                  value,
                  style: interNormalDefault.copyWith(color: MyColor.colorWhite),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
