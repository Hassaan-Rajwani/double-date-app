import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/pages/messageScreens/dirtyMindGame/dirty_mind_game_start.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DirtyMindGameScreen extends StatefulWidget {
  const DirtyMindGameScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<DirtyMindGameScreen> createState() => DirtyMindGameScreenState();
}

class DirtyMindGameScreenState extends State<DirtyMindGameScreen> {
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
                  Image.asset(dirtyMindIcon),
                  Text(
                    '${controller.dirtyMindsQuestions.length} Questions',
                    style: interFont(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  40.verticalSpace,
                  Text(
                    'Dirty Minds\nChallenge',
                    style: interFont(
                      fontWeight: FontWeight.w500,
                      fontSize: 26.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  32.verticalSpace,
                  AppButton(
                    text: 'START',
                    horizontalMargin: 0,
                    onPress: () {
                      Get.off(() => DirtyMindGameStartScreen(
                            conversationId: widget.conversationId,
                          ));
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
}
