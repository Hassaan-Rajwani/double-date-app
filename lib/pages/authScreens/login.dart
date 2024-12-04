import 'dart:io';
import 'package:double_date/controllers/auth_controller.dart';
import 'package:double_date/controllers/social_auth_controller.dart';
import 'package:double_date/pages/authScreens/forgot.dart';
import 'package:double_date/pages/authScreens/signup.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.put(AuthController());
  final socialAuth = Get.put(SocialAuthController());

  @override
  void initState() {
    super.initState();
    Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    87.verticalSpace,
                    Text(
                      'Sign In',
                      style: interFont(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    18.verticalSpace,
                    Text(
                      'Hi! Welcome back, you’ve been missed.',
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    61.verticalSpace,
                    AppInput(
                      label: 'Email',
                      placeHolder: 'Enter your email address',
                      horizontalMargin: 0,
                      controller: controller.loginEmailController,
                      validator: (email) => emailValidator(email!),
                    ),
                    AppInput(
                      label: 'Password',
                      placeHolder: 'Enter your password',
                      showPasswordIcon: true,
                      obscureText: controller.showPassword,
                      onTap: controller.toggleShowPassword,
                      horizontalMargin: 0,
                      controller: controller.loginPasswordController,
                      validator: (password) => passwordValidator(password.toString()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Checkbox(
                                value: controller.isChecked,
                                onChanged: (bool? value) {
                                  controller.changeCheckValue(value!);
                                },
                                checkColor: Colors.black,
                                activeColor: Colors.white,
                              ),
                            ),
                            10.horizontalSpace,
                            Text(
                              'Remember me',
                              style: interFont(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ForgotScreen());
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFF93193A),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Text(
                              'Forgot password?',
                              style: interFont(
                                color: const Color(0xFF93193A),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    33.verticalSpace,
                    AppButton(
                      text: 'LOGIN',
                      horizontalMargin: 0,
                      onPress: () async {
                        await controller.onLogin(context: context);
                      },
                    ),
                    44.verticalSpace,
                    Text(
                      'Or Sign With',
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    46.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        socialAuth.onSocialLogin(context: context);
                      },
                      child: SvgPicture.asset(
                        Platform.isIOS ? appleIcon : googleIcon,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            Get.to(() => const SignupScreen());
          },
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: 'Don’t have an account? ',
                  style: interFont(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: 'Sign up',
                  style: interFont(
                    fontSize: 13.0,
                    color: const Color(0Xff93193A),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0Xff93193A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
