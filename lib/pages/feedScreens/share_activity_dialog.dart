import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShareActivityDialog extends StatelessWidget {
  const ShareActivityDialog({super.key});

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
                  Column(
                    children: [
                      Text(
                        'Share Activity',
                        style: interFont(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      8.verticalSpace,
                      Text(
                        'If you like to share this activity.',
                        style: interFont(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      24.verticalSpace,
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            iconPress(iconPath: twIcon, onTap: () {}),
                            iconPress(iconPath: fbIcon, onTap: () {}),
                            iconPress(iconPath: disIcon, onTap: () {}),
                            iconPress(iconPath: waIcon, onTap: () {}),
                          ],
                        ),
                      ),
                      AppInput(
                        placeHolder: 'https://example.com/activityda',
                        horizontalMargin: 0,
                        verticalPadding: 0,
                        bottomMargin: 0,
                        backColor: Colors.transparent,
                        readOnly: true,
                        postfixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: SvgPicture.asset(copyIcon),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(crossIcon),
                      ),
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

  Widget iconPress({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          iconPath,
        ),
      ),
    );
  }
}
