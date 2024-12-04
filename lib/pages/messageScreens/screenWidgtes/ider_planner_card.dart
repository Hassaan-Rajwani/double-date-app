import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdeaPlannerCard extends StatelessWidget {
  const IdeaPlannerCard({
    super.key,
    required this.title,
    required this.msg,
    required this.imagePath,
    required this.onTap,
  });

  final String title;
  final String msg;
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: modalBorder(width: 0.2),
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA8A8A8).withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 1.sw,
                height: 157,
                fit: BoxFit.cover,
              ),
            ),
            8.verticalSpace,
            Text(
              title,
              style: interFont(
                color: const Color(0xFFB1124C),
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            5.verticalSpace,
            Text(
              msg,
              style: interFont(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            24.verticalSpace,
            AppButton(
              text: 'SHARE TO CHAT',
              horizontalMargin: 0,
              onPress: onTap,
            ),
            6.verticalSpace,
          ],
        ),
      ),
    );
  }
}
