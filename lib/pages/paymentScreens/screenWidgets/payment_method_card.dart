import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.onDelete,
  });

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Card holder name',
                style: interFont(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              4.verticalSpace,
              Text(
                'Kevin Martin',
                style: interFont(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFB1124C),
                ),
              ),
              13.verticalSpace,
              Text(
                'Card details',
                style: interFont(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.verticalSpace,
              Text(
                'Card No.  **** **** **** 1234',
                style: interFont(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.verticalSpace,
              Text(
                'Expiry: 12-2027',
                style: interFont(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.verticalSpace,
              Text(
                'Credit card',
                style: interFont(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onDelete,
                  child: SvgPicture.asset(crossIcon),
                ),
                53.verticalSpace,
                SvgPicture.asset(visaIcon),
              ],
            ),
          )
        ],
      ),
    );
  }
}
