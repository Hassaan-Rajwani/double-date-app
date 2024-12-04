import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/pages/settingScreens/shorts_bottomsheet.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GroupNameDialog extends StatefulWidget {
  const GroupNameDialog({
    super.key,
    required this.onYes,
    required this.onNo,
  });

  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  State<GroupNameDialog> createState() => _GroupNameDialogState();
}

class _GroupNameDialogState extends State<GroupNameDialog> {
  final mc = Get.put(MessageController());

  @override
  void dispose() {
    mc.groupImage = null;
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
                      Column(
                        children: [
                          Text(
                            'Group Details',
                            style: interFont(
                              fontWeight: FontWeight.w600,
                              fontSize: 22.0.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          24.verticalSpace,
                          Stack(
                            children: [
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
                                child: mc.groupImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(100.r),
                                        child: Image.file(
                                          mc.groupImage!,
                                          width: 130,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : LoaderImage(
                                        url: mc.groupDetail.picture!,
                                        width: 130,
                                        height: 130,
                                        borderRadius: 100,
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom,
                                          ),
                                          child: ShortsBottomSheet(
                                            title: 'Upload',
                                            onCameraTap: () {
                                              Get.back();
                                              mc.pickGroupImage(oepnCamera: true);
                                            },
                                            onGalleryTap: () {
                                              Get.back();
                                              mc.pickGroupImage();
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(cameraIcon),
                                ),
                              ),
                            ],
                          ),
                          24.verticalSpace,
                          AppInput(
                            placeHolder: 'Group Name',
                            horizontalMargin: 0,
                            verticalPadding: 0,
                            bottomMargin: 0,
                            controller: mc.groupNameController,
                          ),
                          24.verticalSpace,
                          FittedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 138,
                                  height: 50,
                                  child: AppButton(
                                    text: 'SAVE',
                                    minWidth: 138,
                                    horizontalMargin: 0,
                                    onPress: widget.onYes,
                                  ),
                                ),
                                24.horizontalSpace,
                                SizedBox(
                                  width: 138,
                                  height: 50,
                                  child: AppButton(
                                    text: 'CANCEL',
                                    minWidth: 138,
                                    backgroundColor: Colors.transparent,
                                    isGradinet: false,
                                    borderColor: Colors.white,
                                    horizontalMargin: 0,
                                    onPress: widget.onNo,
                                  ),
                                ),
                              ],
                            ),
                          )
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
