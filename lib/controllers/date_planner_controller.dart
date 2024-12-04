import 'package:double_date/models/date_planner_model.dart';
import 'package:double_date/repositories/converstaion_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePlannerController extends GetxController {
  List plannerList = [];

  savePlannerList({required List<DatePlannerModel> data}) {
    plannerList.clear();
    plannerList = data;
    update();
  }

  getPlannerList({required BuildContext context}) async {
    final res = await ConverstaionRepository().getPlannerList(context: context);
    if (res != null && res['data'] != null) {
      savePlannerList(
        data: List.from(
          res['data'].map((item) => DatePlannerModel.fromJson(item)).toList(),
        ),
      );
    } else {
      plannerList.clear();
      update();
    }
  }
}
