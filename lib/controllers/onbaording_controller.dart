import 'package:double_date/pages/authScreens/login.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/storage.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final List pages = [
    {
      'topImage': onbaordingImage1,
      'button': onboardingButton1,
      'showSkip': true,
    },
    {
      'topImage': onbaordingImage2,
      'button': onboardingButton2,
      'showSkip': true,
    },
    {
      'topImage': onbaordingImage3,
      'button': onboardingGetStart,
      'showSkip': false,
    },
  ];

  int activePage = 0;

  String onBoardingTopImage(int active) {
    switch (active) {
      case 0:
        return onbaordingImage1;
      case 1:
        return onbaordingImage2;
      case 2:
        return onbaordingImage3;
      default:
        return onbaordingImage1;
    }
  }

  String onBoardingButtonImage(int active) {
    switch (active) {
      case 0:
        return onboardingButton1;
      case 1:
        return onboardingButton2;
      case 2:
        return onboardingGetStart;
      default:
        return onboardingButton1;
    }
  }

  bool onBoardingShowSkip(int active) {
    switch (active) {
      case 0:
        return true;
      case 1:
        return true;
      case 2:
        return false;
      default:
        return true;
    }
  }

  onboardingDone() async {
    await setDataToStorage(StorageKeys.onboardingDone, 'true');
  }

  changeActivePage(int index) async {
    if (activePage != 2) {
      activePage = activePage + 1;
      update();
    } else {
      await onboardingDone();
      Get.offAll(() => const LoginScreen());
    }
  }

  skipButton() async {
    await onboardingDone();
    Get.offAll(() => const LoginScreen());
  }
}
