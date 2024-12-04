import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BasicDialog extends StatelessWidget {
  const BasicDialog({
    super.key,
    required this.heading,
    required this.bodyText,
    this.hideCrossIcon = true,
    this.buttonText = 'CONTINUE',
    this.showButton = true,
    this.bodyTextStyle,
    required this.onTap,
  });

  final String heading;
  final String bodyText;
  final String? buttonText;
  final bool? hideCrossIcon;
  final VoidCallback onTap;
  final bool? showButton;
  final TextStyle? bodyTextStyle;

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
              Stack(
                children: [
                  Center(
                    child: Column(
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
                          style: bodyTextStyle ??
                              interFont(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        24.verticalSpace,
                        if (showButton!)
                          SizedBox(
                            width: 1.sw,
                            height: 50,
                            child: AppButton(
                              text: buttonText!,
                              horizontalMargin: 0,
                              onPress: onTap,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (hideCrossIcon != true)
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(crossIcon),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
