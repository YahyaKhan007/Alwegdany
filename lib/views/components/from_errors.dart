import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/core/utils/style.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/dimensions.dart';


class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) =>Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            SvgPicture.asset(
              MyImages.errorIcon,
              height: 16,
              width: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              errors[index]??'',
              style: interNormalLarge.copyWith(color: MyColor.colorWhite,
              fontSize: Dimensions.fontSmall)
            ),
          ],
        ),
      )),
    );
  }


}