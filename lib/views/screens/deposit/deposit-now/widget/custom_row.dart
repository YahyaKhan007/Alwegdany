import 'package:flutter/material.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';

class CustomRow extends StatelessWidget {

  const CustomRow({
  Key? key,
  required this.firstText,
  required this.lastText,
  this.showDivider = true
  }) : super(key: key);

  final String firstText,lastText;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(firstText,style: interNormalDefault,overflow: TextOverflow.ellipsis,maxLines: 1,)),
            Flexible(child:Text(lastText,maxLines:2,style:interNormalDefault.copyWith(color: MyColor.colorWhite),overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,))
          ],
        ),
        const SizedBox(height: 5,),
        showDivider?  const Divider(color: MyColor.borderColor,thickness: .3,) : const SizedBox(),
        showDivider? const SizedBox(height: 5,) : const SizedBox(),
      ],
    );
  }
}
