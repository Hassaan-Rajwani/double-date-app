import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/pages/messageScreens/choose_player_dialog.dart';
import 'package:double_date/pages/messageScreens/knowMeGame/know_me_game_start.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class KnowMeGameScreen extends StatefulWidget {
  const KnowMeGameScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<KnowMeGameScreen> createState() => KnowMeGameScreenState();
}

class KnowMeGameScreenState extends State<KnowMeGameScreen> {
  final gameController = Get.put(GameController());
  final sc = Get.put(SocketController());
  final mc = Get.put(MessageController());

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
                  Image.asset(knowMeIcon),
                  Text(
                    '${controller.knowMeQuestions.length} Questions',
                    style: interFont(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  40.verticalSpace,
                  Text(
                    'Know Me\nLife Experience',
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
                      Get.off(() => KnowMeGameStartScreen(
                            conversationId: widget.conversationId,
                          ));
                    },
                  ),
                  24.verticalSpace,
                  AppButton(
                    text: 'CHALLENGE',
                    horizontalMargin: 0,
                    onPress: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return ChosePlayerDialog(
                            conversationId: widget.conversationId,
                            onPress: () async {
                              await mc.inviteForKnowMe(
                                context: context,
                                conversationId: widget.conversationId,
                              );
                            },
                          );
                        },
                      );
                    },
                    backgroundColor: Colors.transparent,
                    isGradinet: false,
                    borderColor: const Color(0xFFFF1472),
                    textColor: Colors.white,
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
