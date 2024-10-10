// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:alwegdany/core/helper/date_converter.dart';
import 'package:alwegdany/core/utils/my_images.dart';
import 'package:alwegdany/core/utils/style.dart';
import 'package:alwegdany/data/controller/bottom_nav/home/home_controller.dart';

import '../../../../../core/utils/my_color.dart';

class TradeSignalList extends StatefulWidget {
  // final PlanController planController;
  const TradeSignalList({super.key});

  @override
  State<TradeSignalList> createState() => _TradeSignalListState();
}

class _TradeSignalListState extends State<TradeSignalList> {
  bool seeSignalDetail = false;

  void seeDetail(List<bool> isShowdetailList, int index) {
    setState(() {
      // seeSignalDetail = !seeSignalDetail;
      log('The original value is ===>  ${isShowdetailList[index]}');
      isShowdetailList[index] = !isShowdetailList[index];
      log('Updated value is ===>  ${isShowdetailList[index]}');
    });
  }

  @override
  Widget build(BuildContext context) {
    log('file rebuild');
    return GetBuilder<HomeController>(
      builder: (controller) {
        // var showBool =
        Size size = MediaQuery.of(context).size;
        return controller.signalsList.isEmpty
            ? SizedBox(
                height: size.height * 0.7,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: MyColor.primaryColor,
                )))
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.signalsList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // isShowDetailList[index]= true;
                            log('Set State has been called');
                          });
                          // seeDetail(isShowDetailList, index);
                          // SignalListBottomSheet.showBottomSheet(context,
                          //     signalName:
                          //         "${controller.signalsList[index].signal?.name}",
                          //     time: DateConverter.getSubtractTime(
                          //         controller.signalsList[index].createdAt ?? ''),
                          //     signalDetails:
                          //         "${controller.signalsList[index].signal?.signal}");
                        },
                        child: ExpansionTile(
                          backgroundColor: MyColor.primaryColor,
                          collapsedBackgroundColor: MyColor.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          title: Text(
                            '${controller.signalsList[index].signal?.name}',
                          ),
                          subtitle: Row(
                            children: [
                              SvgPicture.asset(MyImages.clockIcon,
                                  color: Colors.white.withOpacity(0.8),
                                  height: 15,
                                  width: 15),
                              const SizedBox(width: 5),
                              Text(
                                DateConverter.isoStringToLocalDateOnly(
                                    controller.signalsList[index].createdAt ??
                                        ''),
                                style: interNormalSmall.copyWith(
                                    color: Colors.white.withOpacity(0.8)),
                              )
                            ],
                          ),
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              // width: MediaQuery.sizeOf(context).width * .7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${controller.signalsList[index].signal?.signal}",
                                    style: interSemiBoldSmall.copyWith(
                                        color: Colors.white),
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        )
                        // Card(
                        //   elevation: 0,
                        //   child: Container(
                        //     width: double.infinity,
                        //     padding: const EdgeInsets.symmetric(
                        //         ho'rizontal: 15, v'ertical: 15),
                        //     decoration: BoxDecoration(
                        //         color: MyColor.primaryColor,
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Row(
                        //               children: [
                        //                 // Container(
                        //                 //   height: 50,
                        //                 //   width: 50,
                        //                 //   alignment: Alignment.center,
                        //                 //   decoration: BoxDecoration(
                        //                 //       color: Colors.white.withOpacity(0.04),
                        //                 //       borderRadius:
                        //                 //           BorderRadius.circular(10)),
                        //                 //   child: Text(
                        //                 //     "${index + 1}".padLeft(2, "0"),
                        //                 //     textAlign: TextAlign.center,
                        //                 //     style: GoogleFonts.inter(
                        //                 //         color: Colors.lightBlue,
                        //                 //         fontWeight: FontWeight.w500,
                        //                 //         fontSize: 17),
                        //                 //   ),
                        //                 // ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.only(left: 10),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                     children: [
                        //                       SizedBox(
                        //                         width: 150,
                        //                         child: Text(
                        //                           "${controller.signalsList[index]
                        //                               .signal?.name}",
                        //                           style: interSemiBoldSmall
                        //                               .copyWith(
                        //                               color: Colors.white),
                        //                           overflow: TextOverflow.ellipsis,
                        //                         ),
                        //                       ),
                        //                       const SizedBox(height: 8),
                        //                       Row(
                        //                         children: [
                        //                           SvgPicture.asset(
                        //                               MyImages.clockIcon,
                        //                               color: Colors.white
                        //                                   .withOpacity(0.8),
                        //                               height: 15,
                        //                               width: 15),
                        //                           const SizedBox(width: 5),
                        //                           Text(
                        //                             DateConverter
                        //                                 .isoStringToLocalDateOnly(
                        //                                 controller
                        //                                     .signalsList[
                        //                                 index]
                        //                                     .createdAt ??
                        //                                     ''),
                        //                             style: interNormalSmall
                        //                                 .copyWith(
                        //                                 color: Colors.white
                        //                                     .withOpacity(0.8)),
                        //                           )
                        //                         ],
                        //                       )
                        //                     ],
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //             Container(
                        //               height: 30,
                        //               width: 30,
                        //               alignment: Alignment.center,
                        //               decoration: BoxDecoration(
                        //                 border:
                        //                 Border.all(color: Colors.white, width: 1),
                        //                 shape: BoxShape.circle,
                        //               ),
                        //               child: Icon(Icons.arrow_downward,
                        //                   color: Colors.white.withOpacity(.7),
                        //                   size: 10),
                        //             )
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 10,
                        //         ),
                        //         Visibility(
                        //           visible: isShowDetailList[index] == true ? true : false,
                        //           child: Container(
                        //             padding: const EdgeInsets.all(8.0),
                        //             // width: MediaQuery.sizeOf(context).width * .7,
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 const SizedBox(
                        //                   height: 10,
                        //                 ),
                        //                 Text(
                        //                   "${controller.signalsList[index].signal
                        //                       ?.signal}",
                        //                   style: interSemiBoldSmall.copyWith(
                        //                       color: Colors.white),
                        //                   // overflow: TextOverflow.ellipsis,
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        ),
                  );
                });
      },
    );
  }
}
