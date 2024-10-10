// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/style.dart';

class IconWithTextWidget extends StatelessWidget {
  final String icon;
  final String text;

  const IconWithTextWidget({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('icon: ---------$icon');
    return Row(
      children: [
        icon.contains('svg')
            ? SvgPicture.asset(icon,
                color: MyColor.backgroundColor.withOpacity(.9),
                height: 22,
                width: 22,
                fit: BoxFit.cover)
            : Image.asset(icon,
                fit: BoxFit.cover,
                color: MyColor.backgroundColor.withOpacity(.9),
                height: 22,
                width: 22),
        const SizedBox(width: 25),
        Text(text,
            style: interNormalDefault.copyWith(
                color: MyColor.colorWhite, fontWeight: FontWeight.w500))
      ],
    );
  }
}
