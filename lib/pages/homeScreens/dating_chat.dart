import 'package:double_date/controllers/date_consultant_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/dating_consultant_input.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/reciever_chat_box.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/double_button_dialog.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DatingChat extends StatefulWidget {
  const DatingChat({super.key});

  @override
  State<DatingChat> createState() => _DatingChatState();
}

class _DatingChatState extends State<DatingChat> {
  final dcc = Get.put(DatingConsultantController());
  final sc = Get.put(SocketController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatingConsultantController>(
      builder: (dcc) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: backButtonAppbar(
            title: 'Dating Consultant',
            showSkipButton: true,
            onSkipTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return DoubleButtonDialog(
                    onNo: () {
                      Get.close(1);
                    },
                    onYes: () async {
                      sc.emitCloseChat();
                      Get.close(2);
                      Get.snackbar(
                        'Success',
                        'Chat Closed Successfully',
                        backgroundColor: Colors.white,
                      );
                    },
                    heading: 'Close Chat',
                    bodyText: 'Are you sure you want\nto close this chat?',
                  );
                },
              );
            },
            skipButtonText: 'CLOSE CHAT',
            titleSize: 16,
            skipSize: 10,
            customeSkipPadding: true,
          ),
          body: Container(
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
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
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
                  child: FittedBox(
                    child: Text(
                      'Messages are encrypted with end-to-end encryption',
                      style: interFont(
                        color: const Color(0xFFB1124C),
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: dcc.msgLoader
                      ? Center(
                          child: spinkit,
                        )
                      : dcc.messages.isEmpty
                          ? Center(
                              child: Text(
                                'Start Conversation...',
                                style: interFont(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.builder(
                                controller: dcc.scrollController,
                                itemCount: dcc.messages.length,
                                itemBuilder: (context, index) {
                                  final data = dcc.messages[index];
                                  return RecieverChatBox(
                                    msgType: 'text',
                                    userName: data['by'] == 'User' ? 'You' : data['by'],
                                    msg: data['message'],
                                    msgTime: formatTimeFromDate(data['createdAt']),
                                    isSender: data['by'] == 'User',
                                    media: '',
                                  );
                                },
                              ),
                            ),
                ),
                DatingConsultantInput(
                  inputController: dcc.chatController,
                  onMessageSend: () {
                    sc.emitConsultantMessage();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
