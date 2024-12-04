import 'dart:async';
import 'package:double_date/models/consultant_question_model.dart';
import 'package:double_date/repositories/consultant_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatingConsultantController extends GetxController {
  ScrollController scrollController = ScrollController();
  TextEditingController chatController = TextEditingController();
  List<ConsultantQuestionModel> questionList = [];
  List messages = [];
  bool loader = false;
  bool msgLoader = false;

  setLoader(val) {
    loader = val;
  }

  setMsgLoader(val) {
    msgLoader = val;
    update();
  }

  saveQuestions({required List<ConsultantQuestionModel> questions}) {
    questionList.clear();
    questionList = questions;
    update();
  }

  saveConsultantMsg({List? data, bool clear = false}) {
    if (clear == true) {
      messages.clear();
      update();
    } else {
      messages.clear();
      messages = data!;
      Future.delayed(const Duration(milliseconds: 400), () {
        scrollToBottom();
      });
      update();
    }
  }

  getQuestions({required BuildContext context}) async {
    setLoader(true);
    final res = await ConsultantRepository().getConsultantQuestions(context: context);
    if (res != null && res['data'] != null) {
      setLoader(false);
      saveQuestions(
        questions: List.from(
          res['data'].map((item) => ConsultantQuestionModel.fromJson(item)).toList(),
        ),
      );
      update();
    } else {
      setLoader(false);
    }
  }

  scrollToBottom() {
    Timer(
      const Duration(milliseconds: 100),
      () => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 100),
      ),
    );
  }
}
