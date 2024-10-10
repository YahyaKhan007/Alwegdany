import 'package:flutter/material.dart';
import 'package:alwegdany/core/utils/dimensions.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/style.dart';

class SmallText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const SmallText(
      {Key? key,
      required this.title,
      this.fontSize = Dimensions.fontDefault,
      this.textColor = MyColor.colorWhite,
      this.fontWeight = FontWeight.w400,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: textAlign,
        style: interNormalDefault.copyWith(
          color: Colors.black,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ));
  }
}
