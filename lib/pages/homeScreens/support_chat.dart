// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/controllers/support_controller.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/support_chat_card.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/reciever_chat_box.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/emoji_input.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SupportChat extends StatefulWidget {
  const SupportChat({super.key, required this.ticketId, required this.status});

  final String ticketId;
  final String status;

  @override
  State<SupportChat> createState() => SupportChatState();
}

class SupportChatState extends State<SupportChat> {
  final sc = Get.put(SupportController());
  final pc = Get.put(ProfileController());
  final mc = Get.put(MessageController());
  final socket = Get.put(SocketController());

  @override
  void initState() {
    socket.emitTicketMessageList(
      ticketId: widget.ticketId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: 'Tickets',
        allowCustomOnBack: true,
        customOnBack: () {
          if (mc.emojiShowing == true) {
            Get.back();
          } else {
            mc.changeEmojiValue(true);
          }
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (mc.emojiShowing == true) {
            return true;
          } else {
            mc.changeEmojiValue(true);
            return false;
          }
        },
        child: GetBuilder<SupportController>(
          builder: (sc) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  20.verticalSpace,
                  Expanded(
                    child: sc.supportMsgLoader
                        ? Center(
                            child: spinkit,
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                              controller: sc.scrollController,
                              itemCount: sc.ticketMsgList.length,
                              itemBuilder: (context, index) {
                                final data = sc.ticketMsgList[index];
                                final content = data['content'];
                                final msgData = content['type'] == 'info' ? jsonDecode(content['message']) : content['message'];
                                if (content['type'] == 'info') {
                                  return SupportChatCard(
                                    userName: data['messageBy'] == 'User' ? 'You' : data['messageBy'],
                                    isSender: data['messageBy'] == 'User',
                                    time: formatTimeFromDate(data['createdAt']),
                                    title: msgData['title'],
                                    msg: msgData['description'],
                                  );
                                } else {
                                  return RecieverChatBox(
                                    userName: data['messageBy'] == 'User' ? 'You' : data['messageBy'],
                                    msg: msgData,
                                    msgTime: formatTimeFromDate(data['createdAt']),
                                    isSender: data['messageBy'] == 'User',
                                    showSendTime: false,
                                    msgType: 'text',
                                  );
                                }
                              },
                            ),
                          ),
                  ),
                  if (widget.status == 'Open')
                    Column(
                      children: [
                        16.verticalSpace,
                        EmojiInput(
                          inputController: sc.chatController,
                          showMediaOption: false,
                          onMedia: () {},
                          onMessageSend: () {
                            final msg = sc.chatController.value.text.trim();
                            if (msg.isEmpty) {
                              return;
                            }
                            socket.emitTicketReply(ticketId: widget.ticketId);
                          },
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
