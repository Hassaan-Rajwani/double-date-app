import 'package:double_date/pages/paymentScreens/payment_screen.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DoubleDatePremiumDialog extends StatelessWidget {
  const DoubleDatePremiumDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: 0.9.sw,
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(20.r),
          border: modalBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(crossIcon),
                ),
              ),
              SvgPicture.asset(permiumIcon),
              14.verticalSpace,
              Text(
                'Double Date Premium',
                style: interFont(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0.sp,
                ),
                textAlign: TextAlign.center,
              ),
              24.verticalSpace,
              Text(
                'Purchase our premium pack to add more than 3 friends',
                style: interFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              24.verticalSpace,
              SizedBox(
                width: 1.sw,
                height: 50,
                child: AppButton(
                  text: 'BUY NOW',
                  horizontalMargin: 0,
                  onPress: () {
                    Get.back();
                    Get.to(
                      () => const PaymentScreen(
                        isFromSubscription: false,
                      ),
                    );
                  },
                ),
              ),
              5.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
