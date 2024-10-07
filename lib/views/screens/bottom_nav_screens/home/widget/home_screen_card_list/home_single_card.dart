import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';

class HomeSingleCard extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String imageUrl;
  final VoidCallback press;
  final bool isSvg;

  const HomeSingleCard(
      {Key? key,
      required this.firstText,
      required this.secondText,
      required this.imageUrl,
      required this.press,
      this.isSvg = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        // elevation: 5,
        child: Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              color: MyColor.primaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.08),
                    shape: BoxShape.circle,
                  ),
                  child: isSvg
                      ? SvgPicture.asset(imageUrl,
                          height: 15, width: 15, color: Colors.white)
                      : Image.asset(
                          imageUrl,
                          height: 15,
                          width: 15,
                          color: Colors.white,
                        )),
              const SizedBox(height: 10),
              Text(
                firstText,
                style: interNormalDefaultLarge.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Text(
                secondText.tr,
                style:
                    interNormalSmall.copyWith(color: Colors.white, fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
