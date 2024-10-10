import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alwegdany/core/helper/date_converter.dart';
import 'package:alwegdany/core/utils/dimensions.dart';
import 'package:alwegdany/core/utils/my_color.dart';
import 'package:alwegdany/core/utils/my_images.dart';
import 'package:alwegdany/core/utils/style.dart';
import 'package:alwegdany/views/screens/bottom_nav_screens/home/widget/signal_list_bottom_sheet.dart';

class SignalListItem extends StatelessWidget {
  final int index;
  final String date;
  final String signalName;
  final String details;

  const SignalListItem(
      {Key? key,
      required this.index,
      required this.date,
      required this.signalName,
      required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SignalListBottomSheet.showBottomSheet(context,
            signalName: signalName,
            time: DateConverter.isoStringToLocalDateAndTime(date),
            signalDetails: details);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            color: MyColor.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "${index + 1}".padLeft(2, "0"),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: MyColor.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          signalName,
                          maxLines: 2,
                          style: interSemiBoldSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            SvgPicture.asset(MyImages.clockIcon,
                                color: MyColor.colorWhite.withOpacity(0.8),
                                height: 15,
                                width: 15),
                            const SizedBox(width: 5),
                            Text(
                              DateConverter.isoStringToLocalDateOnly(date),
                              style: interNormalSmall.copyWith(
                                  color: MyColor.colorWhite.withOpacity(0.8)),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
            const SizedBox(width: Dimensions.space3),
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: MyColor.backgroundColor, width: 1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: 10),
            )
          ],
        ),
      ),
    );
  }
}
