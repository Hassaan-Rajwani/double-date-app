import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/pages/doubleDateScreens/screenWidgets/invite_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:get/get.dart';

class InviteFriendsDialog extends StatefulWidget {
  const InviteFriendsDialog({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<InviteFriendsDialog> createState() => _InviteFriendsDialogState();
}

class _InviteFriendsDialogState extends State<InviteFriendsDialog> {
  final messageController = Get.put(MessageController());

  @override
  void dispose() {
    messageController.closeChooseGroup();
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
                  Stack(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Invite Friends',
                            style: interFont(
                              fontWeight: FontWeight.w600,
                              fontSize: 22.0.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          24.verticalSpace,
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              itemCount: controller.chatRooms.where((room) => room.isDisabled == false).length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final data = controller.chatRooms.where((room) => room.isDisabled == false).toList()[index];
                                if (data.isDisabled == false) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: InviteCard(
                                      data: data,
                                      onChanged: (bool? value) {
                                        controller.toggleChooseGroupCheckbox(index, value!);
                                      },
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    height: 180,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No Rooms Available',
                                            style: interFont(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          10.verticalSpace,
                                          AppButton(
                                            text: 'GO TO DASHBAORD',
                                            horizontalMargin: 0,
                                            onPress: () {
                                              Get.offUntil(
                                                GetPageRoute(
                                                  page: () {
                                                    return const Dashboard();
                                                  },
                                                ),
                                                (route) => route.settings.name == "/Dashboard",
                                              );
                                              Get.close(1);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          if (controller.selectedGroup.isNotEmpty)
                            SizedBox(
                              width: 1.sw,
                              height: 50,
                              child: AppButton(
                                text: 'CONTINUE',
                                horizontalMargin: 0,
                                onPress: widget.onContinue,
                              ),
                            ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offUntil(
                            GetPageRoute(
                              page: () {
                                return const Dashboard();
                              },
                            ),
                            (route) => route.settings.name == "/Dashboard",
                          );
                          Get.close(1);
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
