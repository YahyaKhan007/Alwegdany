import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/helper/my_converter.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/model/plan/plan_model.dart';
import 'package:signal_lab/views/components/buttons/rounded_button.dart';
import 'package:signal_lab/views/components/buttons/rounded_loading_button.dart';
import 'package:signal_lab/views/components/divider/custom_divider.dart';

import '../../../../../data/controller/plan_controller/plan_controller.dart';
import '../../../../../data/repo/plan_repo/plan_repo.dart';
import '../../../../../data/services/api_service.dart';

class PlanBottomSheet {
  static void showBottomSheet(BuildContext context, int index,
      PackageData packageData, String currency, String balance) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (context) {
          // return SingleChildScrollView(
          //   physics: const ClampingScrollPhysics(),
          //   child: Container(
          //     width: MediaQuery
          //         .of(context)
          //         .size
          //         .width,
          //     padding: const EdgeInsets.symmetric(
          //         vertical: Dimensions.space10,
          //         horizontal: Dimensions.space15),
          //     decoration: const BoxDecoration(
          //         color: MyColor.backgroundColor,
          //         borderRadius:
          //         BorderRadius.vertical(top: Radius.circular(15))),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Align(
          //               alignment: Alignment.topCenter,
          //               child: Container(
          //                 height: 4,
          //                 width: 50,
          //                 margin: const EdgeInsets.only(top: 6),
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(5),
          //                     color: Colors.white.withOpacity(0.1)),
          //               ),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: Dimensions.space15),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Flexible(
          //               child: Text(
          //                 "${MyStrings.areYourSureToBuy.tr} ${packageData.name}",
          //                 overflow: TextOverflow.ellipsis,
          //                 maxLines: 2,
          //                 style: interNormalDefaultLarge.copyWith(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //             GestureDetector(
          //               onTap: () {
          //                 Get.back();
          //               },
          //               child: Container(
          //                 height: 30,
          //                 width: 30,
          //                 alignment: Alignment.center,
          //                 decoration: BoxDecoration(
          //                     color: Colors.white.withOpacity(0.1),
          //                     shape: BoxShape.circle),
          //                 child: SvgPicture.asset(
          //                   MyImages.closeIcon,
          //                   width: 15,
          //                   height: 15,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //         const CustomDivider(),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Expanded(
          //               flex: 5,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     MyStrings.package.tr,
          //                     style: interNormalSmall.copyWith(
          //                         color: Colors.black.withOpacity(0.8)),
          //                   ),
          //                   const SizedBox(height: Dimensions.space5),
          //                   Text(
          //                     packageData.price ?? "",
          //                     // "Package Price",
          //                     style: interNormalDefault.copyWith(
          //                         color: MyColor.colorBlack,
          //                         fontWeight: FontWeight.w500),
          //                   )
          //                 ],
          //               ),
          //             ),
          //             Expanded(
          //               flex: 2,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     MyStrings.price.tr,
          //                     style: interNormalSmall.copyWith(
          //                         color: Colors.black.withOpacity(0.8)),
          //                   ),
          //                   const SizedBox(height: Dimensions.space5),
          //                   Text(
          //                     "${packageData.price ?? ""} $currency",
          //                     style: interNormalDefault.copyWith(
          //                         color: Colors.black,
          //                         fontWeight: FontWeight.w500),
          //                   )
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //         const SizedBox(height: Dimensions.space15),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Expanded(
          //               flex: 5,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     MyStrings.validity.tr,
          //                     style: interNormalSmall.copyWith(
          //                         color: Colors.black.withOpacity(0.8)),
          //                   ),
          //                   const SizedBox(height: Dimensions.space5),
          //                   Text(
          //                     "${packageData.validity ?? ""} ${MyStrings.days.tr}",
          //                     style: interNormalDefault.copyWith(
          //                         color: Colors.black,
          //                         fontWeight: FontWeight.w500),
          //                   )
          //                 ],
          //               ),
          //             ),
          //             Expanded(
          //               flex: 2,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     MyStrings.yourBalance.tr,
          //                     style: interNormalSmall.copyWith(
          //                         color: Colors.black.withOpacity(0.8)),
          //                   ),
          //                   const SizedBox(height: Dimensions.space5),
          //                   Text(
          //                     "${MyConverter.twoDecimalPlaceFixedWithoutRounding(
          //                         balance.toString())} $currency",
          //                     style: interNormalDefault.copyWith(
          //                         color: Colors.black,
          //                         fontWeight: FontWeight.w500),
          //                   )
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //         const CustomDivider(),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Expanded(
          //               child: RoundedButton(
          //                 color: Colors.black.withOpacity(.3),
          //                 text: MyStrings.close,
          //                 textColor: Colors.black,
          //                 verticalPadding: 14,
          //                 press: () {
          //                   Get.back();
          //                 },
          //               ),
          //             ),
          //             const SizedBox(
          //               width: 30,
          //             ),
          //             Expanded(
          //                 child: /* packageData.purchaseLoading*/ false
          //                     ? const RoundedLoadingBtn(
          //                   color: MyColor.greenP,
          //                   verticalPadding: 14,
          //                 )
          //                     : RoundedButton(
          //                   color: MyColor.greenP,
          //                   text: MyStrings.confirm,
          //                   verticalPadding: 14,
          //                   textColor: MyColor.colorWhite,
          //                   press: () async {
          //                     // await controller.purchasePackage(
          //                     //     packageId: controller
          //                     //         .packageList[index]
          //                     //         .id ??
          //                     //         0,
          //                     //     index: index);
          //                   },
          //                 ))
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // );
          return GetBuilder<PlanController>(
              init: Get.find<PlanController>(),
              builder: (controller) => SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.space10,
                          horizontal: Dimensions.space15),
                      decoration: const BoxDecoration(
                          color: MyColor.backgroundColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  margin: const EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white.withOpacity(0.1)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.space15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "${MyStrings.areYourSureToBuy.tr} ${packageData.name}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: interNormalDefaultLarge.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              GestureDetector(
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
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const CustomDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      MyStrings.package.tr,
                                      style: interNormalSmall.copyWith(
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    const SizedBox(height: Dimensions.space5),
                                    Text(
                                      packageData.price ?? "",
                                      // "Package Price",
                                      style: interNormalDefault.copyWith(
                                          color: MyColor.colorBlack,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      MyStrings.price.tr,
                                      style: interNormalSmall.copyWith(
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    const SizedBox(height: Dimensions.space5),
                                    Text(
                                      "${packageData.price ?? ""} ${controller.currency}",
                                      style: interNormalDefault.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: Dimensions.space15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      MyStrings.validity.tr,
                                      style: interNormalSmall.copyWith(
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    const SizedBox(height: Dimensions.space5),
                                    Text(
                                      "${packageData.validity ?? ""} ${MyStrings.days.tr}",
                                      style: interNormalDefault.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      MyStrings.yourBalance.tr,
                                      style: interNormalSmall.copyWith(
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    const SizedBox(height: Dimensions.space5),
                                    Text(
                                      "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.balance.value)} ${controller.currency}",
                                      style: interNormalDefault.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const CustomDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: RoundedButton(
                                  color: Colors.black.withOpacity(.3),
                                  text: MyStrings.close,
                                  textColor: Colors.black,
                                  verticalPadding: 14,
                                  press: () {
                                    Get.back();
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                  child: controller.purchaseLoading
                                      ? const RoundedLoadingBtn(
                                          color: MyColor.greenP,
                                          verticalPadding: 14,
                                        )
                                      : RoundedButton(
                                          color: MyColor.greenP,
                                          text: MyStrings.confirm,
                                          verticalPadding: 14,
                                          textColor: MyColor.colorWhite,
                                          press: () async {
                                            await controller.purchasePackage(
                                                packageId: controller
                                                        .packageList[index]
                                                        .id ??
                                                    0,
                                                index: index);
                                          },
                                        ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
        });
    // });
  }
}
