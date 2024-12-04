import 'package:double_date/pages/messageScreens/date_idea_planner.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DateIdeaPlannerCard extends StatelessWidget {
  const DateIdeaPlannerCard({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DateIdeaPlannerScreen(
              conversationId: conversationId,
            ));
      },
      child: Container(
        width: 224,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          border: modalBorder(width: 0.2),
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA8A8A8).withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(doubleDateIcon),
                10.horizontalSpace,
                Text(
                  'Date Idea Planner',
                  style: interFont(
                    color: const Color(0xFFB1124C),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFFB1124C),
            ),
          ],
        ),
      ),
    );
  }
}
