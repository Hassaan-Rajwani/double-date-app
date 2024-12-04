import 'package:double_date/controllers/auth_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.isFromSignUp,
  });

  final bool isFromSignUp;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final authContoller = Get.put(AuthController());

  @override
  void initState() {
    authContoller.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        String timerText = '${controller.minutes.toString().padLeft(2, '0')}:${controller.seconds.toString().padLeft(2, '0')}';
        return Scaffold(
          appBar: backButtonAppbar(),
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 0.8.sh,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: controller.signupOtpFormKey,
                child: Column(
                  children: [
                    10.verticalSpace,
                    Text(
                      'One Time Password',
                      style: interFont(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    18.verticalSpace,
                    Text(
                      'We have sent you an email containing\n4 digit of verification code. Please enter the code\nto verify your identity',
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    47.verticalSpace,
                    PinCodeTextField(
                      controller: controller.signupOtpController,
                      length: 4,
                      onChanged: (value) {
                        controller.optOnchange(value);
                      },
                      appContext: context,
                      enableActiveFill: true,
                      enablePinAutofill: false,
                      autoDisposeControllers: false,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      textStyle: interFont(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      errorTextSpace: 26,
                      errorTextMargin: const EdgeInsets.only(left: 20),
                      validator: (otp) => otpValidator(otp.toString()),
                      pinTheme: PinTheme(
                        fieldHeight: 56,
                        fieldWidth: 56,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(12),
                        shape: PinCodeFieldShape.box,
                        activeColor: controller.otpErrorMessage == null ? const Color(0xFFFF1472) : Colors.red,
                        inactiveColor: controller.otpErrorMessage == null ? const Color(0xFFFF1472) : Colors.red,
                        selectedColor: controller.otpErrorMessage == null ? const Color(0xFFFF1472) : Colors.red,
                        errorBorderColor: Colors.red,
                        errorBorderWidth: 1.5,
                        activeFillColor: Colors.black,
                        inactiveFillColor: Colors.black,
                        selectedFillColor: Colors.black,
                        activeBorderWidth: 1.5,
                        inactiveBorderWidth: 1.5,
                        selectedBorderWidth: 1.5,
                      ),
                    ),
                    22.verticalSpace,
                    AppButton(
                      text: 'VERIFY',
                      horizontalMargin: 0,
                      onPress: () async {
                        await controller.onOtpVerify(
                          isFromSignup: widget.isFromSignUp,
                          context: context,
                        );
                      },
                    ),
                    64.verticalSpace,
                    Center(
                      child: CircularPercentIndicator(
                        radius: 80.0,
                        linearGradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF1472),
                            Color(0xFFB1124C),
                            Color(0xFF831136),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        lineWidth: 10.0,
                        percent: 1,
                        addAutomaticKeepAlive: true,
                        animation: true,
                        animationDuration: 60000,
                        backgroundColor: const Color(0xFF333333),
                        animateFromLastPercent: true,
                        center: Container(
                          height: 100.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              timerText,
                              style: interFont(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 60,
            child: Column(
              children: [
                if (controller.seconds == 60)
                  GestureDetector(
                    onTap: () async {
                      await controller.resendOtp(
                        isFromSignup: widget.isFromSignUp,
                        context: context,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Didn’t receive a code? ',
                              style: interFont(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Resend',
                              style: interFont(
                                fontSize: 13.0,
                                color: const Color(0Xff93193A),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
