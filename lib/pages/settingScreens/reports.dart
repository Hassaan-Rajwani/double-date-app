import 'package:double_date/pages/settingScreens/post_reported_list.dart';
import 'package:double_date/pages/settingScreens/screenWidgets/setting_card.dart';
import 'package:double_date/pages/settingScreens/user_reported_list.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Reports'),
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
              SettingCard(
                text: 'Post-Reported List',
                onTap: () {
                  Get.to(() => const PostReportedList());
                },
              ),
              SettingCard(
                text: 'User-Reported List',
                onTap: () {
                  Get.to(() => const UserReportedListScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
