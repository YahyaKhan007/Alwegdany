import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {

  final bool isActive;
  final Color activeColor, inactiveColor;
  final Duration duration;
  final Function? onChanged;

  const CustomIndicator({

    Key? key,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.duration,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(

      duration: duration,
      width: isActive ? 16.0 : 16.0,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10.0,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}

