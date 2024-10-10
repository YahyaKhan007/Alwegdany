import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/style.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final bool isSearch;
  final bool isCountryPicker;
  final bool readonly;
  final TextInputAction inputAction;

  const CustomTextFormField({
    Key? key,
    this.labelText,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.readonly = false,
    this.inputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        readOnly: widget.readonly,
        style: interNormalDefault.copyWith(color: Colors.black),
        textAlign: TextAlign.left,
        cursorColor: Colors.black,
        controller: widget.controller,
        autofocus: false,
        textInputAction: widget.inputAction,
        enabled: widget.isEnable,
        focusNode: widget.focusNode,
        validator: widget.validator,
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword ? obscureText : false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
          labelText: widget.labelText!.tr,
          labelStyle: interNormalDefault.copyWith(
            color: Colors.black,
          ),
          hintText: widget.hintText?.tr,
          hintStyle: interNormalSmall.copyWith(
            color: Colors.black,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          // const UnderlineInputBorder(
          //     borderSide: BorderSide(color: MyColor.dividerColor)),
          // focusedBorder: const UnderlineInputBorder(
          //     borderSide: BorderSide(color: MyColor.dividerColor)),
          // enabledBorder: const UnderlineInputBorder(
          //     borderSide: BorderSide(color: MyColor.dividerColor)),
          suffixIcon: widget.isShowSuffixIcon
              ? widget.isPassword
                  ? IconButton(
                      icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: MyColor.hintTextColor,
                          size: 20),
                      onPressed: _toggle)
                  : widget.isIcon
                      ? IconButton(
                          onPressed: widget.onSuffixTap,
                          icon: Icon(
                            widget.isSearch
                                ? Icons.search_outlined
                                : widget.isCountryPicker
                                    ? Icons.arrow_drop_down_outlined
                                    : Icons.camera_alt_outlined,
                            size: 25,
                            color: MyColor.primaryColor,
                          ),
                        )
                      : null
              : null,
        ),
        onFieldSubmitted: (text) => widget.nextFocus != null
            ? FocusScope.of(context).requestFocus(widget.nextFocus)
            : null,
        onChanged: (text) => widget.onChanged!(text.tr),
      ),
    );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
