import 'package:flutter/material.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';

class CustomTextFormField2 extends StatefulWidget {
  final String? hintText, labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isSuffix;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final Function onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final bool isSearch;
  final VoidCallback? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final String? errorText;
  final VoidCallback? onTap;

  const CustomTextFormField2({
    Key? key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSuffixTap,
    this.onTap,
    this.validator,
    this.fillColor = MyColor.backgroundColor,
    this.onSubmit,
    required this.onChanged,
    this.capitalization = TextCapitalization.none,
    this.isCountryPicker = false,
    this.isShowBorder = false,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.isSuffix = false,
    this.isIcon = false,
    this.isPassword = false,
    this.suffixIconUrl,
    this.prefixIconUrl,
    this.errorText,
    this.isSearch = false,
  }) : super(key: key);

  @override
  State<CustomTextFormField2> createState() => _CustomTextFormField2State();
}

class _CustomTextFormField2State extends State<CustomTextFormField2> {
  bool _obscureText = true;
  bool isFocused = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: interNormalDefault.copyWith(color: Colors.black),
      textAlign: TextAlign.left,
      cursorColor: Colors.black,
      controller: widget.controller,
      autofocus: false,
      focusNode: widget.focusNode,
      validator: widget.validator,
      maxLines: widget.maxLines,
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColor.backgroundColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        labelText: widget.labelText,
        labelStyle: interNormalDefault.copyWith(
            color: Colors.black,
            fontSize: widget.focusNode != null && widget.focusNode!.hasFocus
                ? Dimensions.fontLarge
                : Dimensions.fontDefault),
        hintText: widget.hintText,
        hintStyle: interNormalSmall.copyWith(color: MyColor.hintTextColor),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.dividerColor, width: 0.5)),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 0.5),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 0.5),
        ),
        suffix: widget.isSuffix
            ? Container(
                width: 50,
                color: const Color(0xffE0F0FD),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(Dimensions.space10 / 2),
                child: Text("USD",
                    style:
                        interNormalSmall.copyWith(color: MyColor.primaryColor)),
              )
            : const SizedBox(),
        isDense: true,
        prefixIcon: widget.isShowPrefixIcon
            ? Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.space20, right: Dimensions.space10 / 2),
                // child: Image.asset(widget.prefixIconUrl),
                child: Image.asset(""),
              )
            : const SizedBox.shrink(),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, maxHeight: 0),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: MyColor.hintTextColor),
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
      onTap: widget.onTap,
      onFieldSubmitted: (text) => widget.nextFocus != null
          ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null
              ? widget.onSubmit!()
              : null,
      onChanged: (text) => widget.onChanged(text),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
