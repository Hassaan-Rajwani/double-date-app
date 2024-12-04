import 'dart:convert';
import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/pages/messageScreens/chat_room.dart';
import 'package:double_date/pages/messageScreens/tic_tac_toe_share_dialog.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TicTacToeGameStartScreen extends StatefulWidget {
  const TicTacToeGameStartScreen({
    super.key,
    this.data,
    this.isFromChat = false,
  });

  final dynamic data;
  final bool? isFromChat;

  @override
  State<TicTacToeGameStartScreen> createState() => TicTacToeGameStartScreenState();
}

class TicTacToeGameStartScreenState extends State<TicTacToeGameStartScreen> {
  final gameController = Get.put(GameController());
  final sc = Get.put(SocketController());
  final pc = Get.put(ProfileController());

  @override
  void dispose() {
    sc.emitLeaveTicTacToe(
      conversationId: widget.data['conversationId'],
      guestId: widget.data['players']['guest']['guestId'],
      hostId: widget.data['players']['host']['hostId'],
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final host = widget.data['players']['host'];
    final guest = widget.data['players']['guest'];
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
                  if (widget.isFromChat == false)
                    Column(
                      children: [
                        32.verticalSpace,
                        Text(
                          'Challenge',
                          style: interFont(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        7.verticalSpace,
                        // Text(
                        //   'Score 50 points',
                        //   style: interFont(
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 26.0,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        // 20.verticalSpace,
                        Text(
                          '${controller.currentPlayerTurn == pc.user.value.sId ? 'Your' : 'Oponent'} Turn',
                          style: interFont(
                            fontWeight: FontWeight.w500,
                            fontSize: 26.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        40.verticalSpace,
                        SizedBox(
                          width: 0.7.sw,
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              BorderSide bottomBorder = const BorderSide(width: 5, color: Colors.white);
                              BorderSide leftBorder = const BorderSide(width: 5, color: Colors.white);
                              if (index == 0 || index == 3 || index == 6) {
                                leftBorder = BorderSide.none;
                              }
                              if (index == 6 || index == 7 || index == 8) {
                                bottomBorder = BorderSide.none;
                              }
                              return GestureDetector(
                                onTap: () {
                                  sc.emitMakeMove(
                                    conversationId: widget.data['conversationId'],
                                    position: index,
                                    guestId: guest['guestId'],
                                    hostId: host['hostId'],
                                  );
                                  // controller.move(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: bottomBorder,
                                      left: leftBorder,
                                    ),
                                  ),
                                  child: Center(
                                    child: controller.board[index] != ""
                                        ? SvgPicture.asset(
                                            controller.board[index] == 'circle' ? circleGameIcon : crossGameIcon,
                                          )
                                        : Container(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        40.verticalSpace,
                      ],
                    ),
                  Column(
                    children: [
                      if (widget.isFromChat!)
                        Column(
                          children: [
                            20.verticalSpace,
                            Image.asset(ticTacToeIcon),
                          ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          imageWithName(
                            name: host['name'] == pc.user.value.name ? 'You' : host['name'],
                            imagePath: host['image'],
                            showWinner: widget.isFromChat! ? widget.data['winner'] == host['hostId'] : controller.winnerId == host['hostId'],
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 30),
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
                            name: guest['name'] == pc.user.value.name ? 'You' : guest['name'],
                            imagePath: guest['image'],
                            showWinner: widget.isFromChat! ? widget.data['winner'] == guest['guestId'] : controller.winnerId == guest['guestId'],
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (controller.winnerId != '')
                    Column(
                      children: [
                        40.verticalSpace,
                        AppButton(
                          text: controller.winnerId == pc.user.value.sId ? 'COMPLETE' : 'GO BACK',
                          horizontalMargin: 0,
                          onPress: () {
                            if (controller.winnerId == pc.user.value.sId) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return TicTacToeShareDialog(
                                    onShareToChat: () {
                                      Map<String, dynamic> updatedData = Map<String, dynamic>.from(widget.data);
                                      updatedData['winner'] = controller.winnerId;
                                      sc.emitSendMessage(
                                        conversationId: widget.data['conversationId'],
                                        isFromGame: true,
                                        messageType: 'ticTacToe',
                                        shareResponse: jsonEncode(updatedData),
                                      );
                                      Future.delayed(const Duration(seconds: 1), () {
                                        Get.to(
                                          () => ChatRoomScreen(conversationId: widget.data['conversationId']),
                                        );
                                      });
                                    },
                                  );
                                },
                              );
                            } else {
                              Get.back();
                            }
                          },
                        ),
                      ],
                    )
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
    required bool showWinner,
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
          child: LoaderImage(
            url: imagePath,
            width: 80,
            height: 80,
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
        if (showWinner)
          Column(
            children: [
              5.verticalSpace,
              Text(
                'Winner',
                style: interFont(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFB1124C),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
      ],
    );
  }
}
