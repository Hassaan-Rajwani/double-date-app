import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.onTap,
    required this.heading,
    required this.text,
  });

  final VoidCallback onTap;
  final String heading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        width: 1.sw,
        decoration: BoxDecoration(
          border: modalBorder(width: 0.2),
          borderRadius: BorderRadius.circular(20.r),
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$15/month',
                  style: interFont(
                    color: const Color(0xFFB1124C),
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                ),
                2.verticalSpace,
                Text(
                  heading,
                  style: interFont(),
                ),
                12.verticalSpace,
                Text(
                  text,
                  style: interFont(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: SvgPicture.asset(crown3Icon),
            )
          ],
        ),
      ),
    );
  }
}
