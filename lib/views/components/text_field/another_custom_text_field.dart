import 'package:flutter/material.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';

class AnotherCustomTextField extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isShowSuffixView;
  final bool isShowBorder;
  final bool fromRight;
  final String? prefixWidgetValue;

  const AnotherCustomTextField({
    Key? key,
    required this.child,
    required this.onTap,
    this.isShowBorder = true,
    this.isShowSuffixView = false,
    this.prefixWidgetValue,
    this.fromRight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            color: MyColor.backgroundColor,
            border: Border(
                bottom: BorderSide(color: MyColor.dividerColor, width: 0.5))),
        child: isShowSuffixView
            ? IntrinsicHeight(
                child: fromRight
                    ? Row(children: [
                        Expanded(child: child),
                        Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration:
                              const BoxDecoration(color: MyColor.primaryColor),
                          child: Text(
                            prefixWidgetValue ?? '',
                            style:
                                interNormalSmall.copyWith(color: Colors.black),
                          ),
                        ),
                      ])
                    : Row(children: [
                        Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MyColor.primaryColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(prefixWidgetValue ?? '',
                              style: interNormalSmall.copyWith(
                                  color: MyColor.colorWhite)),
                        ),
                        const SizedBox(width: Dimensions.space10),
                        Expanded(child: child)
                      ]),
              )
            : child,
      ),
    );
  }
}
