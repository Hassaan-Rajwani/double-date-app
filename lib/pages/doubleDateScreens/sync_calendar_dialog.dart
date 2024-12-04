import 'package:double_date/controllers/schedule_double_date_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SyncCalendarDialog extends StatefulWidget {
  const SyncCalendarDialog({
    super.key,
  });

  @override
  State<SyncCalendarDialog> createState() => _SyncCalendarDialogState();
}

class _SyncCalendarDialogState extends State<SyncCalendarDialog> {
  final sc = Get.put(ScheduleDoubleDateCalendarController());
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
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(crossIcon),
                ),
              ),
              Image.asset(tickIcon),
              24.verticalSpace,
              Text(
                'Your Calendar has been Synced ',
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
                  text: 'SCHEDULE DATE',
                  horizontalMargin: 0,
                  onPress: () {
                    sc.onAddEvent(context: context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
