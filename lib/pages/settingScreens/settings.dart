import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/pages/authScreens/login.dart';
import 'package:double_date/pages/paymentScreens/payment_method.dart';
import 'package:double_date/pages/settingScreens/about_us.dart';
import 'package:double_date/pages/settingScreens/block_user.dart';
import 'package:double_date/pages/settingScreens/change_password.dart';
import 'package:double_date/pages/settingScreens/privacy_policy.dart';
import 'package:double_date/pages/settingScreens/reports.dart';
import 'package:double_date/pages/settingScreens/screenWidgets/setting_card.dart';
import 'package:double_date/pages/settingScreens/terms_and_condition.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/double_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void dispose() {
    Get.delete<SettingController>();
    super.dispose();
  }

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
              const SettingCard(
                text: 'Notifications Settings',
                showSwitch: true,
              ),
              SettingCard(
                text: 'Change Password',
                onTap: () {
                  Get.to(() => const ChangePasswordScreen());
                },
              ),
              SettingCard(
                text: 'Blocked users',
                onTap: () {
                  Get.to(() => const BlockUserScreen());
                },
              ),
              SettingCard(
                text: 'Reports',
                onTap: () {
                  Get.to(() => const ReportScreen());
                },
              ),
              SettingCard(
                text: 'Payment Method',
                onTap: () {
                  Get.to(() => const PaymentMethodScreen());
                },
              ),
              SettingCard(
                text: 'About us',
                onTap: () {
                  Get.to(() => const AboutUsScreen());
                },
              ),
              SettingCard(
                text: 'Terms & Conditions',
                onTap: () {
                  Get.to(() => const TermsAndConditionScreen());
                },
              ),
              SettingCard(
                text: 'Privacy Policy',
                onTap: () {
                  Get.to(() => const PrivacyPolicyScreen());
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: AppButton(
          text: 'DELETE ACCOUNT',
          onPress: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return DoubleButtonDialog(
                  onNo: () {
                    Get.back();
                  },
                  onYes: () {
                    Get.offAll(() => const LoginScreen());
                  },
                  heading: 'Delate Account',
                  bodyText: 'Are you sure you want to\ndelete your account?',
                );
              },
            );
          },
        ),
      ),
    );
  }
}
