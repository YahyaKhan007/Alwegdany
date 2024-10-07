import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:signal_lab/data/model/reports/reports_model.dart';

import '../../../core/utils/my_color.dart';

import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;

class HtmlContent {
  final String imageUrl;
  final String text;

  HtmlContent({required this.imageUrl, required this.text});
}

HtmlContent extractImageAndText(String htmlString) {
  var document = htmlParser.parse(htmlString);
  var imageElement = document.querySelector('img');
  var imageUrl = imageElement?.attributes['src'] ?? '';

  // Remove the image tag and extract the plain text
  imageElement?.remove();
  var text = document.body!.text.trim();

  return HtmlContent(imageUrl: imageUrl, text: text);
}

class SpeceficTradeSignal extends StatelessWidget {
  final ReportsDataModel reportsDataModel;
  const SpeceficTradeSignal({super.key, required this.reportsDataModel});

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat.yMMMMd().format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    String htmlString = reportsDataModel.dataValues!.description!;
    var content = extractImageAndText(htmlString);
    print('Image URL: ${content.imageUrl}');
    log('Plain Text: ${content.text}');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      body: SizedBox(
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
                          'https://alwegdany.com/assets/images/frontend/blog/${reportsDataModel.dataValues!.image}'),
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
                            height: size.height * 0.08,
                          ),
                          if (content.imageUrl != '')
                            Container(
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                height: size.height * 0.3,
                                width: size.width * 0.4,
                                child: Image.network(content.imageUrl)),
                          if (content.imageUrl == '')
                            // Image.asset('assets/images/tradePic.png'),
                            const SizedBox(
                              height: 15,
                            ),
                          Text(
                            content.text,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
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
                          size: 16,
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
                                    formatDate(
                                        reportsDataModel.updatedAt.toString()),
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xff2E0505)),
                                  ),
                                  Text(
                                    reportsDataModel.dataValues!.title
                                        .toString(),
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
    );
  }
}
