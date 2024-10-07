import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? borderColor; // Make borderColor nullable
  final Color backgroundColor;
  final VoidCallback onTap;
  final String buttonText;
  final double buttonLength;
  final double? buttonHeight; // Nullable height
  final double? circularRadius; // Nullable circular radius

  // Set default values for the parameters
  const CustomButton({
    super.key,
    this.borderColor, // Nullable borderColor
    this.backgroundColor = Colors.grey,
    required this.onTap,
    this.buttonText = 'Button',
    this.buttonLength = 150.0,
    this.buttonHeight, // Nullable height
    this.circularRadius, // Nullable circular radius
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: buttonHeight ?? 50.0,
        width: buttonLength,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(circularRadius ?? 25.0),
          border: borderColor != null
              ? Border.all(color: borderColor!)
              : Border.all(
                  color:
                      Colors.transparent), // Use transparent if no borderColor
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.black, // Use black if no borderColor
              fontSize: 15.48,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
