import 'package:flutter/material.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/style.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {Key? key, required this.controller, required this.hintText})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: MyColor.primaryColor,
      style: interNormalSmall.copyWith(color: Colors.black),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: hintText, //,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintStyle: interNormalSmall.copyWith(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5))),
    );
  }
}
