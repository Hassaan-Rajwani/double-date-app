import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/pages/messageScreens/ticTacTowGame/tic_tac_toe_start.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TicTacToeGameScreen extends StatefulWidget {
  const TicTacToeGameScreen({super.key});

  @override
  State<TicTacToeGameScreen> createState() => TicTacToeGameScreenState();
}

class TicTacToeGameScreenState extends State<TicTacToeGameScreen> {
  final gameController = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(title: 'Challenge'),
      backgroundColor: Colors.black,
      body: GetBuilder<GameController>(
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
              child: Column(
                children: [
                  20.verticalSpace,
                  Image.asset(ticTacToeIcon),
                  Text(
                    'Challenge',
                    style: interFont(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  7.verticalSpace,
                  Text(
                    'Score 50 points ',
                    style: interFont(
                      fontWeight: FontWeight.w500,
                      fontSize: 26.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  40.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      imageWithName(
                        name: 'Sarah',
                        imagePath: sarah,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'VS',
                          style: interFont(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      imageWithName(
                        name: 'Watson',
                        imagePath: watson,
                      ),
                    ],
                  ),
                  32.verticalSpace,
                  AppButton(
                    text: 'START CHALLENGE',
                    horizontalMargin: 0,
                    onPress: () {
                      Get.off(() => const TicTacToeGameStartScreen());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget imageWithName({
    required String name,
    required String imagePath,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.pink,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        10.verticalSpace,
        Text(
          name,
          style: interFont(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
