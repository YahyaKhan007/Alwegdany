import 'package:flutter/material.dart';
import 'package:alwegdany/core/utils/my_color.dart';

class SearchBtn extends StatelessWidget {
  final VoidCallback press;

  const SearchBtn({Key? key, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: 45,
        width: 45,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: MyColor.primaryColor,
        ),
        child: const Icon(Icons.search_outlined,
            color: MyColor.colorWhite, size: 18),
      ),
    );
  }
}
