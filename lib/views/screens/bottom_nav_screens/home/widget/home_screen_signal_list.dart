import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/data/controller/bottom_nav/home/home_controller.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/plan_controller/plan_controller.dart';
import '../../../../components/divider/custom_divider.dart';

class HomeScreenSignalList extends StatefulWidget {
  final PlanController planController;
  const HomeScreenSignalList({super.key, required this.planController});

  @override
  State<HomeScreenSignalList> createState() => _HomeScreenSignalListState();
}

class _HomeScreenSignalListState extends State<HomeScreenSignalList> {
  bool seeSignalDetail = false;

  void seeDetail() {
    setState(() {
      seeSignalDetail = !seeSignalDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    log(widget.planController.packageList.length.toString());
    return GetBuilder<HomeController>(
      builder: (controller) {
        Size size = MediaQuery.of(context).size;
        return SizedBox(
          height: 130,
          width: size.width,
          child: ListView.builder(
              itemCount: widget.planController.packageList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, mainIndex) {
                log("hey");
                return Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 120,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColor.primaryColor,
                  ),
                  child: Column(
                    children: [
                      // Text(
                      //     widget.planController.packageList[mainIndex].name
                      //         .toString(),
                      //     textAlign: TextAlign.center,
                      //     style: interNormalDefault.copyWith(
                      //         color: MyColor.colorWhite)),
                      // const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 3),
                        child: FittedBox(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: widget.planController
                                      .packageList[mainIndex].price!.tr,
                                  style: interNormalOverLarge.copyWith(
                                      color: Colors.white,
                                      // fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: ' / ',
                                  style: interNormalDefault.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: widget.planController
                                      .packageList[mainIndex].validity,
                                  style: interNormalDefault.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: 'يومًا'.tr,
                                  style: interNormalDefault.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600))
                            ]),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          height: 3,
                          color: MyColor.backgroundColor,
                        ),
                      ),

                      Expanded(
                        child: ListView.separated(
                            itemCount: widget.planController
                                .packageList[mainIndex].features!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemBuilder: ((context, fIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 2.5, top: 5, left: 2.5),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.greenAccent,
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.black,
                                            size: 10,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: SizedBox(
                                          width: size.width * 0.2,
                                          child: Text(
                                            widget
                                                .planController
                                                .packageList[mainIndex]
                                                .features![fIndex],
                                            // overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 8),
                                          ),
                                        ),
                                      )
                                    ]),
                              );
                            })),
                      ),
                    ],
                  ),
                );
              })),
        );

        //  controller.signalsList.isEmpty
        //     ? const NoDataWidget()
        //     : ListView.separated(
        //         shrinkWrap: true,
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemCount: controller.signalsList.length,
        //         separatorBuilder: (context, index) =>
        //             const SizedBox(height: 10),
        //         itemBuilder: (context, index) => GestureDetector(
        //           onTap: () {
        //             seeDetail();
        //             // SignalListBottomSheet.showBottomSheet(context,
        //             //     signalName:
        //             //         "${controller.signalsList[index].signal?.name}",
        //             //     time: DateConverter.getSubtractTime(
        //             //         controller.signalsList[index].createdAt ?? ''),
        //             //     signalDetails:
        //             //         "${controller.signalsList[index].signal?.signal}");
        //           },
        //           child: Card(
        //             elevation: 20,
        //             child: Container(
        //               width: double.infinity,
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 15, vertical: 15),
        //               decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.circular(10)),
        //               child: Column(
        //                 children: [
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Row(
        //                         children: [
        //                           // Container(
        //                           //   height: 50,
        //                           //   width: 50,
        //                           //   alignment: Alignment.center,
        //                           //   decoration: BoxDecoration(
        //                           //       color: Colors.white.withOpacity(0.04),
        //                           //       borderRadius:
        //                           //           BorderRadius.circular(10)),
        //                           //   child: Text(
        //                           //     "${index + 1}".padLeft(2, "0"),
        //                           //     textAlign: TextAlign.center,
        //                           //     style: GoogleFonts.inter(
        //                           //         color: Colors.lightBlue,
        //                           //         fontWeight: FontWeight.w500,
        //                           //         fontSize: 17),
        //                           //   ),
        //                           // ),
        //                           Padding(
        //                             padding: const EdgeInsets.only(left: 10),
        //                             child: Column(
        //                               crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.center,
        //                               children: [
        //                                 SizedBox(
        //                                   width: 150,
        //                                   child: Text(
        //                                     "${controller.signalsList[index].signal?.name}",
        //                                     style: interSemiBoldSmall.copyWith(
        //                                         color: Colors.greenAccent),
        //                                     overflow: TextOverflow.ellipsis,
        //                                   ),
        //                                 ),
        //                                 const SizedBox(height: 8),
        //                                 Row(
        //                                   children: [
        //                                     SvgPicture.asset(MyImages.clockIcon,
        //                                         color: Colors.black
        //                                             .withOpacity(0.8),
        //                                         height: 15,
        //                                         width: 15),
        //                                     const SizedBox(width: 5),
        //                                     Text(
        //                                       DateConverter
        //                                           .isoStringToLocalDateOnly(
        //                                               controller
        //                                                       .signalsList[
        //                                                           index]
        //                                                       .createdAt ??
        //                                                   ''),
        //                                       style: interNormalSmall.copyWith(
        //                                           color: Colors.black
        //                                               .withOpacity(0.8)),
        //                                     )
        //                                   ],
        //                                 )
        //                               ],
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                       Container(
        //                         height: 30,
        //                         width: 30,
        //                         alignment: Alignment.center,
        //                         decoration: BoxDecoration(
        //                           border:
        //                               Border.all(color: Colors.black, width: 1),
        //                           shape: BoxShape.circle,
        //                         ),
        //                         child: Icon(Icons.arrow_downward,
        //                             color: Colors.black.withOpacity(.7),
        //                             size: 10),
        //                       )
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 10,
        //                   ),
        //                   Visibility(
        //                     visible: seeSignalDetail,
        //                     child: Container(
        //                       padding: const EdgeInsets.all(8.0),
        //                       // width: MediaQuery.sizeOf(context).width * .7,
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           const SizedBox(
        //                             height: 10,
        //                           ),
        //                           Text(
        //                             "${controller.signalsList[index].signal?.signal}",
        //                             style: interSemiBoldSmall.copyWith(
        //                                 color: Colors.greenAccent),
        //                             // overflow: TextOverflow.ellipsis,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       );
      },
    );
  }
}
