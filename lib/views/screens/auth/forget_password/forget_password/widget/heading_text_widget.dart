import 'package:flutter/material.dart';
import 'package:alwegdany/core/utils/style.dart';
import 'package:alwegdany/views/components/text/header_text.dart';

class HeadingTextWidget extends StatelessWidget {
  final String header;
  final String body;
  const HeadingTextWidget({Key? key, required this.header, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .025,
        ), // 4%
        HeaderText(text: header),
        const SizedBox(
          height: 5,
        ),
        Text(
          body,
          style:
              interNormalDefault.copyWith(color: Colors.white.withOpacity(.5)),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .03,
        ),
      ],
    );
  }
}
