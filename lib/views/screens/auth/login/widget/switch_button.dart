import 'package:flutter/material.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/auth/login/login_controller.dart';

class SwitchButton extends StatelessWidget {
  final LoginController controller;

  const SwitchButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 23,
          height: 25,
          child: Checkbox(
              activeColor: MyColor.primaryColor,
              value: controller.remember,
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(
                    width: 1.0,
                    color: controller.remember
                        ? MyColor.transparentColor
                        : MyColor.colorGrey),
              ),
              onChanged: (value) {
                controller.changeRememberMe();
              }),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          MyStrings.rememberMe,
          style: interNormalDefault.copyWith(color: MyColor.primaryColor),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
