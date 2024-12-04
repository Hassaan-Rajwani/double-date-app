import 'package:double_date/controllers/schedule_double_date_controller.dart';
import 'package:double_date/pages/doubleDateScreens/screenWidgets/upcoming_double_date_card.dart';
import 'package:double_date/pages/doubleDateScreens/troubleshooting_tips.dart';
import 'package:double_date/pages/doubleDateScreens/upcoming_double_date.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UpcomingDoubleDatesCalendar extends StatefulWidget {
  const UpcomingDoubleDatesCalendar({super.key});

  @override
  State<UpcomingDoubleDatesCalendar> createState() => _UpcomingDoubleDatesCalendarState();
}

class _UpcomingDoubleDatesCalendarState extends State<UpcomingDoubleDatesCalendar> {
  final sc = Get.put(ScheduleDoubleDateCalendarController());

  @override
  void initState() {
    super.initState();
    sc.retrieveCalendars();
  }

  @override
  void dispose() {
    sc.clearDate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: 'Double Date Calendar',
        showSkipButton: true,
        showIconOnSkipArea: troubleshootIcon,
        onSkipTap: () {
          Get.to(() => const TroubleShootingTipsScreen());
        },
      ),
      body: Obx(() {
        return SingleChildScrollView(
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
                10.verticalSpace,
                UpcomingDoubleDateCard(
                  onTap: () {
                    Get.to(() => const UpcomingDoubleDateScreen());
                  },
                  onUnsync: () async {
                    await sc.deleteEvent(
                      calendarId: sc.writableCalendars.first.id!,
                      eventId: sc.selectedEventId.value,
                    );
                  },
                ),
                SfDateRangePicker(
                  yearCellStyle: DateRangePickerYearCellStyle(
                    textStyle: interFont(),
                  ),
                  controller: sc.scheduleController.value,
                  view: DateRangePickerView.month,
                  selectionColor: Colors.pink,
                  todayHighlightColor: Colors.pink,
                  backgroundColor: Colors.black,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: interFont(fontSize: 20.0),
                    backgroundColor: Colors.black,
                  ),
                  navigationDirection: DateRangePickerNavigationDirection.horizontal,
                  showNavigationArrow: true,
                  navigationMode: DateRangePickerNavigationMode.snap,
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: interFont(),
                    ),
                    dayFormat: 'E',
                    specialDates: sc.specialDatesOnly,
                    weekendDays: const [6, 7],
                    weekNumberStyle: DateRangePickerWeekNumberStyle(
                      textStyle: interFont(),
                    ),
                  ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    specialDatesDecoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.topRight,
                        image: AssetImage(
                          calendarDotIcon,
                        ),
                      ),
                    ),
                    textStyle: interFont(),
                    todayTextStyle: interFont(),
                    todayCellDecoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.pink, width: 2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  selectionShape: DateRangePickerSelectionShape.circle,
                  onSelectionChanged: sc.onSelectionChanged,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
