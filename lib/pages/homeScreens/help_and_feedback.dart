import 'package:double_date/pages/homeScreens/feedback_screen.dart';
import 'package:double_date/pages/homeScreens/support_screen.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  const HelpAndFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Help & Feedback'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              26.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    text: 'FEEDBACK',
                    minWidth: 0.43.sw,
                    horizontalMargin: 0,
                    onPress: () {
                      Get.to(() => const FeedbackScreen());
                    },
                  ),
                  AppButton(
                    text: 'SUPPORT',
                    minWidth: 0.43.sw,
                    horizontalMargin: 0,
                    onPress: () {
                      Get.to(() => const SupportScreen());
                    },
                  ),
                ],
              ),
              30.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset(
                    bulbIcon,
                  ),
                  12.horizontalSpace,
                  Text(
                    'Help & guide for Double date app',
                    style: interFont(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: const Color(0xFFB1124C),
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard. Lorem Ipsum has been the industry\'s',
                style: interFont(
                  fontSize: 12.0,
                ),
              ),
              28.verticalSpace,
              Text(
                '1. Help & guide for Double date app',
                style: interFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: const Color(0xFFB1124C),
                ),
              ),
              15.verticalSpace,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard. Lorem Ipsum has been the industry\'s',
                style: interFont(
                  fontSize: 12.0,
                ),
              ),
              28.verticalSpace,
              Text(
                '2. Help & guide for Double date app',
                style: interFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: const Color(0xFFB1124C),
                ),
              ),
              15.verticalSpace,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard. Lorem Ipsum has been the industry\'s',
                style: interFont(
                  fontSize: 12.0,
                ),
              ),
              28.verticalSpace,
              Text(
                '3. Help & guide for Double date app',
                style: interFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: const Color(0xFFB1124C),
                ),
              ),
              15.verticalSpace,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard. Lorem Ipsum has been the industry\'s',
                style: interFont(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
