// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/schedule_double_date_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/models/date_planner_model.dart';
import 'package:double_date/models/doube_date_offer_model.dart';
import 'package:double_date/models/message_model.dart';
import 'package:double_date/pages/doubleDateScreens/double_date_detail.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/pages/messageScreens/challenge_screen.dart';
import 'package:double_date/pages/messageScreens/chat_game_card.dart';
import 'package:double_date/pages/messageScreens/message_setting.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/accpet_reject_card.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/admin_challenge_tab.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/chat_appbar.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/date_idea_planner_card.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/reciever_chat_box.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/schedule_activity_chat_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/emoji_input.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    super.key,
    required this.conversationId,
    this.isDisable = false,
  });

  final String conversationId;
  final bool? isDisable;

  @override
  State<ChatRoomScreen> createState() => ChatRoomScreenState();
}

class ChatRoomScreenState extends State<ChatRoomScreen> {
  final bc = Get.put(BottomNavController());
  final messageController = Get.put(MessageController());
  final pc = Get.put(ProfileController());
  final sc = Get.put(SocketController());
  final schedule = Get.put(ScheduleDoubleDateCalendarController());
  final gc = Get.put(GameController());
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    sc.emitRoomMessages(conversationId: widget.conversationId);
    messageController.changeInChatRoomVal(true);
    messageController.getRoomDetails(
      context: context,
      conversationId: widget.conversationId,
      showLoader: false,
    );
    schedule.retrieveCalendars();
    super.initState();
  }

  @override
  void dispose() {
    sc.emitChatRoom();
    messageController.changeInChatRoomVal(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (messageController.emojiShowing == true) {
          // bc.navBarChange(1);
          // Get.offAll(() => const Dashboard());
          Get.offUntil(
            GetPageRoute(
              page: () {
                return const Dashboard();
              },
            ),
            (route) => route.settings.name == "/Dashboard",
          );
          Get.close(1);
          return true;
        } else {
          messageController.changeEmojiValue(true);
          return false;
        }
      },
      child: GetBuilder<MessageController>(
        builder: (controller) {
          final chatRoom = messageController.chatRooms.firstWhere((room) => room.sId == widget.conversationId);
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: chatAppbar(
              isDisable: widget.isDisable!,
              onBack: () {
                if (messageController.emojiShowing == true) {
                  // bc.navBarChange(1);
                  // Get.offAll(() => const Dashboard());
                  Get.offUntil(
                    GetPageRoute(
                      page: () {
                        return const Dashboard();
                      },
                    ),
                    (route) => route.settings.name == "/Dashboard",
                  );
                  Get.close(1);
                } else {
                  messageController.changeEmojiValue(true);
                }
              },
              title: chatRoom.name!,
              imageUrl: chatRoom.picture!,
              otherOptionTap: () {
                Get.to(() => MessageSettingsScreen(
                      conversationId: widget.conversationId,
                    ));
              },
              onProfileTap: () async {
                await messageController.getRoomDetails(
                  context: context,
                  conversationId: widget.conversationId,
                );
              },
            ),
            body: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: GetBuilder<MessageController>(
                builder: (controller) {
                  return Column(
                    children: [
                      20.verticalSpace,
                      if (widget.isDisable! == false)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AdminChallengeTab(onTap: () {
                            Get.to(
                              () => ChallengeScreen(
                                conversationId: widget.conversationId,
                              ),
                            );
                          }),
                        ),
                      Expanded(
                        child: controller.msgLoader
                            ? Center(
                                child: spinkit,
                              )
                            : controller.roomMessages.isEmpty
                                ? Center(
                                    child: Text(
                                    'Start Conversation...',
                                    style: interFont(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ))
                                : Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ListView.builder(
                                      controller: controller.scrollController,
                                      itemCount: controller.roomMessages.length,
                                      itemBuilder: (context, index) {
                                        final data = controller.roomMessages[index];
                                        if (data.messageType == 'knowMe' || data.messageType == 'dirtyMinds' || data.messageType == 'ticTacToe') {
                                          return GetBuilder<GameController>(
                                            builder: (gc) {
                                              return GestureDetector(
                                                onTap: () {
                                                  gc.onGameCardTap(
                                                    data: data,
                                                    conversationId: widget.conversationId,
                                                  );
                                                },
                                                child: ChatGameCard(
                                                  userName: pc.user.value.name == data.sender!.name! ? 'You' : data.sender!.name!,
                                                  msg: '',
                                                  msgTime: formatTimeFromDate(data.createdAt!),
                                                  isSender: data.sender!.sId == pc.user.value.sId,
                                                  msgType: data.messageType,
                                                  questionData: jsonDecode(data.content!),
                                                ),
                                              );
                                            },
                                          );
                                        } else if (data.messageType == 'doubleDate') {
                                          final offerData = DoubleDateOfferModel.fromJson(jsonDecode(data.content!));
                                          return ScheduleActivityChatCard(
                                            userName: pc.user.value.name == data.sender!.name! ? 'You' : data.sender!.name!,
                                            // msg: offerData.name!,
                                            msg: offerData.description!,
                                            msgTime: formatTimeFromDate(data.createdAt!),
                                            isSender: data.sender!.sId == pc.user.value.sId,
                                            msgType: 'doubleDate',
                                            viewActivity: true,
                                            onViewActivity: () {
                                              Get.to(
                                                () => DoubleDateDetailScreen(
                                                  id: offerData.sId!,
                                                ),
                                              );
                                            },
                                          );
                                        } else if (data.messageType == 'ideaPlanner') {
                                          final offerData = DatePlannerModel.fromJson(jsonDecode(data.content!));
                                          List<IdeaPlanner> otherUser = data.ideaPlanner!.where((item) {
                                            return item.user!.sId != data.sender!.sId;
                                          }).toList();
                                          return AcceptRejectCard(
                                            status: otherUser,
                                            userName: pc.user.value.name == data.sender!.name! ? 'You' : data.sender!.name!,
                                            msg: offerData.description!,
                                            msgTime: formatTimeFromDate(data.createdAt!),
                                            image: sarah3,
                                            onAccept: () {
                                              controller.updateDateIdeaPlannerStatus(
                                                context: context,
                                                msgId: data.sId!,
                                                conversationId: widget.conversationId,
                                                status: true,
                                                msgData: offerData,
                                              );
                                            },
                                            onReject: () {
                                              controller.updateDateIdeaPlannerStatus(
                                                context: context,
                                                msgId: data.sId!,
                                                conversationId: widget.conversationId,
                                                status: false,
                                                msgData: offerData,
                                              );
                                            },
                                            title: offerData.title!,
                                            isSender: data.sender!.sId == pc.user.value.sId,
                                          );
                                        } else {
                                          return RecieverChatBox(
                                            msgType: data.messageType!,
                                            userName: pc.user.value.name == data.sender!.name! ? 'You' : data.sender!.name!,
                                            msg: data.content!,
                                            msgTime: formatTimeFromDate(data.createdAt!),
                                            isSender: data.sender!.sId == pc.user.value.sId,
                                            media: data.media != null ? data.media! : '',
                                          );
                                        }
                                      },
                                    ),
                                  ),
                      ),
                      10.verticalSpace,
                      if (widget.isDisable! == false)
                        Column(
                          children: [
                            DateIdeaPlannerCard(
                              conversationId: widget.conversationId,
                            ),
                            16.verticalSpace,
                            EmojiInput(
                              inputController: controller.chatController,
                              onMedia: () {
                                controller.pickMedia(id: widget.conversationId);
                              },
                              onMessageSend: () {
                                final msg = controller.chatController.value.text.trim();
                                if (msg.isEmpty) {
                                  return;
                                }
                                sc.emitSendMessage(
                                  conversationId: widget.conversationId,
                                  text: controller.chatController.value.text,
                                );
                              },
                            ),
                          ],
                        )
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
