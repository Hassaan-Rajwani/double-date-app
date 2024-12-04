// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:io';
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/user_model.dart';
import 'package:double_date/pages/authScreens/create_profile.dart';
import 'package:double_date/pages/authScreens/login.dart';
import 'package:double_date/pages/authScreens/otp_screen.dart';
import 'package:double_date/pages/authScreens/reset_password.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/repositories/auth_repository.dart';
import 'package:double_date/utils/global_varibles.dart';
import 'package:double_date/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  bool showPassword = true;
  bool newPassword = true;
  bool signupNewPassword = true;
  bool confirmPassword = true;
  bool signupConfirmPassword = true;
  bool isChecked = false;
  bool signupIsChecked = false;
  String? otpErrorMessage;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController signupOtpController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  TextEditingController resetConfirmPasswordController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController forgotEmailController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final signupOtpFormKey = GlobalKey<FormState>();
  final forgotFormKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();
  final pc = Get.put(ProfileController());

  int seconds = 60;
  int minutes = 0;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    rememberMeData();
  }

  clearAuthInput({required bool isChecked}) {
    if (isChecked == false) {
      loginEmailController = TextEditingController();
      loginPasswordController = TextEditingController();
      update();
    }
    signupOtpController = TextEditingController();
    signupEmailController = TextEditingController();
    signupPasswordController = TextEditingController();
    signupConfirmPasswordController = TextEditingController();
    resetPasswordController = TextEditingController();
    resetConfirmPasswordController = TextEditingController();
    forgotEmailController = TextEditingController();
    update();
  }

  toggleShowPassword() {
    showPassword = !showPassword;
    update();
  }

  toggleNewPassword() {
    newPassword = !newPassword;
    update();
  }

  toggleConfirmPassword() {
    confirmPassword = !confirmPassword;
    update();
  }

  toggleSignupNewPassword() {
    signupNewPassword = !signupNewPassword;
    update();
  }

  toggleSignupConfirmPassword() {
    signupConfirmPassword = !signupConfirmPassword;
    update();
  }

  changeCheckValue(bool val) async {
    isChecked = val;
    update();
    await onRemember();
  }

  singupChangeCheckValue(bool val) async {
    signupIsChecked = val;
    update();
  }

  onRemember() async {
    if (isChecked) {
      await setDataToStorage(StorageKeys.remeberMe, 'true');
      await setDataToStorage(StorageKeys.email, loginEmailController.value.text);
      await setDataToStorage(StorageKeys.password, loginPasswordController.value.text);
    } else {
      await Future.wait([
        deleteDataFromStorage(StorageKeys.remeberMe),
        deleteDataFromStorage(StorageKeys.email),
        deleteDataFromStorage(StorageKeys.password),
      ]);
    }
  }

  rememberMeData() async {
    final remeberMe = await getDataFromStorage(StorageKeys.remeberMe);
    final email = await getDataFromStorage(StorageKeys.email);
    final password = await getDataFromStorage(StorageKeys.password);

    if (remeberMe != null && email != null && password != null) {
      isChecked = true;
      loginEmailController = TextEditingController(text: email);
      loginPasswordController = TextEditingController(text: password);
    }
    update();
  }

  startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          seconds--;
          update();
        } else {
          if (minutes > 0) {
            minutes--;
            seconds = 59;
            update();
          } else {
            timer.cancel();
            seconds = 60;
            update();
          }
        }
      },
    );
  }

  optOnchange(String value) {
    if (value.isEmpty) {
      otpErrorMessage = "Please enter OTP";
    } else if (value.length < 4) {
      otpErrorMessage = "Please enter OTP";
    } else {
      otpErrorMessage = null;
    }
    update();
  }

  changeOtpError(val) {
    otpErrorMessage = val;
    update();
  }

  onLogin({required BuildContext context}) async {
    final fc = Get.put(FeedController());
    if (loginFormKey.currentState != null && loginFormKey.currentState!.validate()) {
      final body = {
        'email': loginEmailController.value.text,
        'password': loginPasswordController.value.text,
        'deviceToken': GlobalVariable.deviceToken,
        'deviceType': Platform.isAndroid ? 'Android' : 'IOS',
      };
      await onRemember();
      final res = await AuthRepository().signIn(
        context: context,
        body: body,
      );
      if (res['data'] != null) {
        GlobalVariable.globalEmail = loginEmailController.value.text;
        clearAuthInput(isChecked: isChecked);
        if (res['data']['token'] != null) {
          await setDataToStorage(StorageKeys.token, res['data']['token']);
        }
        if (res['message'] == 'Not verified') {
          Get.to(
            () => const OtpScreen(isFromSignUp: true),
          );
        } else if (res['message'] == 'Please complete your profile') {
          Get.to(
            () => const CreateProfile(
              isFromEditProfile: false,
              isFromRelationshipGoals: false,
            ),
          );
        } else {
          pc.saveUserDetails(
            UserModel.fromJson(
              res['data']['user'],
            ),
          );
          fc.editfeedData = res['data']['user']['posts'];
          await setDataToStorage(StorageKeys.isLogin, 'true');
          Get.offAll(() => const Dashboard());
        }
      }
    }
  }

  onSignup({required BuildContext context}) async {
    if (signupFormKey.currentState != null && signupFormKey.currentState!.validate()) {
      if (signupIsChecked) {
        final body = {
          'email': signupEmailController.value.text,
          'password': signupPasswordController.value.text,
          'deviceToken': GlobalVariable.deviceToken,
          'deviceType': Platform.isAndroid ? 'Android' : 'IOS',
        };
        final res = await AuthRepository().signUp(
          context: context,
          body: body,
        );
        if (res['data'] != null) {
          GlobalVariable.globalEmail = signupEmailController.value.text;
          clearAuthInput(isChecked: isChecked);
          Get.to(
            () => const OtpScreen(isFromSignUp: true),
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Please select terms & services',
          backgroundColor: Colors.white,
        );
      }
    }
  }

  onOtpVerify({required bool isFromSignup, required BuildContext context}) async {
    if (signupOtpController.value.text.length != 4) {
      changeOtpError('Please Enter Your Otp Code');
    }
    if (signupOtpFormKey.currentState != null && signupOtpFormKey.currentState!.validate()) {
      final body = {
        'email': GlobalVariable.globalEmail,
        'otp': signupOtpController.value.text,
      };
      final res = await AuthRepository().otpVerify(
        context: context,
        body: body,
      );
      if (res['success']) {
        await setDataToStorage(StorageKeys.token, res['data']['token']);
        Get.delete<AuthController>();
        Get.off(
          () => isFromSignup
              ? const CreateProfile(
                  isFromEditProfile: false,
                  isFromRelationshipGoals: false,
                )
              : const ResetPassword(),
        );
      }
    }
  }

  resendOtp({
    required bool isFromSignup,
    required BuildContext context,
  }) async {
    signupOtpController.clear();
    update();
    startTimer();
    final body = {
      'reason': isFromSignup ? 'registration' : 'otp',
      'email': GlobalVariable.globalEmail,
    };
    await AuthRepository().forgotPassword(
      context: context,
      body: body,
    );
  }

  autoLogin({
    required BuildContext context,
    required bool showLoader,
  }) async {
    final res = await AuthRepository().autoLogin(
      context: context,
      showLoader: showLoader,
    );
    if (res != null) {
      final fc = Get.put(FeedController());
      pc.saveUserDetails(
        UserModel.fromJson(
          res['data']['user'],
        ),
      );
      fc.editfeedData = res['data']['user']['posts'];
      Get.offAll(() => const Dashboard());
    }
  }

  onSidebarDataStore({
    required BuildContext context,
    bool? showLoader = true,
  }) async {
    final res = await AuthRepository().autoLogin(
      context: context,
      showLoader: showLoader!,
    );
    if (res != null && res['data'] != null) {
      final fc = Get.put(FeedController());
      pc.saveUserDetails(
        UserModel.fromJson(
          res['data']['user'],
        ),
      );
      fc.editfeedData = res['data']['user']['posts'];
    }
  }

  onForgotPassword({required BuildContext context}) async {
    if (forgotFormKey.currentState != null && forgotFormKey.currentState!.validate()) {
      final body = {
        'email': forgotEmailController.value.text,
        'reason': 'otp',
      };
      final res = await AuthRepository().forgotPassword(
        context: context,
        body: body,
      );
      if (res['success']) {
        GlobalVariable.globalEmail = forgotEmailController.value.text;
        clearAuthInput(isChecked: isChecked);
        Get.to(
          () => const OtpScreen(
            isFromSignUp: false,
          ),
        );
      }
    }
  }

  onResetPassword({required BuildContext context}) async {
    if (resetFormKey.currentState != null && resetFormKey.currentState!.validate()) {
      final body = {
        'password': resetPasswordController.value.text,
      };
      final res = await AuthRepository().resetPassword(
        context: context,
        body: body,
      );
      if (res['data'] != null) {
        Get.offAll(() => const LoginScreen());
      }
    }
  }
}
