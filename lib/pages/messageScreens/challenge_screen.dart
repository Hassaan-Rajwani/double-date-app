import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/pages/messageScreens/choose_player_dialog.dart';
import 'package:double_date/pages/messageScreens/dirtyMindGame/dirty_mind_game_screen.dart';
import 'package:double_date/pages/messageScreens/knowMeGame/know_me_game_screen.dart';
import 'package:double_date/pages/messageScreens/screenWidgtes/challenge_card.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<ChallengeScreen> createState() => ChallengeScreenState();
}

class ChallengeScreenState extends State<ChallengeScreen> {
  final gc = Get.put(GameController());
  final sc = Get.put(SocketController());
  final mc = Get.put(MessageController());

  @override
  void initState() {
    gc.getGameList(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(title: 'Challenge'),
      backgroundColor: Colors.black,
      body: GetBuilder<GameController>(
        builder: (gc) {
          return SingleChildScrollView(
            child: Container(
              height: 0.85.sh,
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: gc.gameList.length,
                    itemBuilder: (context, index) {
                      final data = gc.gameList[index];
                      return ChallengeCard(
                        text: data.name!,
                        onTap: () {
                          if (data.name == "Tic-tac-toe") {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return ChosePlayerDialog(
                                  conversationId: widget.conversationId,
                                  onPress: () {
                                    sc.emitInviteForTicTacToe(
                                      conversationId: widget.conversationId,
                                      guestId: mc.selectedPlayers[0].sId,
                                    );
                                    Get.back();
                                  },
                                );
                              },
                            );
                          } else if (data.name == "Know Me") {
                            Get.to(() => KnowMeGameScreen(
                                  conversationId: widget.conversationId,
                                ));
                          } else {
                            Get.to(() => DirtyMindGameScreen(
                                  conversationId: widget.conversationId,
                                ));
                          }
                        },
                      );
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
