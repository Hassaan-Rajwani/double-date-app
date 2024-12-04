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

class KnowMeGameResultScreen extends StatefulWidget {
  const KnowMeGameResultScreen({
    super.key,
    required this.conversationId,
    this.isFromChat = false,
    this.isFromPushNotification = false,
  });

  final String conversationId;
  final bool? isFromChat;
  final bool? isFromPushNotification;

  @override
  State<KnowMeGameResultScreen> createState() => KnowMeGameResultScreenState();
}

class KnowMeGameResultScreenState extends State<KnowMeGameResultScreen> {
  final gameController = Get.put(GameController());
  final sc = Get.put(SocketController());

  void onBack() {
    Get.close(widget.isFromChat == false ? 2 : 1);
    gameController.knowMeCurrentIndex = 0;
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
                          'List of Answers',
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
                          'Question ${controller.knowMeQuestions.length}',
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
                            Text(
                              '${controller.knowMeAnswerCount()} Answer',
                              style: interFont(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            10.verticalSpace,
                            const Divider(
                              color: Colors.white,
                              thickness: 0.4,
                            ),
                            10.verticalSpace,
                            SizedBox(
                              height: 0.55.sh,
                              child: ListView.builder(
                                itemCount: controller.knowMeQuestions.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              controller.knowMeQuestions[index].response != '' ? selectedIcon : unSelectedIcon,
                                            ),
                                            10.horizontalSpace,
                                            SizedBox(
                                              width: 0.75.sw,
                                              child: Text(
                                                controller.knowMeQuestions[index].question!,
                                                style: interFont(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (controller.knowMeQuestions[index].response != '')
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              10.verticalSpace,
                                              Padding(
                                                padding: const EdgeInsets.only(left: 39),
                                                child: Text(
                                                  controller.knowMeQuestions[index].response!,
                                                  style: interFont(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xFFB1124C),
                                                    decoration: TextDecoration.underline,
                                                    decorationColor: const Color(0xFFB1124C),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        10.verticalSpace,
                                        const Divider(
                                          color: Colors.white,
                                        ),
                                        10.verticalSpace,
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
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            if (widget.isFromChat == false)
              Padding(
                padding: const EdgeInsets.all(20),
                child: AppButton(
                  text: 'SHARE',
                  horizontalMargin: 0,
                  onPress: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return ShareToChatDialog(
                          onBack: () {
                            gameController.knowMeCurrentIndex = 0;
                            Get.close(widget.isFromPushNotification! ? 3 : 4);
                          },
                          onShare: () {
                            sc.emitSendMessage(
                              conversationId: widget.conversationId,
                              isFromGame: true,
                              messageType: 'knowMe',
                              shareResponse: jsonEncode(gameController.knowMeQuestions),
                            );
                            gameController.knowMeCurrentIndex = 0;
                            // Get.close(widget.isFromPushNotification! ? 3 : 4);
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
                ),
              ),
          ],
        ),
      ),
    );
  }
}
