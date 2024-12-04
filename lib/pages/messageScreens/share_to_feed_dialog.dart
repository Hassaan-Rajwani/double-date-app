import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShareToFeedDialog extends StatefulWidget {
  const ShareToFeedDialog({super.key, required this.name});

  final String name;

  @override
  State<ShareToFeedDialog> createState() => _ShareToFeedDialogState();
}

class _ShareToFeedDialogState extends State<ShareToFeedDialog> {
  final btController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
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
                        'Share Activity',
                        style: interFont(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      24.verticalSpace,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          sarah,
                          width: 1.sw,
                          height: 121,
                          fit: BoxFit.cover,
                        ),
                      ),
                      24.verticalSpace,
                      Container(
                        width: 1.sw,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Challenge Played by Sarah & David',
                          style: interFont(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      24.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(cupIcon),
                          20.horizontalSpace,
                          Text(
                            'Winner is ${widget.name}',
                            style: interFont(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      24.verticalSpace,
                      SizedBox(
                        width: 1.sw,
                        height: 50,
                        child: AppButton(
                          text: 'SHARE',
                          horizontalMargin: 0,
                          onPress: () {
                            btController.navBarChange(2);
                            Get.close(5);
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
  }
}
