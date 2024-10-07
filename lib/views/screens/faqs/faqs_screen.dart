import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_lab/core/new_api_services/new_api_service.dart';
import 'package:signal_lab/core/utils/my_color.dart';
import 'package:signal_lab/views/screens/faqs/faqs_controller.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  late FAQsController controller;
  @override
  void initState() {
    final NewApiClient apiClient = NewApiClient();

    controller = Get.put(FAQsController());

    super.initState();
    Future.delayed(const Duration(microseconds: 00), () async {
      var faqList = await apiClient.getFaqs();

      if (faqList != null) {
        controller.faqsList.value = faqList;
      } else {
        log('data fom api   -->   null');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: MyColor.backgroundColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              )),
          title: const Text(
            "FAQs",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Obx(
          () => controller.faqsList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                  color: MyColor.primaryColor,
                ))
              : ListView.builder(
                  itemCount: controller.faqsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColor.primaryColor),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                Colors.greenAccent.withOpacity(0.2),
                            child: Center(
                              child: Text(
                                "${index + 1}".toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                          title: Text(controller
                              .faqsList[index].dataValues!.question
                              .toString()),
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Text(controller
                                  .faqsList[index].dataValues!.answer
                                  .toString()),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ));
  }
}
