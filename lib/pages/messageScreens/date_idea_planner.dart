import 'dart:convert';
import 'package:double_date/controllers/date_planner_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/models/date_planner_model.dart';
import 'package:double_date/pages/messageScreens/chat_room.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/ider_planner_card.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DateIdeaPlannerScreen extends StatefulWidget {
  const DateIdeaPlannerScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<DateIdeaPlannerScreen> createState() => DateIdeaPlannerScreenState();
}

class DateIdeaPlannerScreenState extends State<DateIdeaPlannerScreen> {
  final dc = Get.put(DatePlannerController());
  final sc = Get.put(SocketController());

  @override
  void initState() {
    dc.getPlannerList(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Date Idea Planning'),
      body: GetBuilder<DatePlannerController>(
        builder: (dc) {
          return ListView.builder(
            itemCount: dc.plannerList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = dc.plannerList[index];
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(heartBg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    20.verticalSpace,
                    IdeaPlannerCard(
                      title: dc.plannerList[index].title,
                      msg: data.description,
                      imagePath: sarah3,
                      onTap: () {
                        DatePlannerModel updatedData = data;
                        sc.emitSendMessage(
                          conversationId: widget.conversationId,
                          isFromGame: true,
                          messageType: 'ideaPlanner',
                          shareResponse: jsonEncode(updatedData),
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          Get.to(
                            () => ChatRoomScreen(conversationId: widget.conversationId),
                          );
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
