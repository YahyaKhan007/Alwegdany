import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/views/components/divider/custom_divider.dart';

class SignalListBottomSheet {
  static void showBottomSheet(BuildContext context,
      {required String signalName,
      required String time,
      required String signalDetails}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (controller) => SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                      color: MyColor.primaryColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              MyImages.closeIcon,
                              width: 15,
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 4,
                                  width: 50,
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white.withOpacity(0.1)),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: Dimensions.space15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            signalName,
                                            style: interNormalDefaultLarge
                                                .copyWith(
                                                    color: MyColor.colorWhite,
                                                    fontWeight:
                                                        FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            time,
                                            style: interNormalDefault.copyWith(
                                                color: MyColor.colorWhite
                                                    .withOpacity(0.8)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const CustomDivider(space: 20),
                                Text(
                                  signalDetails,
                                  style: interNormalDefault.copyWith(
                                      color: MyColor.backgroundColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ));
  }
}
