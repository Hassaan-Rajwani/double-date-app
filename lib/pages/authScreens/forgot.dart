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

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final ac = Get.put(AuthController());

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
                key: controller.forgotFormKey,
                child: Column(
                  children: [
                    10.verticalSpace,
                    Text(
                      'Forgot Password',
                      style: interFont(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    18.verticalSpace,
                    Text(
                      'Enter your email address to reset your\npassword.',
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    47.verticalSpace,
                    AppInput(
                      label: 'Email',
                      placeHolder: 'Enter your email address',
                      horizontalMargin: 0,
                      controller: controller.forgotEmailController,
                      validator: (email) => emailValidator(email!),
                    ),
                    22.verticalSpace,
                    AppButton(
                      text: 'CONTINUE',
                      horizontalMargin: 0,
                      onPress: () async {
                        await controller.onForgotPassword(context: context);
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
