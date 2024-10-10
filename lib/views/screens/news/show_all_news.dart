import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alwegdany/data/model/blogs_model/blogs_model.dart';
import 'package:alwegdany/views/screens/news/specefic_news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/my_color.dart';
import '../onboarding/widget/ad_widgets.dart';

class ShowAllNews extends StatefulWidget {
  final List<BlogsDataModel> blogList;
  const ShowAllNews({super.key, required this.blogList});

  @override
  State<ShowAllNews> createState() => _ShowAllNewsState();
}

class _ShowAllNewsState extends State<ShowAllNews> {
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
              "أحدث الأخبار".tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22.8,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // ^ New Carousel Slider
          // Expanded(flex: 3, child: newsSlider(context, size)),
          Expanded(flex: 3, child: newSliderPageView(context, size)
              // newsSlider(context, size)
              ),

          // ^  vetical Slider
          Expanded(
              flex: 6,
              child: verticalSlider(
                size,
              ))
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
              child: AddWidgetNews(
                blogsDataModel: widget.blogList[index],
                image:
                    'https://alwegdany.com/assets/images/frontend/blog/${widget.blogList[index].dataValues!.image!}',
                onTap: () {
                  Get.to(() => SpeceficNews(
                        blogData: widget.blogList[index],
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
    Size size,
  ) {
    return Container(
      // height: size.height,
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.blogList.length - 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => SpeceficNews(
                      blogData: widget.blogList[index + 3],
                    ));
              },
              child: Container(
                height: size.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://alwegdany.com/assets/images/frontend/blog/${widget.blogList[index + 3].dataValues!.image!}'),
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
                                    'https://alwegdany.com/assets/images/frontend/blog/${widget.blogList[index + 3].dataValues!.image!}'),
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.only(bottom: 20)),
                    Positioned(
                      top: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 9),
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                child: Text(
                                  widget.blogList[index + 3].dataValues!.title!,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
  // Widget newsSlider(BuildContext context, Size size) {
  //   return CarouselSlider(
  //     items: [
  //       newsCard(
  //           size,
  //           'https://alwegdany.com/assets/images/frontend/blog/${widget.blogList[0].dataValues!.image!}',
  //           widget.blogList[0]
  //           // 'assets/images/newsPic1.png',
  //           ),
  //       newsCard(
  //           size,
  //           'https://alwegdany.com/assets/images/frontend/blog/${widget.blogList[1].dataValues!.image!}',
  //           widget.blogList[1]
  //           // 'assets/images/newsPic1.png',
  //           ),
  //       newsCard(
  //           size,
  //           'https://alwegdany.com/assets/images/frontend/blog/${widget.blogList[2].dataValues!.image!}',
  //           widget.blogList[2]
  //           // 'assets/images/newsPic1.png',
  //           ),
  //     ],
  //     options: CarouselOptions(
  //       height: size.height * 0.3,
  //       aspectRatio: 16 / 9,
  //       autoPlay: true,
  //       autoPlayCurve: Curves.decelerate,
  //       enlargeFactor: 20,
  //       enlargeCenterPage: true,
  //     ),
  //   );
  // }

  Widget newsSlider(BuildContext context, Size size) {
    return SizedBox();
    //   carousel_slider.CarouselSlider(
    //   items: [
    //     newsCard(
    //         size,
    //         'https://alwegdany.com/assets/images/frontend/blog/${widget.blogList[0].dataValues!.image!}',
    //         widget.blogList[0]
    //         // 'assets/images/newsPic1.png',
    //         ),
    //     newsCard(
    //         size,
    //         'https://alwegdany.com/assets/images/frontend/blog/${widget.blogList[1].dataValues!.image!}',
    //         widget.blogList[1]
    //         // 'assets/images/newsPic1.png',
    //         ),
    //     newsCard(
    //         size,
    //         'https://alwegdany.com/assets/images/frontend/blog/${widget.blogList[2].dataValues!.image!}',
    //         widget.blogList[2]
    //         // 'assets/images/newsPic1.png',
    //         ),
    //   ],
    //   options: carousel_slider.CarouselOptions(
    //     height: size.height * 0.3,
    //     aspectRatio: 16 / 9,
    //     autoPlay: true,
    //     autoPlayCurve: Curves.decelerate,
    //     enlargeFactor: 20,
    //     enlargeCenterPage: true,
    //   ),
    // );
  }

  Widget newsCard(Size size, String image, BlogsDataModel blogsDataModel) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SpeceficNews(
              blogData: blogsDataModel,
            ));
      },
      child: Container(
        height: size.height * 0.3,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
