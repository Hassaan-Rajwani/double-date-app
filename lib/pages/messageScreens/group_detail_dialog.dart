// ignore_for_file: deprecated_member_use
import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/pages/messageScreens/group_name_dialog.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/card_with_checkbox.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GroupDetailDialog extends StatefulWidget {
  const GroupDetailDialog({super.key});

  @override
  State<GroupDetailDialog> createState() => _GroupDetailDialogState();
}

class _GroupDetailDialogState extends State<GroupDetailDialog> {
  final messageController = Get.put(MessageController());

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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          12.verticalSpace,
                          Text(
                            'Group Details',
                            style: interFont(
                              fontWeight: FontWeight.w600,
                              fontSize: 22.0.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          14.verticalSpace,
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.pink,
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pink.withOpacity(0.4),
                                  spreadRadius: 20,
                                  blurRadius: 100,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: LoaderImage(
                              url: mc.groupDetail.picture!,
                              width: 130,
                              height: 130,
                              borderRadius: 100,
                            ),
                          ),
                          14.verticalSpace,
                          AppInput(
                            placeHolder: mc.groupDetail.name!,
                            horizontalMargin: 0,
                            verticalPadding: 0,
                            bottomMargin: 0,
                            readOnly: true,
                            backColor: const Color(0xFFFF1472).withOpacity(0.3),
                            postfixIcon: GestureDetector(
                              onTap: () {
                                mc.saveGoupName(mc.groupDetail.name!);
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return GroupNameDialog(
                                      onYes: () async {
                                        await mc.updateRoomDetails(
                                          context: context,
                                          conversationId: mc.groupDetail.sId!,
                                        );
                                      },
                                      onNo: () {
                                        Get.back();
                                      },
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: SvgPicture.asset(
                                  editIcon,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          14.verticalSpace,
                          Text(
                            'Group Members',
                            style: interFont(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          14.verticalSpace,
                          SizedBox(
                            height: 260.h,
                            child: ListView.builder(
                              itemCount: mc.groupDetail.participants!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final data = mc.groupDetail.participants![index];
                                return CardWithCheckbox(
                                  onChanged: (bool? value) {},
                                  data: data,
                                  showCheckBox: false,
                                );
                              },
                            ),
                          ),
                        ],
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
