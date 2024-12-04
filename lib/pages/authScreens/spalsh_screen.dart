import 'package:double_date/controllers/auth_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/authScreens/login.dart';
import 'package:double_date/pages/authScreens/onbaording_screen.dart';
import 'package:double_date/utils/storage.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ac = Get.put(AuthController());
  final pc = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    changeScreen();
    pc.getItems(context: context);
  }

  void changeScreen() async {
    final isLogin = await getDataFromStorage(StorageKeys.isLogin);
    await getDataFromStorage(StorageKeys.onboardingDone).then(
      (value) async {
        if (value == 'true') {
          if (isLogin != null) {
            await ac.autoLogin(
              context: context,
              showLoader: false,
            );
          } else {
            Get.offAll(() => const LoginScreen());
          }
        } else {
          Get.offAll(() => const OnboardingScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(150),
          child: SvgPicture.asset(logo),
        ),
      ),
    );
  }
}
