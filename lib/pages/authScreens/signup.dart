import 'package:double_date/controllers/auth_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final authController = Get.put(AuthController());

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
                key: controller.signupFormKey,
                child: Column(
                  children: [
                    87.verticalSpace,
                    Text(
                      'Sign Up',
                      style: interFont(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    18.verticalSpace,
                    Text(
                      'Enter your credential to Register your account.',
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
                      controller: controller.signupEmailController,
                      validator: (email) => emailValidator(email!),
                    ),
                    AppInput(
                      label: 'Password',
                      placeHolder: 'Enter your password',
                      showPasswordIcon: true,
                      obscureText: controller.signupNewPassword,
                      onTap: controller.toggleSignupNewPassword,
                      horizontalMargin: 0,
                      controller: controller.signupPasswordController,
                      validator: (password) => passwordValidator(password.toString()),
                    ),
                    AppInput(
                      label: 'Confirm Password',
                      placeHolder: 'Re enter your password',
                      showPasswordIcon: true,
                      obscureText: controller.signupConfirmPassword,
                      onTap: controller.toggleSignupConfirmPassword,
                      horizontalMargin: 0,
                      controller: controller.signupConfirmPasswordController,
                      validator: (password) => passwordValidator(
                        password.toString(),
                        password2: controller.signupPasswordController.value.text,
                      ),
                    ),
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
                            value: controller.signupIsChecked,
                            onChanged: (bool? value) {
                              controller.singupChangeCheckValue(value!);
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                          ),
                        ),
                        10.horizontalSpace,
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'I agree to ',
                                style: interFont(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms of Service ',
                                style: interFont(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: '& ',
                                style: interFont(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: interFont(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    33.verticalSpace,
                    AppButton(
                      text: 'SIGN UP',
                      horizontalMargin: 0,
                      onPress: () async {
                        await controller.onSignup(context: context);
                      },
                    ),
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
            Get.back();
          },
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: 'Already have an account? ',
                  style: interFont(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: 'Login',
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
