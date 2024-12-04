// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:double_date/controllers/schedule_double_date_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/double_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UpcomingDoubleDateCard extends StatefulWidget {
  const UpcomingDoubleDateCard({
    super.key,
    required this.onTap,
    this.onUnsync,
  });

  final VoidCallback onTap;
  final VoidCallback? onUnsync;

  @override
  State<UpcomingDoubleDateCard> createState() => _UpcomingDoubleDateCardState();
}

class _UpcomingDoubleDateCardState extends State<UpcomingDoubleDateCard> {
  final sc = Get.put(ScheduleDoubleDateCalendarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GestureDetector(
          onTap: sc.showOtherdate.value ? null : widget.onTap,
          child: sc.showOtherdate.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                      decoration: BoxDecoration(
                        border: modalBorder(width: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Synced with ${Platform.isAndroid ? 'Google' : 'Apple'}',
                                style: interFont(
                                  color: const Color(0xFFB1124C),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return DoubleButtonDialog(
                                    onNo: () {
                                      Get.back();
                                    },
                                    onYes: widget.onUnsync!,
                                    // () {
                                    //   Get.close(1);
                                    //   // Get.off(() => const ScheduleDoubleDateScreen(
                                    //   //       isDoubleDateCalendar: true,
                                    //   //     ));
                                    // },
                                    heading: 'Double Sync',
                                    bodyText: 'Are you sure you want to delete sync with google?',
                                  );
                                },
                              );
                            },
                            child: SvgPicture.asset(
                              crossIcon,
                              color: const Color(0xFFB1124C),
                              width: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'Tap on dates to check details',
                      style: interFont(
                        fontSize: 16.0,
                        color: const Color(0xFFB1124C),
                      ),
                    ),
                    24.verticalSpace,
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tap on dates to check details',
                      style: interFont(
                        fontSize: 16.0,
                        color: const Color(0xFFB1124C),
                      ),
                    ),
                    24.verticalSpace,
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                      decoration: BoxDecoration(
                        border: modalBorder(width: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'View upcoming double dates',
                                style: interFont(
                                  color: const Color(0xFFB1124C),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFB1124C),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
