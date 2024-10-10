import 'package:flutter/material.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'customButton.dart';

class OnBoardingBottomButtons extends StatelessWidget {
  VoidCallback onSkip;
  VoidCallback onContinue;
  OnBoardingBottomButtons(
      {super.key, required this.onSkip, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomButton(
                onTap: onSkip,
                buttonText: 'Skip',
                backgroundColor: Colors.white,
                borderColor: MyColor.primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomButton(
                onTap: onContinue,
                backgroundColor: MyColor.primaryColor,
                buttonText: 'Continue',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
