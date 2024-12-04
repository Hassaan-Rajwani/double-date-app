import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({
    super.key,
    required this.heading,
    required this.bodyText,
  });

  final String heading;
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
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
                  fontSize: 20.0.sp,
                ),
                textAlign: TextAlign.center,
              ),
              8.verticalSpace,
              Text(
                bodyText,
                style: interFont(
                  fontSize: 14.0,
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
                        text: 'Open Setting',
                        minWidth: 138,
                        horizontalMargin: 0,
                        onPress: () {
                          Get.back();
                          openAppSettings();
                        },
                      ),
                    ),
                    24.horizontalSpace,
                    SizedBox(
                      height: 50,
                      width: 138,
                      child: AppButton(
                        text: 'Cancel',
                        minWidth: 138,
                        backgroundColor: Colors.transparent,
                        isGradinet: false,
                        borderColor: Colors.white,
                        horizontalMargin: 0,
                        onPress: () {
                          Get.back();
                        },
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
