import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoubleButtonDialog extends StatelessWidget {
  const DoubleButtonDialog({
    super.key,
    required this.onYes,
    required this.onNo,
    required this.heading,
    required this.bodyText,
    this.yesText = 'Yes',
    this.noText = 'No',
  });

  final VoidCallback onYes;
  final VoidCallback onNo;
  final String heading;
  final String bodyText;
  final String? yesText;
  final String? noText;

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
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                heading,
                style: interFont(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0.sp,
                ),
                textAlign: TextAlign.center,
              ),
              8.verticalSpace,
              Text(
                bodyText,
                style: interFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              24.verticalSpace,
              FittedBox(
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 138,
                      child: AppButton(
                        text: yesText!,
                        minWidth: 138,
                        horizontalMargin: 0,
                        onPress: onYes,
                      ),
                    ),
                    24.horizontalSpace,
                    SizedBox(
                      height: 50,
                      width: 138,
                      child: AppButton(
                        text: noText!,
                        minWidth: 138,
                        backgroundColor: Colors.transparent,
                        isGradinet: false,
                        borderColor: Colors.white,
                        horizontalMargin: 0,
                        onPress: onNo,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
