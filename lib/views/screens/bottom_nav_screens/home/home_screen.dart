import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/utils/dimensions.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/core/utils/style.dart';
import 'package:signal_lab/data/controller/bottom_nav/home/home_controller.dart';
import 'package:signal_lab/data/model/reports/reports_model.dart';
import 'package:signal_lab/data/repo/bottom_nav/home/dashboard_repo.dart';
import 'package:signal_lab/data/services/api_service.dart';
import 'package:signal_lab/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:signal_lab/views/components/custom_loader.dart';
import 'package:signal_lab/views/components/will_pop_widget.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/home/blogs_controller.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/home/widget/home_screen_signal_list.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/home/widget/home_screen_top.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/home/widget/no_data_widget.dart';
import 'package:signal_lab/views/screens/bottom_nav_screens/trade_screen.dart/trade_signals.dart';
import 'package:signal_lab/views/screens/news/show_all_news.dart';
import 'package:signal_lab/views/screens/signal/show_all_signals.dart';
import 'package:signal_lab/views/screens/signal/specefic_signals.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/helper/date_converter.dart';
import '../../../../data/controller/bannerController/bannerController.dart';
import '../../../../data/controller/plan_controller/plan_controller.dart';
import '../../../../data/model/blogs_model/blogs_model.dart';
import '../../../../data/repo/plan_repo/plan_repo.dart';
import '../../news/specefic_news.dart';
import '../../signal/reports_controller.dart';
import '../pricing-plan/plan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class BannerPage extends StatelessWidget {
  final String image;
  const BannerPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(
              image,
            ),
            fit: BoxFit.cover,
          )),
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late BlogsController blogsController;
  late ReportsController reportsController;
  late BannerController bannerController;
  int bannerIndex = 0;

  final PageController smoothController =
      PageController(viewportFraction: 0.8, keepPage: true);

  // late final PlanController planController;
  // @override
  // void initState() {
  //   Get.put(ApiClient(sharedPreferences: Get.find()));
  //   Get.put(HomeRepo(apiClient: Get.find()));

  //   final controller = Get.put(HomeController(dashboardRepo: Get.find()));

  //   Get.put(PlanRepo(apiClient: Get.find()));
  //   final pController = Get.put(PlanController(planRepo: Get.find()));

  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     controller.getDashboardData();
  //     pController.getAllPackageData();
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return WillPopWidget(
  //     nextRoute: '',
  //     child: SafeArea(
  //       child: Scaffold(
  //         backgroundColor: MyColor.backgroundColor,
  //         body: GetBuilder<HomeController>(builder: (controller) {
  //           return controller.isLoading
  //               ? const Center(
  //                   child: CustomLoader(),
  //                 )
  //               : SingleChildScrollView(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             horizontal: Dimensions.space10),
  //                         child: HomeScreenTop(),
  //                       ),

  void updatePageIndicator(index) {
    setState(() {
      bannerIndex = index;
    });

    log('\n\n\nBanner Index is : ${bannerIndex.toString()}');
    // rebuildUi();

    // rebuildUi();
  }

  @override
  void initState() {
    blogsController = Get.put(BlogsController());
    reportsController = Get.put(ReportsController());
    bannerController = Get.put(BannerController());
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));

    final controller =
        Get.put<HomeController>(HomeController(dashboardRepo: Get.find()));

    Get.put(PlanRepo(apiClient: Get.find()));
    final pController = Get.put(PlanController(planRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.getDashboardData();
      print('balance after load is ---> ${controller.balance}');
      pController.getAllPackageData();
      Future.delayed(const Duration(microseconds: 00), () async {
        var blogsList = await blogsController.apiClient.getBlogs();
        var reportList = await reportsController.apiClient.getReports();
        var bannersLists = await bannerController.apiClient.getBanners();
        if (blogsList != null) {
          blogsController.blogsList.value = blogsList;
        } else {
          log('data fom api   -->   null');
        }
        if (reportList != null) {
          reportsController.reportsList.value = reportList;
        } else {
          log('data fom api   -->   null');
        }
        if (bannersLists != null) {
          bannerController.bannersList.value = bannersLists;
        } else {
          log('data fom api   -->   null');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.backgroundColor,
          body: GetBuilder<HomeController>(builder: (controller) {
            log("This is home Widget");
            log('balance is ---->  ${controller.packagePrice}');

            return controller.isLoading
                ? const Center(
                    child: CustomLoader(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space10),
                          child: HomeScreenTop(
                            controller: controller,
                          ),
                        ),
                        // const HomeScreenCardList(),
                        const SizedBox(height: 17),

                        Obx(
                          () => Center(
                              child: bannerController.bannersList.isEmpty
                                  ? const CircularProgressIndicator()
                                  : SizedBox(
                                      // margin: EdgeInsets.only(),
                                      height: size.height * 0.25,
                                      width: size.width * 1,
                                      // color: MyColor.primaryColor,
                                      child: Stack(
                                        children: [
                                          PageView.builder(
                                            controller: smoothController,
                                            onPageChanged: updatePageIndicator,
                                            itemCount: bannerController
                                                .bannersList.length,
                                            itemBuilder: (context, index) {
                                              return BannerPage(
                                                image: bannerController
                                                    .bannersList[index].image
                                                    .toString(),
                                              );
                                            },
                                          ),
                                          // CarouselSlider.builder(

                                          //   itemCount: bannerController
                                          //       .bannersList.length,
                                          //   options: CarouselOptions(
                                          //     height: size.height * 0.3,
                                          //     aspectRatio: 16 / 9,
                                          //     autoPlay: false,
                                          //     autoPlayCurve: Curves.decelerate,
                                          //     enlargeFactor: 20,
                                          //     onPageChanged: ((index, reason) {
                                          //       setState(() {
                                          //         bannerIndex = index;
                                          //       });
                                          //     }),

                                          //     enlargeCenterPage:
                                          //         true, // Specify the height of the carousel
                                          //   ),
                                          //   itemBuilder:
                                          //       (context, index, realIndex) {
                                          //     return Container(
                                          //       height: size.height * 0.25,
                                          //       width: size.width * 0.8,
                                          //       decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   15),
                                          //           image: DecorationImage(
                                          //             image: NetworkImage(
                                          //               bannerController
                                          //                   .bannersList[index]
                                          //                   .image
                                          //                   .toString(),
                                          //             ),
                                          //             fit: BoxFit.cover,
                                          //           )),
                                          //       margin:
                                          //           const EdgeInsets.symmetric(
                                          //               horizontal: 10),
                                          //     );
                                          //   },
                                          // ),
                                          Positioned(
                                              bottom: 20,
                                              // MediaQuery.of(context)
                                              //         .size
                                              //         .height *
                                              //     0.27,
                                              left: 0,
                                              right: 0,

                                              // left: MediaQuery.of(context).size.width /,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: SmoothPageIndicator(
                                                  controller: smoothController,
                                                  // onDotClicked: dorNavigationClick,
                                                  count: bannerController
                                                      .bannersList.length,
                                                  effect:
                                                      const ExpandingDotsEffect(
                                                          activeDotColor:
                                                              Colors.black,
                                                          dotHeight: 10),
                                                ),
                                              )),
                                        ],
                                      ))),
                        ),

                        const SizedBox(height: 17),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: Dimensions.space15,
                              left: Dimensions.space15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الباقات'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(
                                      () => PlanScreen(

                                          // showBack: true,
                                          ),
                                      duration: const Duration(seconds: 1));
                                },
                                child: const Text(
                                  'View all',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 17),
                        // ^ Plans
                        GetBuilder<PlanController>(builder: (planController1) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: Dimensions.space15),
                            child: HomeScreenSignalList(
                                planController: planController1),
                          );
                        }),
                        const SizedBox(height: 17),

                        // ^ Trade Signals
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.space15,
                              right: Dimensions.space15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'التوصيات'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(
                                      () => const TradeSignalWiddget(
                                            showBack: true,
                                          ),
                                      duration: const Duration(seconds: 1));
                                },
                                child: const Text(
                                  'View all',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                        //   ^   Trade Signals
                        const SizedBox(height: 10),
                        controller.signalsList.isEmpty
                            ? const NoDataWidget()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimensions.space15,
                                    right: Dimensions.space15),
                                child: SizedBox(
                                  height: 40,
                                  width: size.width,
                                  child: ListView.builder(
                                      itemCount: controller.signalsList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: ((context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Material(
                                                    type: MaterialType
                                                        .transparency,
                                                    child: Center(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 15),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10,
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            color: MyColor
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        height: 200,
                                                        width: size.width,
                                                        child: Center(
                                                          child: FittedBox(
                                                            child: Text(
                                                              "${controller.signalsList[index].signal?.signal}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: interSemiBoldSmall
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          22),
                                                              // overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            height: 38,
                                            width: size.width * 0.4,
                                            decoration: BoxDecoration(
                                              color: MyColor.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Text(
                                                        (index + 1).toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${controller.signalsList[index].signal?.name}",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          DateConverter.isoStringToLocalDateOnly(
                                                              controller
                                                                      .signalsList[
                                                                          index]
                                                                      .createdAt ??
                                                                  ''),
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      })),
                                ),
                              ),
                        const SizedBox(height: 20),

                        // ^   Akhbaaar
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'أخبار'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(
                                      () => ShowAllNews(
                                            blogList: blogsController.blogsList,
                                          ),
                                      duration: const Duration(seconds: 1));
                                },
                                child: const Text(
                                  'View all',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.space15),
                            child: SizedBox(
                              height: size.height * 0.2,
                              width: size.width,
                              child: Obx(
                                () => blogsContainer(
                                    size, blogsController.blogsList),
                              ),
                            )),

                        // ^ Crypto Signals

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'التقارير'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => ShowAllSignals(
                                        reportsList:
                                            reportsController.reportsList,
                                      ));
                                },
                                child: const Text(
                                  'View all',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space15),
                          child: SizedBox(
                            height: size.height * 0.2,
                            width: size.width,
                            child: Obx(
                              () => reportsContainer(
                                  size, reportsController.reportsList),
                            ),
                          ),
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       MyStrings.latestSignal,
                        //       style: interNormalDefault.copyWith(
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.w600),
                        //     ),
                        //     GestureDetector(
                        //       onTap: () =>
                        //           Get.toNamed(RouteHelper.signalScreen),
                        //       child: Container(
                        //         padding:
                        //             const EdgeInsets.all(Dimensions.space10),
                        //         alignment: Alignment.center,
                        //         child: Text(
                        //           MyStrings.allSignal,
                        //           textAlign: TextAlign.center,
                        //           style: interNormalSmall.copyWith(
                        //               color: Colors.greenAccent,
                        //               fontWeight: FontWeight.w600),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  );
          }),
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
        ),
      ),
    );
  }

// *  Reports Container

  Widget reportSignalContainer(
      Size size, String image, ReportsDataModel reportModel) {
    return InkWell(
      onTap: () {
        Get.to(() => SpeceficTradeSignal(
              reportsDataModel: reportModel,
            ));
      },
      child: Container(
        height: 130,
        width: size.width * 0.43,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      ),
    );
  }

  Widget reportsContainer(Size size, List<ReportsDataModel> reportsList) {
    return ListView.separated(
      separatorBuilder: ((context, index) => const SizedBox(
            width: 20,
          )),
      scrollDirection: Axis.horizontal,
      itemCount: reportsList.length > 2 ? 5 : reportsList.length,
      itemBuilder: (context, index) {
        log("Came to reports");
        var sourceAddress =
            'https://alwegdany.com/assets/images/frontend/blog/';

        // ignore: unnecessary_brace_in_string_interps
        return reportSignalContainer(
          size,
          '$sourceAddress${reportsList[index].dataValues!.image}',
          reportsList[index],
          // reportsList[index],
        );
        // return newContainer(size, '');
      },
    );
  }

  // *  BLogs Container

  Widget blogsContainer(Size size, List<BlogsDataModel> blogsData) {
    return ListView.separated(
      separatorBuilder: ((context, index) => const SizedBox(
            width: 20,
          )),
      scrollDirection: Axis.horizontal,
      itemCount: blogsData.length > 2 ? 2 : blogsData.length,
      itemBuilder: (context, index) {
        log("Came to bloggs");
        var sourceAddress =
            'https://alwegdany.com/assets/images/frontend/blog/';

        // ignore: unnecessary_brace_in_string_interps
        return newsContainer(
          size,
          '$sourceAddress${blogsData[index].dataValues!.image}',
          blogsData[index],
        );
        // return newContainer(size, '');
      },
    );
  }

  Widget newsContainer(Size size, String image, BlogsDataModel blogsDataModel) {
    return InkWell(
      onTap: () {
        Get.to(() => SpeceficNews(
              blogData: blogsDataModel,
            ));
      },
      child: Container(
        height: 130,
        width: size.width * 0.43,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      ),
    );
  }

  Widget tradeContainer(Size size, String image) {
    return Container(
      height: 130,
      width: size.width * 0.43,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}
