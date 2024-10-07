import 'package:flutter/material.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';

class CustomDropDownTextField extends StatefulWidget {

  final Object selectedValue;
  final String labelText, hintText;
  final Function(Object?)? onChanged;
  final List<DropdownMenuItem<Object>>? items;

  const CustomDropDownTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.selectedValue,
    required this.onChanged,
    required this.items
  }) : super(key: key);

  @override
  State<CustomDropDownTextField> createState() => _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: interNormalDefault.copyWith(color: MyColor.colorWhite.withOpacity(0.8)),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField(
            value: widget.selectedValue,
            dropdownColor: MyColor.cardBgColor,
            hint: Text(widget.hintText, style: interNormalExtraSmall.copyWith(color: MyColor.colorWhite)),
            style: interNormalSmall.copyWith(color: MyColor.colorWhite),
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                border: UnderlineInputBorder(borderSide: BorderSide(color: MyColor.dividerColor)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColor.dividerColor)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColor.dividerColor)),
                fillColor: MyColor.backgroundColor,
                filled: true
            ),
            isExpanded: false,
            onChanged: widget.onChanged,
            items: widget.items
        )
      ],
    );
  }
}