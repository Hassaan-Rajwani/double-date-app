import 'dart:io';

import 'package:double_date/pages/doubleDateScreens/sync_calendar_dialog.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleDoubleDateScreen extends StatelessWidget {
  const ScheduleDoubleDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Schedule double date'),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(heartBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              70.verticalSpace,
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      infoIcon,
                    ),
                    12.verticalSpace,
                    Text(
                      'You haven\'t sync your calendar',
                      style: interFont(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              45.verticalSpace,
              Text(
                'Sync your calendar with',
                style: interFont(
                  fontWeight: FontWeight.w500,
                ),
              ),
              20.verticalSpace,
              if (Platform.isAndroid)
                iconText(
                  text: 'Google Calendar',
                  iconPath: googleCalendarIcon,
                  calnderType: 'google',
                  context: context,
                ),
              if (Platform.isIOS)
                iconText(
                  text: 'Apple Calendar',
                  iconPath: appleCalendarIcon,
                  calnderType: 'apple',
                  context: context,
                ),
              // iconText(
              //   text: 'Office Calendar',
              //   iconPath: officeCalendarIcon,
              //   calnderType: 'office',
              //   context: context,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconText({
    required String text,
    required String iconPath,
    required String calnderType,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const SyncCalendarDialog();
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
              text,
              style: interFont(
                color: const Color(0xFFB1124C),
                fontWeight: FontWeight.w500,
              ),
            ),
            Image.asset(iconPath),
          ],
        ),
      ),
    );
  }
}
