import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final settingController = Get.put(SettingController());
  final pc = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Change Password'),
      body: GetBuilder<SettingController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: controller.changePasswordFormKey,
                child: Column(
                  children: [
                    20.verticalSpace,
                    AppInput(
                      label: 'Old Password',
                      placeHolder: 'Enter your old password',
                      showPasswordIcon: true,
                      obscureText: controller.oldPassword,
                      onTap: controller.toggleOldPassword,
                      horizontalMargin: 0,
                      controller: controller.oldPasswordController,
                      validator: (password) => oldPasswordValidator(password.toString()),
                    ),
                    AppInput(
                      label: 'New Password',
                      placeHolder: 'Enter your new password',
                      showPasswordIcon: true,
                      obscureText: controller.newPassword,
                      onTap: controller.toggleNewPassword,
                      horizontalMargin: 0,
                      controller: controller.newPasswordController,
                      validator: (password) => passwordValidator(password.toString()),
                    ),
                    AppInput(
                      label: 'Confirm Password',
                      placeHolder: 'Enter your confirm password',
                      showPasswordIcon: true,
                      obscureText: controller.confirmPassword,
                      onTap: controller.toggleConfirmPassword,
                      horizontalMargin: 0,
                      controller: controller.confirmNewPasswordController,
                      validator: (password) => passwordValidator(
                        password.toString(),
                        password2: controller.newPasswordController.value.text,
                      ),
                    ),
                    22.verticalSpace,
                    if (pc.user.value.provider != 'Google' && pc.user.value.provider != 'Apple')
                      AppButton(
                        text: 'CHANGE PASSWORD',
                        horizontalMargin: 0,
                        onPress: () async {
                          await controller.onChangePassword(context: context);
                        },
                      )
                    else
                      Text(
                        'Can\'t change password with social login.',
                        style: interFont(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
