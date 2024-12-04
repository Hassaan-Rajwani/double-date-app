import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> reportUser({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.reportUserUrl,
        context: context,
        body: body,
        showLoader: true,
        showSnackbar: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> reportPost({
    required BuildContext context,
    required dynamic body,
    required String postId,
  }) async {
    try {
      final response = await apiService.postApi(
        url: '${AppUrls.createFeedUrl}/$postId/report',
        context: context,
        body: body,
        showLoader: true,
        showSnackbar: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> unblockUser({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.blockUserUrl,
        context: context,
        body: body,
        showLoader: true,
        showSnackbar: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> sendFeedback({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.sendFeedbackUrl,
        context: context,
        body: body,
        showLoader: true,
        showSnackbar: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> toggleNotification({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.toggleNotificationsUrl,
        context: context,
        body: body,
        showLoader: false,
        showSnackbar: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> getReportedUser({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getReportUsersUrl,
        context: context,
        showLoader: false,
        showSnackbar: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> getReportedPost({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getReportPostsUrl,
        context: context,
        showLoader: false,
        showSnackbar: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> getBlockedUser({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.blockUserUrl,
        context: context,
        showLoader: false,
        showSnackbar: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }
}
