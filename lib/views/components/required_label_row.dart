import 'package:flutter/material.dart';
import 'package:alwegdany/core/utils/style.dart';
import '../../../../core/utils/my_color.dart';

class RequiredLabelRow extends StatelessWidget {
  const RequiredLabelRow({Key? key, required this.label, this.required = true})
      : super(key: key);
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        required
            ? Text(
                ' *',
                style: interNormalLarge.copyWith(
                    color: MyColor.redCancelTextColor),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
