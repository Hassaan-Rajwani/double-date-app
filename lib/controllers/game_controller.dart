import 'dart:convert';
import 'package:double_date/models/admin_game_model.dart';
import 'package:double_date/pages/messageScreens/dirtyMindGame/dirty_mind_result.dart';
import 'package:double_date/pages/messageScreens/knowMeGame/know_me_result.dart';
import 'package:double_date/pages/messageScreens/ticTacTowGame/tic_tac_toe_start.dart';
import 'package:double_date/repositories/game_repository.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  TextEditingController knowMeInputController = TextEditingController();
  TextEditingController dirtyMindInputController = TextEditingController();
  var knowMeCurrentIndex = 0;
  var dirtyMindCurrentIndex = 0;
  var currentPlayer = circleGameIcon;
  String currentPlayerTurn = '';
  String winnerId = '';
  var board = List.filled(9, '');
  var winner = '';
  bool showLastQuestionOfDirtyMind = false;
  List<AdminGameModel> gameList = [];
  List<QuestionsAndAnswers> knowMeQuestions = [];
  List<QuestionsAndAnswers> dirtyMindsQuestions = [];

  updateTurn(val) {
    currentPlayerTurn = val;
    update();
  }

  updateWinnerId(val) {
    winnerId = val;
    update();
  }

  saveGameList({required List<AdminGameModel> data}) {
    gameList.clear();
    gameList = data;
    update();
  }

  updateLastQuestionValue() {
    showLastQuestionOfDirtyMind = true;
    update();
  }

  void nextQuestion() {
    knowMeQuestions[knowMeCurrentIndex].response = knowMeInputController.value.text;
    knowMeInputController.clear();
    knowMeCurrentIndex++;
    update();
  }

  void showDirtyMindQuestionAnswer() {
    if (dirtyMindInputController.value.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Answer can\'t be empty',
        backgroundColor: Colors.white,
        duration: const Duration(
          seconds: 1,
        ),
      );
      update();
    } else {
      dirtyMindsQuestions[dirtyMindCurrentIndex].response = dirtyMindInputController.value.text.replaceAll(' ', '');
      dirtyMindsQuestions[dirtyMindCurrentIndex].showAnswer = true;
      dirtyMindInputController.clear();
      update();
    }
  }

  void changeDirtyMindQuestion() {
    dirtyMindsQuestions[dirtyMindCurrentIndex].showAnswer = false;
    dirtyMindCurrentIndex++;
    update();
  }

  int knowMeAnswerCount() {
    int nonEmptyCount = knowMeQuestions.where((response) => response.response!.isNotEmpty).length;
    return nonEmptyCount;
  }

  int dirtyMindAnswerCount() {
    int nonEmptyCount = dirtyMindsQuestions.where((response) => response.response!.isNotEmpty).length;
    return nonEmptyCount;
  }

  void updateBoard(List newBoardData) {
    for (int i = 0; i < newBoardData.length; i++) {
      board[i] = newBoardData[i] ?? '';
    }
    update();
  }

  void resetGame() {
    board = List.filled(9, '');
    winnerId = '';
    update();
  }

  getGameList({
    required BuildContext context,
  }) async {
    final res = await GameRepository().getGameList(
      context: context,
    );
    if (res != null && res['data'] != null) {
      saveGameList(
        data: List.from(
          res['data']
              .map(
                (item) => AdminGameModel.fromJson(item),
              )
              .toList(),
        ),
      );
      knowMeQuestions = gameList[2].questionsAndAnswers!;
      dirtyMindsQuestions = gameList[1].questionsAndAnswers!;
      update();
    } else {
      gameList.clear();
      update();
    }
  }

  onGameCardTap({
    required String conversationId,
    dynamic data,
  }) {
    if (data.messageType == 'knowMe') {
      knowMeQuestions = (jsonDecode(data.content!) as List<dynamic>)
          .map(
            (item) => QuestionsAndAnswers.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
      knowMeAnswerCount();
      Get.to(() => KnowMeGameResultScreen(
            conversationId: conversationId,
            isFromChat: true,
          ));
    } else if (data.messageType == 'dirtyMinds') {
      dirtyMindsQuestions = (jsonDecode(data.content!) as List<dynamic>)
          .map(
            (item) => QuestionsAndAnswers.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
      dirtyMindAnswerCount();
      Get.to(() => DirtyMindGameResultScreen(
            conversationId: conversationId,
            isFromChat: true,
          ));
    } else {
      Get.to(() => TicTacToeGameStartScreen(
            data: jsonDecode(data.content!),
            isFromChat: true,
          ));
    }
  }
}
