import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.onTap,
    required this.onDelete,
    required this.title,
    required this.bodyTitle,
  });

  final VoidCallback onTap;
  final VoidCallback onDelete;
  final String title;
  final String bodyTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: 1.sw,
        decoration: BoxDecoration(
          border: modalBorder(width: 0.2),
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA8A8A8).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: interFont(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFB1124C),
                  ),
                ),
                8.verticalSpace,
                Text(
                  bodyTitle,
                  style: interFont(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onDelete,
              child: SvgPicture.asset(crossIcon),
            ),
          ],
        ),
      ),
    );
  }
}
