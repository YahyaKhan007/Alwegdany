import 'package:flutter/material.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';




class ChipWidget extends StatelessWidget {
  const ChipWidget({
       Key? key,
       required this.name,
       required this.hasError
  }) : super(key: key);

  final String name;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          avatar: Icon(hasError?Icons.cancel:Icons.check_circle,color: hasError?Colors.red:Colors.green,size: 15,),

          label: Text(
            name,
            style: interNormalDefault.copyWith(
              fontSize: Dimensions.fontExtraSmall,
              color: hasError?Colors.red:Colors.green,
            ),
          ),
          backgroundColor: MyColor.cardBgColor,
        ),
        const SizedBox(width: 5,),
      ],
    );
  }
}