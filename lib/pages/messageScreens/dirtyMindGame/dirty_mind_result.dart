// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/pages/messageScreens/chat_room.dart';
import 'package:double_date/pages/messageScreens/share_to_chat_dialog.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DirtyMindGameResultScreen extends StatefulWidget {
  const DirtyMindGameResultScreen({
    super.key,
    required this.conversationId,
    this.isFromChat = false,
  });

  final String conversationId;
  final bool? isFromChat;

  @override
  State<DirtyMindGameResultScreen> createState() => DirtyMindGameResultScreenState();
}

class DirtyMindGameResultScreenState extends State<DirtyMindGameResultScreen> {
  final gameController = Get.put(GameController());
  final sc = Get.put(SocketController());

  void onBack() {
    Get.close(widget.isFromChat == false ? 2 : 1);
    gameController.dirtyMindCurrentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(
        title: 'Challenge',
        allowCustomOnBack: true,
        customOnBack: onBack,
      ),
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          if (widget.isFromChat == false) {
            onBack();
          }
          return true;
        },
        child: GetBuilder<GameController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                width: 1.sw,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(heartBg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Dirty Minds Challenge',
                          style: interFont(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      8.verticalSpace,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Question ${controller.dirtyMindsQuestions.length}',
                          style: interFont(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFB1124C),
                          ),
                        ),
                      ),
                      24.verticalSpace,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        width: 1.sw,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Colors.pink,
                            ),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Colors.black,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.dirtyMindAnswerCount()} Answer',
                                  style: interFont(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (widget.isFromChat == false)
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return ShareToChatDialog(
                                            onBack: () {
                                              gameController.dirtyMindCurrentIndex = 0;
                                              Get.close(4);
                                            },
                                            onShare: () {
                                              sc.emitSendMessage(
                                                conversationId: widget.conversationId,
                                                isFromGame: true,
                                                messageType: 'dirtyMinds',
                                                shareResponse: jsonEncode(gameController.dirtyMindsQuestions),
                                              );
                                              // gameController.dirtyMindCurrentIndex = 0;
                                              // Get.close(4);
                                              Future.delayed(const Duration(seconds: 1), () {
                                                Get.to(
                                                  () => ChatRoomScreen(conversationId: widget.conversationId),
                                                );
                                              });
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: SvgPicture.asset(share2Icon),
                                  )
                              ],
                            ),
                            10.verticalSpace,
                            const Divider(
                              color: Colors.white,
                              thickness: 0.4,
                            ),
                            10.verticalSpace,
                            SizedBox(
                              height: 0.65.sh,
                              child: ListView.builder(
                                itemCount: controller.dirtyMindsQuestions.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Question ${index + 1}',
                                          style: interFont(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        12.verticalSpace,
                                        Text(
                                          controller.dirtyMindsQuestions[index].question!,
                                          style: interFont(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if (controller.dirtyMindsQuestions[index].response != '')
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              12.verticalSpace,
                                              Text(
                                                'Your Answer',
                                                style: interFont(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              12.verticalSpace,
                                              if (controller.dirtyMindsQuestions[index].response.toString().trim().toLowerCase() ==
                                                  controller.dirtyMindsQuestions[index].answer.toString().trim().toLowerCase())
                                                AppButton(
                                                  text: controller.dirtyMindsQuestions[index].answer!,
                                                  horizontalMargin: 0,
                                                  verticalMargin: 0,
                                                  borderRadius: 10,
                                                  showIcon: true,
                                                  icon: SvgPicture.asset(
                                                    width: 25,
                                                    tick3Icon,
                                                  ),
                                                )
                                              else
                                                AppButton(
                                                  text: controller.dirtyMindsQuestions[index].response!,
                                                  horizontalMargin: 0,
                                                  verticalMargin: 15,
                                                  borderRadius: 10,
                                                  isGradinet: false,
                                                  borderColor: Colors.red,
                                                  backgroundColor: Colors.transparent,
                                                  showIcon: true,
                                                  icon: SvgPicture.asset(
                                                    crossIcon,
                                                    width: 25,
                                                    color: Colors.red,
                                                  ),
                                                  textColor: Colors.red,
                                                ),
                                            ],
                                          ),
                                        17.verticalSpace,
                                        Text(
                                          'Correct Answer',
                                          style: interFont(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        12.verticalSpace,
                                        AppButton(
                                          text: controller.dirtyMindsQuestions[index].answer!,
                                          horizontalMargin: 0,
                                          verticalMargin: 0,
                                          borderRadius: 10,
                                          showIcon: true,
                                          icon: SvgPicture.asset(
                                            width: 25,
                                            tick3Icon,
                                          ),
                                        ),
                                        80.verticalSpace,
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
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
