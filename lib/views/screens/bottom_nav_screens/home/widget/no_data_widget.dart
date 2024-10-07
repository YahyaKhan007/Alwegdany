import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';

class NoDataWidget extends StatelessWidget {
  final double topMargin;
  final double bottomMargin;
  final String title;
  final double imageHeight;
  const NoDataWidget(
      {Key? key,
      this.topMargin = 0,
      this.title = MyStrings.noDataFound,
      this.imageHeight = 150,
      this.bottomMargin = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColor.backgroundColor,
      elevation: 10,
      child: Container(
        width: double.infinity,
        // margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.cornerRadius)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: imageHeight,
              child: SvgPicture.asset(
                MyImages.noDataIcon,
                height: imageHeight,
                fit: BoxFit.cover,
                width: 200,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: interSemiBoldLarge.copyWith(
                  color: Colors.white.withOpacity(.6),
                  fontSize: Dimensions.fontDefault),
            )
          ],
        ),
      ),
    );
  }
}
