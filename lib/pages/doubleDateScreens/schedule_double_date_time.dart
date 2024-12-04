// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/schedule_double_date_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/models/doube_date_offer_model.dart';
import 'package:double_date/pages/doubleDateScreens/invite_friends_dialog.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/pages/messageScreens/chat_room.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class ScheduleDoubleDateTime extends StatefulWidget {
  const ScheduleDoubleDateTime({super.key});

  @override
  State<ScheduleDoubleDateTime> createState() => _ScheduleDoubleDateTimeState();
}

class _ScheduleDoubleDateTimeState extends State<ScheduleDoubleDateTime> {
  final btController = Get.put(BottomNavController());
  final sc = Get.put(ScheduleDoubleDateCalendarController());
  final socket = Get.put(SocketController());
  final mc = Get.put(MessageController());

  @override
  void dispose() {
    sc.clearTime();
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
                child: Form(
                  key: sc.formKey,
                  child: Column(
                    children: [
                      10.verticalSpace,
                      Column(
                        children: [
                          Text(
                            'Select Time',
                            style: interFont(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          16.verticalSpace,
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
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
                            child: TimePickerSpinner(
                              is24HourMode: false,
                              normalTextStyle: interFont(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              highlightedTextStyle: interFont(fontSize: 24.0, fontWeight: FontWeight.w700),
                              spacing: 80,
                              isForce2Digits: true,
                              // time: sc.scheduleDoubleDateTime.value,
                              time: DateTime.now(),
                              onTimeChange: (time) {
                                sc.updateDoubleDateTime(time);
                              },
                            ),
                          ),
                          24.verticalSpace,
                        ],
                      ),
                      AppInput(
                        placeHolder: 'Write Description',
                        label: 'Description',
                        maxLines: 6,
                        maxLenght: 200,
                        horizontalMargin: 0,
                        controller: sc.descriptionController.value,
                        validator: (time) => timerDescriptionValidator(time!),
                      ),
                      22.verticalSpace,
                      AppButton(
                        text: 'SEND INVITE',
                        horizontalMargin: 0,
                        onPress: () {
                          if (sc.formKey.currentState != null && sc.formKey.currentState!.validate()) {
                            final description = sc.descriptionController.value.text;
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return InviteFriendsDialog(
                                  onContinue: () {
                                    DoubleDateOfferModel updatedData = sc.selectedOffer.value;
                                    updatedData.description = description.toString();
                                    socket.emitSendMessage(
                                      conversationId: mc.selectedGroup[0].sId,
                                      isFromGame: true,
                                      messageType: 'doubleDate',
                                      shareResponse: jsonEncode(updatedData),
                                    );
                                    sc.descriptionController.value.clear();
                                    Future.delayed(const Duration(seconds: 1), () {
                                      Get.to(
                                        () => ChatRoomScreen(conversationId: mc.selectedGroup[0].sId),
                                      );
                                    });
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
