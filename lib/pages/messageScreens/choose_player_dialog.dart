import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/card_with_checkbox.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChosePlayerDialog extends StatefulWidget {
  const ChosePlayerDialog({
    super.key,
    required this.conversationId,
    required this.onPress,
  });

  final String conversationId;
  final VoidCallback onPress;

  @override
  State<ChosePlayerDialog> createState() => ChosePlayerDialogState();
}

class ChosePlayerDialogState extends State<ChosePlayerDialog> {
  final messageController = Get.put(MessageController());
  final sc = Get.put(SocketController());

  @override
  void dispose() {
    sc.emitChatRoom();
    messageController.closeChoosePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: 0.9.sw,
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(20.r),
              border: modalBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(crossIcon),
                    ),
                  ),
                  Text(
                    'Choose Players',
                    style: interFont(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  24.verticalSpace,
                  SizedBox(
                    height: 285,
                    child: ListView.builder(
                      itemCount: controller.groupDetail.participants!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final pc = Get.put(ProfileController());
                        final data = controller.groupDetail.participants![index];
                        if (controller.groupDetail.participants![index].sId != pc.user.value.sId) {
                          return CardWithCheckbox(
                            showCheckBox: true,
                            data: data,
                            onChanged: (bool? value) {
                              controller.toggleChoosePlayerCheckbox(index, value!, widget.conversationId);
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  if (controller.selectedPlayers.isNotEmpty)
                    Column(
                      children: [
                        24.verticalSpace,
                        SizedBox(
                          width: 1.sw,
                          height: 50,
                          child: AppButton(
                            text: 'START',
                            horizontalMargin: 0,
                            onPress: widget.onPress,
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
