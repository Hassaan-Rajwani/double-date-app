import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/pages/messageScreens/chat_room.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/message_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final mc = Get.put(MessageController());
  final sc = Get.put(SocketController());

  @override
  void initState() {
    sc.emitChatRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<MessageController>(
        builder: (controller) {
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
                children: [
                  5.verticalSpace,
                  AppInput(
                    placeHolder: 'Search conversations...',
                    horizontalMargin: 0,
                    verticalPadding: 0,
                    onInputTap: () {},
                    postfixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(searchIcon),
                    ),
                  ),
                  10.verticalSpace,
                  controller.roomLoader
                      ? SizedBox(
                          height: 0.65.sh,
                          child: Center(child: spinkit),
                        )
                      : controller.chatRooms.isEmpty
                          ? SizedBox(
                              height: 0.65.sh,
                              child: Center(
                                child: Text(
                                  'No Chatrooms Available',
                                  style: interFont(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.chatRooms.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final data = controller.chatRooms[index];
                                return MessageCard(
                                  data: data,
                                  onTap: () {
                                    Get.to(
                                      () => ChatRoomScreen(
                                        conversationId: data.sId!,
                                        isDisable: data.isDisabled,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
