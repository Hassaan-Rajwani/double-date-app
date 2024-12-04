import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/pages/messageScreens/knowMeGame/know_me_result.dart';
import 'package:double_date/pages/messageScreens/knowMeGame/know_me_card.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class KnowMeGameStartScreen extends StatefulWidget {
  const KnowMeGameStartScreen({
    super.key,
    required this.conversationId,
    this.isFromPushNotification = false,
  });

  final String conversationId;
  final bool? isFromPushNotification;

  @override
  State<KnowMeGameStartScreen> createState() => KnowMeGameStartScreenState();
}

class KnowMeGameStartScreenState extends State<KnowMeGameStartScreen> {
  final gameController = Get.put(GameController());

  @override
  void initState() {
    if (widget.isFromPushNotification!) {
      gameController.getGameList(context: context);
    }
    super.initState();
  }

  @override
  void dispose() {
    gameController.knowMeCurrentIndex = 0;
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
              child: controller.knowMeQuestions.isEmpty
                  ? Container()
                  : Container(
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
                          KnowMeCard(
                            question: controller.knowMeQuestions[controller.knowMeCurrentIndex].question!,
                            questionNumber: '${controller.knowMeCurrentIndex + 1}',
                            questionLength: controller.knowMeQuestions.length,
                          ),
                          32.verticalSpace,
                          if (controller.knowMeCurrentIndex != 24)
                            Column(
                              children: [
                                AppButton(
                                  text: 'NEXT',
                                  horizontalMargin: 0,
                                  onPress: () {
                                    if (controller.knowMeInputController.value.text.isEmpty) {
                                      Get.snackbar(
                                        'Error',
                                        'Answer can\'t be empty',
                                        backgroundColor: Colors.white,
                                        duration: const Duration(
                                          seconds: 1,
                                        ),
                                      );
                                    } else {
                                      controller.nextQuestion();
                                    }
                                  },
                                ),
                                24.verticalSpace,
                                AppButton(
                                  text: 'SKIP',
                                  horizontalMargin: 0,
                                  onPress: () {
                                    controller.nextQuestion();
                                  },
                                  backgroundColor: Colors.transparent,
                                  isGradinet: false,
                                  borderColor: const Color(0xFFFF1472),
                                  textColor: Colors.white,
                                ),
                              ],
                            )
                          else
                            AppButton(
                              text: 'FINISH',
                              horizontalMargin: 0,
                              onPress: () {
                                if (controller.knowMeInputController.value.text.isEmpty) {
                                  Get.snackbar(
                                    'Error',
                                    'Answer can\'t be empty',
                                    backgroundColor: Colors.white,
                                    duration: const Duration(
                                      seconds: 1,
                                    ),
                                  );
                                } else {
                                  controller.nextQuestion();
                                  Get.to(() => KnowMeGameResultScreen(
                                        conversationId: widget.conversationId,
                                        isFromPushNotification: widget.isFromPushNotification,
                                      ));
                                }
                              },
                            ),
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
