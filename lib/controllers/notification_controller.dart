import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/models/notification_model.dart';
import 'package:double_date/pages/feedScreens/single_post.dart';
import 'package:double_date/pages/messageScreens/knowMeGame/know_me_game_start.dart';
import 'package:double_date/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  List<NotificationModel> notificationList = [];
  bool isLoading = false;

  saveNotificationData({required List<NotificationModel> data}) {
    notificationList.clear();
    notificationList = data;
    update();
  }

  changeLoaderValue(value) {
    isLoading = value;
    update();
  }

  getNotificationList({required BuildContext context}) async {
    changeLoaderValue(true);
    final res = await HomeRepository().getNotifications(context: context);
    if (res['data'] != null) {
      changeLoaderValue(false);
      saveNotificationData(
        data: List.from(
          res['data']
              .map(
                (item) => NotificationModel.fromJson(item),
              )
              .toList(),
        ),
      );
    } else {
      notificationList.clear();
      update();
      changeLoaderValue(false);
    }
  }

  deleteNotification({
    required BuildContext context,
    required String id,
  }) async {
    final res = await HomeRepository().deleteNotifications(context: context, id: id);
    if (res['data'] != null) {
      notificationList.removeWhere((noti) => noti.sId == id);
      update();
    }
  }

  onRoute({
    required String title,
    required String id,
    required BuildContext context,
  }) async {
    final mc = Get.put(MatchedController());
    final bc = Get.put(BottomNavController());
    final gc = Get.put(GameController());
    if (title == 'Post like' || title == 'Post shared' || title == 'Post comment') {
      Get.to(
        () => SinglePost(postId: id),
      );
    } else if (title == 'KnowMe game challenge') {
      await gc.getGameList(context: context);
      Get.to(() => KnowMeGameStartScreen(conversationId: id));
    } else {
      bc.navBarChange(3);
      Get.close(1);
      await mc.updateIndex(0, context);
    }
  }
}
