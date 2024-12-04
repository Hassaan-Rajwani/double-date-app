import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TicTacToeShareDialog extends StatefulWidget {
  const TicTacToeShareDialog({super.key, required this.onShareToChat});

  final VoidCallback onShareToChat;

  @override
  State<TicTacToeShareDialog> createState() => _TicTacToeShareDialogState();
}

class _TicTacToeShareDialogState extends State<TicTacToeShareDialog> {
  final bc = Get.put(BottomNavController());

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
              Image.asset(tickIcon),
              Text(
                'Congratulations',
                style: interFont(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0.sp,
                ),
                textAlign: TextAlign.center,
              ),
              8.verticalSpace,
              Text(
                'You have Completed your challenge.',
                style: interFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              // 24.verticalSpace,
              // SizedBox(
              //   width: 1.sw,
              //   height: 50,
              //   child: AppButton(
              //     text: 'SHARE TO FEED',
              //     horizontalMargin: 0,
              //     onPress: () {
              //       showDialog(
              //         barrierDismissible: false,
              //         context: context,
              //         builder: (context) {
              //           return const ShareToFeedDialog(
              //             name: 'Sarah',
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
              24.verticalSpace,
              SizedBox(
                width: 1.sw,
                height: 50,
                child: AppButton(
                  text: 'SHARE TO CHAT',
                  horizontalMargin: 0,
                  isGradinet: false,
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.pink,
                  onPress: widget.onShareToChat,
                ),
              ),
              24.verticalSpace,
              SizedBox(
                width: 1.sw,
                height: 50,
                child: AppButton(
                  text: 'GO BACK',
                  horizontalMargin: 0,
                  isGradinet: false,
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.pink,
                  onPress: () {
                    bc.navBarChange(1);
                    Get.offAll(() => const Dashboard());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
