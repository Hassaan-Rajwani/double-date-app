import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/pages/doubleDateScreens/schedule_double_date.dart';
import 'package:double_date/utils/global_varibles.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ScheduleActivityChatCard extends StatefulWidget {
  const ScheduleActivityChatCard({
    super.key,
    required this.userName,
    required this.msg,
    required this.msgTime,
    required this.isSender,
    required this.viewActivity,
    this.onViewActivity,
    this.msgType = '',
  });

  final String userName;
  final String msg;
  final String msgTime;
  final bool isSender;
  final bool viewActivity;
  final String? msgType;
  final VoidCallback? onViewActivity;

  @override
  State<ScheduleActivityChatCard> createState() => _ScheduleActivityChatCardState();
}

class _ScheduleActivityChatCardState extends State<ScheduleActivityChatCard> {
  final btController = Get.put(BottomNavController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 16,
        left: widget.isSender ? 30 : 0,
        right: widget.isSender ? 0 : 30,
      ),
      child: Align(
        alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: widget.isSender
                  ? BoxDecoration(
                      color: const Color(0xFFB1124C),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFA8A8A8).withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    )
                  : BoxDecoration(
                      border: modalBorder(width: 0.2),
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFA8A8A8).withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: interFont(
                      color: widget.isSender ? Colors.white : const Color(0xFFB1124C),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    widget.msg,
                    style: interFont(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  12.verticalSpace,
                  if (!widget.viewActivity)
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            sarah,
                            width: 1.sw,
                            height: 121.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        12.verticalSpace,
                      ],
                    ),
                  if (!widget.viewActivity)
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 75,
                            child: Stack(
                              children: [
                                customCard(),
                                Positioned(
                                  left: 15,
                                  child: customCard(),
                                ),
                                Positioned(
                                  left: 30,
                                  child: customCard(),
                                ),
                                Positioned(
                                  top: 12,
                                  left: 58,
                                  child: SvgPicture.asset(
                                    tickSquareIcon2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          15.horizontalSpace,
                          AppButton(
                            minWidth: 200,
                            text: 'Schedule Activity',
                            horizontalMargin: 0,
                            verticalMargin: 15,
                            isGradinet: false,
                            borderColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            onPress: () {
                              GlobalVariable.isFromSidebar = false;
                              Get.to(
                                () => const ScheduleDoubleDateScreen(),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  else
                    AppButton(
                      text: 'View Activity',
                      horizontalMargin: 0,
                      verticalMargin: 15,
                      isGradinet: false,
                      borderColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      onPress: widget.onViewActivity,
                      // () {
                      // Get.to(
                      //   () => DoubleDateDetailScreen(
                      //     isUpcomingDoubleDate: true,
                      //     onTap: () {
                      //       showDialog(
                      //         barrierDismissible: false,
                      //         context: context,
                      //         builder: (context) {
                      //           return BasicDialog(
                      //             heading: 'Double Date',
                      //             bodyText: 'Your Double date has been cancelled.',
                      //             onTap: () {
                      //               btController.navBarChange(1);
                      //               Get.close(3);
                      //             },
                      //           );
                      //         },
                      //       );
                      //     },
                      //   ),
                      // );
                      // },
                    ),
                  30.verticalSpace,
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              right: 16,
              child: Row(
                children: [
                  Text(
                    widget.msgTime,
                    style: interFont(
                      color: widget.isSender ? Colors.white : const Color(0xFFB1124C),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  8.horizontalSpace,
                  SvgPicture.asset(widget.isSender ? tickSquareIcon2 : tickSquareIcon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customCard() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 1,
            color: Colors.white,
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          sarah,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
