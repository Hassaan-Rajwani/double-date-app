import 'package:double_date/controllers/onbaording_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final onboardingController = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        child: GetBuilder<OnboardingController>(
          builder: (controller) {
            final activePage = controller.activePage;
            return Stack(
              children: [
                Image.asset(
                  controller.onBoardingTopImage(activePage),
                  fit: BoxFit.cover,
                  width: 1.sw,
                  gaplessPlayback: true,
                ),
                if (controller.onBoardingShowSkip(activePage))
                  Positioned(
                    top: 63,
                    right: 20,
                    child: CustomChip(
                      text: 'SKIP',
                      onTap: () async {
                        await controller.skipButton();
                      },
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 1.sw,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFFF1472),
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(27, 38, 27, 8),
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Find Your Perfect Duo For ',
                                  style: interFont(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Double Date',
                                  style: interFont(
                                    fontSize: 32.0,
                                    color: const Color(0XffB1124C),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'Join us and socialize with\nmillions of people.',
                          style: interFont(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        24.verticalSpace,
                        GestureDetector(
                          onTap: () async {
                            await controller.changeActivePage(1);
                          },
                          child: SvgPicture.asset(
                            controller.onBoardingButtonImage(activePage),
                          ),
                        ),
                        30.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
