// ignore_for_file: deprecated_member_use
import 'package:double_date/controllers/schedule_double_date_controller.dart';
import 'package:double_date/pages/doubleDateScreens/schedule_double_date_time.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarSchedule extends StatefulWidget {
  const CalendarSchedule({
    super.key,
  });

  @override
  State<CalendarSchedule> createState() => _CalendarScheduleState();
}

class _CalendarScheduleState extends State<CalendarSchedule> {
  final sc = Get.put(ScheduleDoubleDateCalendarController());

  @override
  void dispose() {
    sc.clearDate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const Dashboard());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: backButtonAppbar(
          title: 'Schedule double date',
          allowCustomOnBack: true,
          customOnBack: () {
            Get.offAll(() => const Dashboard());
          },
        ),
        body: Obx(
          () {
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
                    AppInput(
                      placeHolder: sc.selectedScheduleDate.value == '' ? 'Select Date' : sc.selectedScheduleDate.value,
                      horizontalMargin: 0,
                      postfixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(calenderIcon),
                      ),
                      readOnly: true,
                    ),
                    sc.loader.value
                        ? Container(
                            alignment: Alignment.center,
                            height: 0.37.sh,
                            child: spinkit,
                          )
                        : Stack(
                            children: [
                              SfDateRangePicker(
                                initialDisplayDate: sc.initialDisplayDate.value,
                                initialSelectedDate: sc.initialDisplayDate.value,
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
                                showNavigationArrow: false,
                                navigationMode: DateRangePickerNavigationMode.snap,
                                monthViewSettings: DateRangePickerMonthViewSettings(
                                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                    textStyle: interFont(),
                                  ),
                                  dayFormat: 'E',
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
                              ),
                              Positioned(
                                child: Container(
                                  color: Colors.transparent,
                                  width: 1.sw,
                                  height: 0.37.sh,
                                ),
                              ),
                            ],
                          ),
                    22.verticalSpace,
                    AppButton(
                      text: 'CONTINUE',
                      horizontalMargin: 0,
                      onPress: () async {
                        if (sc.selectedScheduleDate.value == '') {
                          Get.snackbar(
                            'Required',
                            'Please select date',
                            backgroundColor: Colors.white,
                          );
                        } else {
                          Get.to(() => const ScheduleDoubleDateTime());
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
