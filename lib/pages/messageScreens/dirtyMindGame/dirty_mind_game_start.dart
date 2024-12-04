import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/pages/messageScreens/dirtyMindGame/dirty_mind_card.dart';
import 'package:double_date/pages/messageScreens/dirtyMindGame/dirty_mind_result.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DirtyMindGameStartScreen extends StatefulWidget {
  const DirtyMindGameStartScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<DirtyMindGameStartScreen> createState() => DirtyMindGameStartScreenState();
}

class DirtyMindGameStartScreenState extends State<DirtyMindGameStartScreen> {
  final gameController = Get.put(GameController());

  @override
  void dispose() {
    gameController.dirtyMindCurrentIndex = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        keyboardDismissle(context);
      },
      child: Scaffold(
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
                    DirtyMindCard(
                      question: controller.dirtyMindsQuestions[controller.dirtyMindCurrentIndex].question!,
                      questionNumber: '${controller.dirtyMindCurrentIndex + 1}',
                      questionLength: controller.dirtyMindsQuestions.length,
                      showAnswer: controller.dirtyMindsQuestions[controller.dirtyMindCurrentIndex].showAnswer!,
                    ),
                    32.verticalSpace,
                    Column(
                      children: [
                        AppButton(
                          text: controller.showLastQuestionOfDirtyMind ? 'FINISH' : 'NEXT',
                          horizontalMargin: 0,
                          onPress: controller.dirtyMindCurrentIndex == 24
                              ? () {
                                  if (controller.dirtyMindInputController.value.text.isNotEmpty) {
                                    controller.updateLastQuestionValue();
                                    controller.showDirtyMindQuestionAnswer();
                                  } else if (controller.showLastQuestionOfDirtyMind) {
                                    Get.to(DirtyMindGameResultScreen(
                                      conversationId: widget.conversationId,
                                    ));
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Answer can\'t be empty',
                                      backgroundColor: Colors.white,
                                      duration: const Duration(
                                        seconds: 1,
                                      ),
                                    );
                                  }
                                }
                              : controller.dirtyMindsQuestions[controller.dirtyMindCurrentIndex].showAnswer!
                                  ? controller.changeDirtyMindQuestion
                                  : controller.showDirtyMindQuestionAnswer,
                        ),
                        if (!controller.dirtyMindsQuestions[controller.dirtyMindCurrentIndex].showAnswer! && controller.dirtyMindCurrentIndex != 24)
                          Column(
                            children: [
                              24.verticalSpace,
                              AppButton(
                                text: 'SKIP',
                                horizontalMargin: 0,
                                onPress: controller.changeDirtyMindQuestion,
                                backgroundColor: Colors.transparent,
                                isGradinet: false,
                                borderColor: const Color(0xFFFF1472),
                                textColor: Colors.white,
                              ),
                            ],
                          )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
