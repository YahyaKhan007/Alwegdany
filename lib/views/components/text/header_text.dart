import 'package:flutter/cupertino.dart';
import 'package:alwegdany/core/utils/dimensions.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/style.dart';

class HeaderText extends StatelessWidget {
  const HeaderText(
      {Key? key, required this.text, this.textStyle, this.isChange = false})
      : super(key: key);
  final String text;
  final bool isChange;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: isChange
            ? interSemiBoldLarge.copyWith(
                fontSize: Dimensions.fontLarge, color: MyColor.colorWhite)
            : interSemiBoldLarge.copyWith(
                fontSize: Dimensions.fontLarge, color: MyColor.colorWhite));
  }
}
