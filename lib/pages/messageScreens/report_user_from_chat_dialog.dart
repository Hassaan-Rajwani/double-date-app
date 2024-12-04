import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/card_with_chechbox_and_input.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReportUserFromChatDialog extends StatefulWidget {
  const ReportUserFromChatDialog({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<ReportUserFromChatDialog> createState() => ReportUserFromChatDialogState();
}

class ReportUserFromChatDialogState extends State<ReportUserFromChatDialog> {
  final mc = Get.put(MessageController());
  final sc = Get.put(SocketController());

  @override
  void dispose() {
    sc.emitChatRoom();
    mc.closeChoosePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (mc) {
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
                  Stack(
                    children: [
                      Form(
                        key: mc.reportReasonFormKey,
                        child: Column(
                          children: [
                            Text(
                              'Report Users',
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
                                itemCount: mc.groupDetail.participants!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final pc = Get.put(ProfileController());
                                  final data = mc.groupDetail.participants![index];
                                  if (mc.groupDetail.participants![index].sId != pc.user.value.sId) {
                                    return CardWithCheckboxAndInput(
                                      index: index,
                                      data: data,
                                      controller: mc.reportReasonController,
                                      onChanged: (bool? value) {
                                        mc.toggleChoosePlayerCheckbox(index, value!, widget.conversationId);
                                      },
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            if (mc.selectedPlayers.isNotEmpty)
                              Column(
                                children: [
                                  24.verticalSpace,
                                  SizedBox(
                                    width: 1.sw,
                                    height: 50,
                                    child: AppButton(
                                      text: 'REPORT USER',
                                      horizontalMargin: 0,
                                      onPress: () async {
                                        await mc.onReportGroupMember(context: context);
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(crossIcon),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
