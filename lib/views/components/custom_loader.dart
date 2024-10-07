import 'package:flutter/material.dart';
import 'package:signal_lab/core/utils/my_color.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(color: MyColor.primaryColor);
  }
}