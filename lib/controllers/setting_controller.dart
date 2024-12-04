// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/block_user_model.dart';
import 'package:double_date/models/report_post_model.dart';
import 'package:double_date/models/reported_user_model.dart';
import 'package:double_date/repositories/profile_repository.dart';
import 'package:double_date/repositories/setting_repository.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:double_date/widgets/double_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  bool oldPassword = true;
  bool newPassword = true;
  bool confirmPassword = true;
  bool reportUserLoader = false;
  File? profileImage;
  final ImagePicker picker = ImagePicker();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController reportDescriptionController = TextEditingController();
  final changePasswordFormKey = GlobalKey<FormState>();
  final reportUserFormKey = GlobalKey<FormState>();
  List<ReportedUserModel> reportedUsersList = [];
  List<ReportedPostModel> reportedPostsList = [];
  List<BlockedUserModel> blockedUsersList = [];

  String selectedReason = 'Harassment or Bullying';

  List<String> reportUserReasonsList = [
    "Harassment or Bullying",
    "Spam",
    "Hate Speech",
    "Inappropriate Content",
    "Impersonation",
    "Fraud or Scam",
    "Violation of Community Guidelines",
    "Privacy Violations",
    "Misinformation",
    "Intellectual Property Violations"
  ];

  changeReportUserLoader(val, {bool isFromInit = true}) {
    reportUserLoader = val;
    if (isFromInit == false) {
      update();
    }
  }

  saveReportedUserData({required List<ReportedUserModel> reportedUserData}) {
    reportedUsersList = reportedUserData;
    update();
  }

  saveBlockedUserData({required List<BlockedUserModel> blockedUserData}) {
    blockedUsersList = blockedUserData;
    update();
  }

  saveReportedPostData({required List<ReportedPostModel> reportedPostData}) {
    reportedPostsList = reportedPostData;
    update();
  }

  updateReportReason(value) {
    selectedReason = value;
    update();
  }

  toggleOldPassword() {
    oldPassword = !oldPassword;
    update();
  }

  toggleNewPassword() {
    newPassword = !newPassword;
    update();
  }

  toggleConfirmPassword() {
    confirmPassword = !confirmPassword;
    update();
  }

  pickProfileImage({bool oepnCamera = false}) async {
    final XFile? file = await picker.pickImage(source: oepnCamera ? ImageSource.camera : ImageSource.gallery);
    if (file != null) {
      profileImage = File(file.path);
      update();
    }
  }

  onChangePassword({required BuildContext context}) async {
    if (changePasswordFormKey.currentState != null && changePasswordFormKey.currentState!.validate()) {
      final body = {
        "oldPassword": oldPasswordController.value.text,
        "newPassword": newPasswordController.value.text,
      };
      final res = await ProfileRepository().changePassword(context: context, body: body);
      if (res['data'] != null) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return BasicDialog(
              heading: 'Password Changed',
              bodyText: 'Your password has been changed',
              buttonText: 'GO BACK',
              onTap: () {
                Get.close(2);
                oldPasswordController.clear();
                newPasswordController.clear();
                confirmNewPasswordController.clear();
              },
            );
          },
        );
      }
    }
  }

  onReportUser({
    required BuildContext context,
    required String userId,
    bool? isFromNotification = false,
  }) async {
    final body = {
      'userId': userId,
      'description': reportDescriptionController.value.text,
      'reason': selectedReason,
    };
    if (reportUserFormKey.currentState != null && reportUserFormKey.currentState!.validate()) {
      final res = await SettingRepository().reportUser(context: context, body: body);
      if (res != null && res['data'] != null) {
        reportDescriptionController.clear();
        selectedReason = 'Harassment or Bullying';
        update();
        Get.close(1);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return BasicDialog(
              heading: 'Report Submitted',
              bodyText: 'Your report has been submitted.',
              onTap: () {
                Get.close(isFromNotification! ? 3 : 2);
              },
            );
          },
        );
      }
    }
  }

  onReportPost({
    required BuildContext context,
    required String postId,
    bool? isFromNotification = false,
  }) async {
    final fc = Get.put(FeedController());
    final body = {
      'description': reportDescriptionController.value.text,
      'reason': selectedReason,
    };
    if (reportUserFormKey.currentState != null && reportUserFormKey.currentState!.validate()) {
      final res = await SettingRepository().reportPost(
        context: context,
        body: body,
        postId: postId,
      );
      if (res != null && res['data'] != null) {
        reportDescriptionController.clear();
        selectedReason = 'Harassment or Bullying';
        update();
        Get.close(1);
        await fc.getFeeds(context: context);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return BasicDialog(
              heading: 'Report Submitted',
              bodyText: 'Your report has been submitted.',
              onTap: () {
                Get.close(isFromNotification! ? 2 : 1);
              },
            );
          },
        );
      }
    }
  }

  onBlockUser({
    required BuildContext context,
    required String userId,
  }) async {
    final fc = Get.put(FeedController());
    final body = {
      "userId": userId,
    };
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DoubleButtonDialog(
          onNo: () {
            Get.close(1);
          },
          onYes: () async {
            final res = await SettingRepository().unblockUser(
              context: context,
              body: body,
            );
            if (res != null && res['data'] != null) {
              Get.close(1);
              await fc.getFeeds(context: context);
            }
          },
          heading: 'Block User',
          bodyText: 'Are you sure you want to\nblock this User?',
        );
      },
    );
  }

  getReportUsers({
    required BuildContext context,
  }) async {
    changeReportUserLoader(true);
    final res = await SettingRepository().getReportedUser(context: context);
    if (res != null && res['data'] != null) {
      saveReportedUserData(
        reportedUserData: List.from(
          res['data'].map((item) => ReportedUserModel.fromJson(item)).toList(),
        ),
      );
      update();
      changeReportUserLoader(false, isFromInit: false);
    } else {
      changeReportUserLoader(false, isFromInit: false);
    }
  }

  getReportPosts({
    required BuildContext context,
  }) async {
    changeReportUserLoader(true);
    final res = await SettingRepository().getReportedPost(context: context);
    if (res != null && res['data'] != null) {
      saveReportedPostData(
        reportedPostData: List.from(
          res['data'].map((item) => ReportedPostModel.fromJson(item)).toList(),
        ),
      );
      update();
      changeReportUserLoader(false, isFromInit: false);
    } else {
      changeReportUserLoader(false, isFromInit: false);
    }
  }

  getBlockedUsers({
    required BuildContext context,
  }) async {
    changeReportUserLoader(true);
    final res = await SettingRepository().getBlockedUser(context: context);
    if (res != null && res['data'] != null) {
      saveBlockedUserData(
        blockedUserData: List.from(
          res['data'].map((item) => BlockedUserModel.fromJson(item)).toList(),
        ),
      );
      update();
      changeReportUserLoader(false, isFromInit: false);
    } else {
      changeReportUserLoader(false, isFromInit: false);
    }
  }

  onUnblockUser({
    required BuildContext context,
    required String userId,
  }) async {
    final body = {
      'userId': userId,
    };
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DoubleButtonDialog(
          onYes: () async {
            final res = await SettingRepository().unblockUser(
              context: context,
              body: body,
            );
            if (res != null && res['data'] != null) {
              Get.close(1);
              blockedUsersList.removeWhere((element) => element.sId == userId);
              update();
            }
          },
          onNo: () {
            Get.close(1);
          },
          heading: 'Unblock User',
          bodyText: 'Are you sure you want to\nUnblock this User?',
        );
      },
    );
  }

  onToggleNotification({
    required BuildContext context,
    required bool value,
  }) async {
    final pc = Get.put(ProfileController());
    final body = {
      'status': value,
    };
    pc.user.value.isNotificationEnabled = value;
    update();
    await SettingRepository().toggleNotification(context: context, body: body);
  }
}
