import 'package:flutter/material.dart';

import '../../../../data/model/blogs_model/blogs_model.dart';
import '../../../../data/model/reports/reports_model.dart';

class AddWidgetNews extends StatelessWidget {
  final String image;
  final BlogsDataModel blogsDataModel;
  final VoidCallback onTap;
  const AddWidgetNews(
      {super.key,
      required this.image,
      required this.blogsDataModel,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: size.height * 0.25,
        // width: size.width * 0.8,
        height: size.height * 0.3,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}

class AddWidget extends StatelessWidget {
  final String image;
  final ReportsDataModel reportsDataModel;
  final VoidCallback onTap;
  const AddWidget(
      {super.key,
      required this.image,
      required this.reportsDataModel,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: size.height * 0.25,
        // width: size.width * 0.8,
        height: size.height * 0.3,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
