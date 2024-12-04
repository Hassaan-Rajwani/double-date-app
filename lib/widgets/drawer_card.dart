import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerCard extends StatelessWidget {
  const DrawerCard({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  final String icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: 1.sw,
        height: 50,
        decoration: BoxDecoration(
          border: modalBorder(width: 0.3),
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA8A8A8).withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            16.horizontalSpace,
            SvgPicture.asset(icon),
            12.horizontalSpace,
            Text(
              text,
              style: interFont(
                fontWeight: FontWeight.w500,
                color: const Color(0xFFB1124C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
