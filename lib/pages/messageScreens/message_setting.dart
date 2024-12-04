import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/pages/doubleDateScreens/double_date_offers.dart';
import 'package:double_date/pages/messageScreens/block_users_from_chat_dialog.dart';
import 'package:double_date/pages/messageScreens/report_user_from_chat_dialog.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/message_setting_card.dart';
import 'package:double_date/utils/global_varibles.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageSettingsScreen extends StatefulWidget {
  const MessageSettingsScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<MessageSettingsScreen> createState() => _MessageSettingsScreenState();
}

class _MessageSettingsScreenState extends State<MessageSettingsScreen> {
  final mc = Get.put(MessageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Settings'),
      body: SingleChildScrollView(
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
              20.verticalSpace,
              const MessageSettingCard(
                text: 'Mute Notifications',
                showSwitch: true,
              ),
              MessageSettingCard(
                text: 'Schedule Double Date',
                onTap: () {
                  GlobalVariable.isFromChatSetting = true;
                  Get.to(() => const DoubleDateOffersScreen());
                },
              ),
              MessageSettingCard(
                text: 'Report Users',
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return ReportUserFromChatDialog(
                        conversationId: widget.conversationId,
                      );
                    },
                  );
                },
              ),
              MessageSettingCard(
                text: 'Block Users',
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return BlockUserFromChatDialog(
                        conversationId: widget.conversationId,
                      );
                    },
                  );
                },
              ),
              MessageSettingCard(
                text: 'Leave Group Chat',
                onTap: () async {
                  await mc.onLeaveGroup(
                    context: context,
                    conversationId: widget.conversationId,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
