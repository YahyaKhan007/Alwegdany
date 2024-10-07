import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/my_strings.dart';
import 'package:signal_lab/core/helper/my_converter.dart';
import 'package:signal_lab/core/route/route.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/my_images.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/bottom_nav/home/home_controller.dart';
import 'package:signal_lab/data/controller/plan_controller/plan_controller.dart';
import 'package:signal_lab/data/model/plan/plan_model.dart';

import '../../../../../data/repo/plan_repo/plan_repo.dart';

class HomeScreenTop extends StatelessWidget {
  final HomeController controller;
  const HomeScreenTop({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var planController =
        Get.put(PlanController(planRepo: PlanRepo(apiClient: Get.find())));
    log(controller.balance);
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
        builder: (controller) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Image.asset('assets/images/notification.png')),
                    SizedBox(
                        height: size.height * 0.1,
                        child: Image.asset('assets/images/app_logo.png')),
                    // const CircleAvatar(
                    //   radius: 20,
                    //   backgroundImage:
                    //       AssetImage('assets/images/profile_pic.png'),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  color: MyColor.backgroundColor,
                  elevation: 0,
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColor.greenColor),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Obx(
                              () => Text(
                                "${MyConverter.twoDecimalPlaceFixedWithoutRounding(planController.balance.value)}${controller.currencySymbol}",
                                style: interNormalDefaultLarge.copyWith(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              'assets/images/bit_coin.png',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              // 'طَرد'.tr,
                              controller.packageName,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const Text(
                              ' : ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              // ' 3 اشهر'.tr,
                              controller.packageTime,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'عدد توصيات التي حصلت عليها'.tr,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const Text(
                              ' : ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              // ' 7 ',
                              controller.totalSignal,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       height: 29,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(10),
                        //           color: Colors.white.withOpacity(0.2)),
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 6, horizontal: 12),
                        //       child: GestureDetector(
                        //         onTap: () {},
                        //         child: Center(
                        //           child: Text(
                        //             'ينسحب'.tr,
                        //             style: const TextStyle(fontSize: 13),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 15,
                        //     ),
                        //     Container(
                        //       height: 29,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(10),
                        //           color: Colors.white.withOpacity(0.2)),
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 6, horizontal: 12),
                        //       child: GestureDetector(
                        //         onTap: () {},
                        //         child: Center(
                        //           child: Text(
                        //             'إيداع'.tr,
                        //             style: const TextStyle(fontSize: 13),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Column(
                        //       children: [
                        //         // ^ ***************************
                        //         // ^ ***************************
                        //         // ^ ***************************
                        //         // ^ ***************************
                        //         // ^ ***************************
                        //         Row(
                        //           children: [
                        //             Container(
                        //                 height: 40,
                        //                 width: 40,
                        //                 alignment: Alignment.center,
                        //                 decoration: BoxDecoration(
                        //                   color: Colors.black.withOpacity(.08),
                        //                   shape: BoxShape.circle,
                        //                 ),
                        //                 child: SvgPicture.asset(
                        //                     MyImages.totalBalanceIcon,
                        //                     height: 20,
                        //                     width: 20)),
                        //             const SizedBox(width: 20),
                        //             Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   "${controller.currencySymbol} ${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.balance)}",
                        //                   style: interNormalDefaultLarge.copyWith(
                        //                       color: Colors.lightBlue,
                        //                       fontWeight: FontWeight.w600),
                        //                 ),
                        //                 const SizedBox(height: 5),
                        //                 Text(
                        //                   MyStrings.totalBalance,
                        //                   style: interNormalSmall.copyWith(
                        //                       color: Colors.black),
                        //                 ),
                        //               ],
                        //             )
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         Get.toNamed(RouteHelper.depositNowScreen);
                        //       },
                        //       child: Container(
                        //           height: 30,
                        //           width: 30,
                        //           alignment: Alignment.center,
                        //           decoration: BoxDecoration(
                        //             color: Colors.black.withOpacity(0.08),
                        //             shape: BoxShape.circle,
                        //           ),
                        //           child: const Icon(Icons.add,
                        //               color: Colors.black, size: 15)),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
