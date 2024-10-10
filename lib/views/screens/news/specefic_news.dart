import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:alwegdany/data/model/blogs_model/blogs_model.dart';

import 'package:html/parser.dart' as htmlParser;

import '../../../core/utils/my_color.dart';

class SpeceficNews extends StatelessWidget {
  final BlogsDataModel blogData;
  const SpeceficNews({super.key, required this.blogData});

  //^  Html Parser
  String convertHtmlToPlainText(String htmlString) {
    var document = htmlParser.parse(htmlString);
    String parsedString = document.body!.text;
    return parsedString;
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat.yMMMMd().format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    String htmlString = blogData.dataValues!.description!;
    String plainText = convertHtmlToPlainText(htmlString);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://alwegdany.com/assets/images/frontend/blog/${blogData.dataValues!.image}'),
                        fit: BoxFit.fill)),
              ),
              Positioned(
                top: size.height * 0.35,
                child: Container(
                  height: size.height * 0.65,
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     top: size.height * 0.1,
                            //   ),
                            //   child: RichText(
                            //       textAlign: TextAlign.left,
                            //       text: const TextSpan(children: [
                            //         TextSpan(
                            //             text: 'LONDON',
                            //             style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontSize: 14,
                            //                 fontWeight: FontWeight.bold),
                            //             children: [
                            //               TextSpan(
                            //                   text:
                            //                       '  —  Cryptocurrencies “have no intrinsic value” and people who invest in them should be prepared to lose all their money, Bank of England Governor Andrew Bailey said.',
                            //                   style: TextStyle(
                            //                       fontSize: 14,
                            //                       fontWeight: FontWeight.w100,
                            //                       color: Color(0xff2E0505)))
                            //             ])
                            //       ])),
                            // ),
                            // const SizedBox(
                            //   height: 30,
                            // ),
                            Text(
                              plainText,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color(0xff2E0505), fontSize: 14),
                            ),
                            // const SizedBox(
                            //   height: 30,
                            // ),
                            // const Text(
                            //   'Asked at a press conference Thursday about the rising value of cryptocurrencies, Bailey said: “They have no intrinsic value. That doesn’t mean to say people don’t put value on them, because they can have extrinsic value. But they have no intrinsic value.”',
                            //   textAlign: TextAlign.left,
                            //   style: TextStyle(
                            //       color: Color(0xff2E0505), fontSize: 14),
                            // ),
                            // const SizedBox(
                            //   height: 30,
                            // ),
                            // const Text(
                            //   '“I’m going to say this very bluntly again,” he added. “Buy them only if you’re prepared to lose all your money.”',
                            //   textAlign: TextAlign.left,
                            //   style: TextStyle(
                            //       color: Color(0xff2E0505), fontSize: 14),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.4,
                child: Stack(
                  children: [
                    Positioned(
                      top: 40,
                      left: 15,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: const Color(0xffF0F0EC),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 30,
                        right: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      formatDate(blogData.updatedAt.toString()),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff2E0505)),
                                    ),
                                    Text(
                                      blogData.dataValues!.title.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const Text(
                                      'Published by Ryan Browne',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
