import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentDetailCard extends StatelessWidget {
  const PaymentDetailCard({
    super.key,
    this.text1 = '',
    this.text2 = '',
  });

  final String? text1;
  final String? text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 18.w),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1!,
            style: interFont(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '\$$text2',
            style: interFont(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentVisaCard extends StatelessWidget {
  const PaymentVisaCard({
    super.key,
    required this.last4Digits,
    this.onTap,
  });

  final String last4Digits;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 18.w),
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
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(visaIcon),
                16.horizontalSpace,
                Text(
                  'Ending with $last4Digits',
                  style: interFont(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.centerRight,
                width: 100,
                child: Text(
                  'Add Card',
                  style: interFont(
                    color: const Color(0xFFB1124C),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
