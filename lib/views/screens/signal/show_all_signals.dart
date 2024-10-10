import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:alwegdany/data/model/reports/reports_model.dart';
import 'package:alwegdany/views/screens/signal/specefic_signals.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/my_color.dart';
import '../onboarding/widget/ad_widgets.dart';

class ShowAllSignals extends StatefulWidget {
  final List<ReportsDataModel> reportsList;

  const ShowAllSignals({super.key, required this.reportsList});

  @override
  State<ShowAllSignals> createState() => _ShowAllSignalsState();
}

class _ShowAllSignalsState extends State<ShowAllSignals> {
  int bannerIndex = 0;

  final PageController smoothController =
      PageController(viewportFraction: 0.8, keepPage: true);

  void updatePageIndicator(index) {
    setState(() {
      bannerIndex = index;
    });

    log('\n\n\nBanner Index is : ${bannerIndex.toString()}');
    // rebuildUi();

    // rebuildUi();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> text = [
    //   "5 things to know about the 'conundrum' of lupus",
    //   "4 ways families can ease anxiety together",
    //   "What to do if you're planning or attending a wedding during the pandemic",
    //   "5 things to know about the 'conundrum' of lupus",
    //   "4 ways families can ease anxiety together",
    //   "What to do if you're planning or attending a wedding during the pandemic"
    // ];

    List<String> images = [
      'assets/images/newsPic2.png',
      'assets/images/newsPic3.png',
      'assets/images/newsPic2.png',
      'assets/images/newsPic3.png',
      'assets/images/newsPic2.png',
      'assets/images/newsPic3.png',
    ];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Expanded(flex: 1, child: topSearch()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "تقرير الإشارة".tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22.8,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // ^ New Carousel Slider
          // Expanded(flex: 3, child: reportsSlider(context, size)),
          Expanded(flex: 3, child: newSliderPageView(context, size)),

          // ^  vetical Slider
          Expanded(flex: 6, child: verticalSlider(size, images: images))
        ],
      ),
    );
  }

  Widget newSliderPageView(BuildContext context, Size size) {
    return Stack(
      children: [
        PageView.builder(
          controller: smoothController,
          onPageChanged: updatePageIndicator,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: AddWidget(
                reportsDataModel: widget.reportsList[index],
                image:
                    'https://alwegdany.com/assets/images/frontend/blog/${widget.reportsList[index].dataValues!.image!}',
                onTap: () {
                  Get.to(() => SpeceficTradeSignal(
                        reportsDataModel: widget.reportsList[index],
                      ));
                },
              ),
            );
          },
          itemCount: 3,
        ),
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
                count: 3,
                effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.black, dotHeight: 10),
              ),
            )),
      ],
    );
  }

  Widget verticalSlider(
    Size size, {
    required List<String> images,
  }) {
    return Container(
      // height: size.height,
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.reportsList.length - 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => SpeceficTradeSignal(
                      reportsDataModel: widget.reportsList[index + 3],
                    ));
              },
              child: Container(
                height: size.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://alwegdany.com/assets/images/frontend/blog/${widget.reportsList[index + 3].dataValues!.image!}'),
                        fit: BoxFit.cover)),
                margin: const EdgeInsets.only(bottom: 20),
                child: Stack(
                  children: [
                    Container(
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://alwegdany.com/assets/images/frontend/blog/${widget.reportsList[index + 3].dataValues!.image!}'),
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.only(bottom: 20)),
                    Positioned(
                      top: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade700),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 9),
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                child: Text(
                                  widget.reportsList[index + 3].dataValues!
                                      .title!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  // ^  News Carousel

  Widget reportsSlider(BuildContext context, Size size) {
    return CarouselSlider(
      slideTransform: CubeTransform(),
      slideIndicator: CircularSlideIndicator(
        padding: EdgeInsets.only(bottom: 32),
      ),
      autoSliderDelay: Duration(seconds: 5),
      autoSliderTransitionTime: Duration(seconds: 1),
      children: [
        reportCard(
            size,
            'https://alwegdany.com/assets/images/frontend/blog/${widget.reportsList[0].dataValues!.image!}',
            widget.reportsList[0]),
        reportCard(
            size,
            'https://alwegdany.com/assets/images/frontend/blog/${widget.reportsList[1].dataValues!.image!}',
            widget.reportsList[1]),
        reportCard(
            size,
            'https://alwegdany.com/assets/images/frontend/blog/${widget.reportsList[2].dataValues!.image!}',
            widget.reportsList[2]),
      ],
    );
  }

  Widget reportCard(Size size, String image, ReportsDataModel reportModel) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SpeceficTradeSignal(
              reportsDataModel: reportModel,
            ));
      },
      child: Container(
        height: size.height * 0.3,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }

// ^ Top Search
  Widget topSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1,
                            blurRadius: 10)
                      ]),
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.search,
                            color: Color(0xff818181),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 15),
                        hintText: 'Dogecoin to the Moon...',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: const TextStyle(
                            fontSize: 13.15, color: Color(0xff818181)),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                  ))),
          const SizedBox(
            width: 24,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const CircleAvatar(
              backgroundColor: Color(0xffF0F0EC),
              // backgroundColor: Colors.black,
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
