import 'package:double_date/controllers/auth_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(),
      backgroundColor: Colors.black,
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: controller.resetFormKey,
                child: Column(
                  children: [
                    10.verticalSpace,
                    Text(
                      'Reset Password',
                      style: interFont(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    18.verticalSpace,
                    Text(
                      'Enter your new password.',
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    47.verticalSpace,
                    AppInput(
                      controller: controller.resetPasswordController,
                      label: 'New Password',
                      placeHolder: 'Enter your new password',
                      showPasswordIcon: true,
                      obscureText: controller.newPassword,
                      onTap: controller.toggleNewPassword,
                      horizontalMargin: 0,
                      validator: (password) => passwordValidator(password.toString()),
                    ),
                    AppInput(
                      controller: controller.resetConfirmPasswordController,
                      label: 'Confirm Password',
                      placeHolder: 're enter your password',
                      showPasswordIcon: true,
                      obscureText: controller.confirmPassword,
                      onTap: controller.toggleConfirmPassword,
                      horizontalMargin: 0,
                      validator: (password) => passwordValidator(
                        password.toString(),
                        password2: controller.resetPasswordController.value.text,
                      ),
                    ),
                    22.verticalSpace,
                    AppButton(
                      text: 'RESET',
                      horizontalMargin: 0,
                      onPress: () {
                        controller.onResetPassword(context: context);
                      },
                    ),
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
