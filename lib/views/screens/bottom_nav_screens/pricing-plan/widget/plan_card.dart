import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/my_images.dart';
import 'package:alwegdany/core/utils/my_strings.dart';
import 'package:alwegdany/core/utils/style.dart';
import 'package:alwegdany/views/components/buttons/rounded_button.dart';
import 'package:alwegdany/views/components/divider/custom_divider.dart';

class PlanCard extends StatelessWidget {
  final String cardName, price, packageTime;
  final List<String> featureList;
  final VoidCallback onPressed;

  const PlanCard({
    Key? key,
    required this.cardName,
    required this.price,
    required this.packageTime,
    required this.featureList,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(1, 1),
                  blurRadius: 5,
                  spreadRadius: 5),
            ],
            color: MyColor.backgroundColor,
            borderRadius: BorderRadius.circular(8)),
        child: Theme(
          data: Theme.of(context).copyWith(
              scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(Colors.red),
          )),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        15,
                      ),
                      topRight: Radius.circular(
                        15,
                      ),
                    ),
                    color: MyColor.primaryColor,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(cardName,
                            textAlign: TextAlign.center,
                            style: interNormalDefault.copyWith(
                                color: MyColor.backgroundColor)),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: price,
                                style: interNormalOverLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: ' / ',
                                style: interNormalDefault.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: packageTime,
                                style: interNormalDefault.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ]),
                        ),
                      ]),
                ),
              ),
              // const CustomDivider(),
              const Divider(
                height: 1,
                color: Colors.white,
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 4,
                child: Scrollbar(
                  child: ListView.separated(
                    itemCount: featureList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 30),
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/tick.png',
                          height: 17,
                          width: 17,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(featureList[index],
                              style: interNormalDefault.copyWith(
                                  color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RoundedButton(
                    color: MyColor.primaryColor,
                    text: MyStrings.choosePlan,
                    press: onPressed),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ));
  }
}
