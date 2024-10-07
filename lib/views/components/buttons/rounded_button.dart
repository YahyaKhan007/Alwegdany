import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/style.dart';
import '../../../../core/utils/dimensions.dart';

import '../../../../../core/utils/my_color.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  const RoundedButton(
      {Key? key,
      this.width = 1,
      required this.text,
      required this.press,
      this.color = MyColor.primaryColor,
      this.textColor = Colors.white,
      this.horizontalPadding = 35,
      this.verticalPadding = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              textStyle: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
          child: Text(
            text.tr,
            style: interNormalDefault.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
