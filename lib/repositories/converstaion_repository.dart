import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConverstaionRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> getRoomDetails({
    required BuildContext context,
    required String conversationId,
    bool? showLoader = true,
  }) async {
    try {
      final response = await apiService.getApi(
        url: '${AppUrls.getRoomDetailsUrl}/$conversationId',
        context: context,
        showLoader: showLoader!,
        showSnackbar: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> changeIdeaPlannerMsgStatus({
    required BuildContext context,
    required String conversationId,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.putApi(
        body: body,
        url: '${AppUrls.updateIdeaPlannerStatusUrl}/$conversationId',
        context: context,
        showLoader: true,
        showSnackbar: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> updateRoomDetails({
    required BuildContext context,
    required String conversationId,
    required dynamic body,
    dynamic file,
  }) async {
    try {
      final response = await apiService.postMultiParts(
        url: '${AppUrls.updateRoomDetailsUrl}/$conversationId',
        context: context,
        showSnackbar: false,
        body: body,
        fileKey: 'file',
        isFromEdit: true,
        file: file,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> getConversationId({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.updateRoomDetailsUrl,
        context: context,
        body: body,
        showLoader: true,
        showSnackbar: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> inviteForKnowMe({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.inviteForKnowMeUrl,
        context: context,
        showSnackbar: false,
        body: body,
        showLoader: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> reportGroupMember({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.reportGroupMemberUrl,
        context: context,
        showSnackbar: true,
        body: body,
        showLoader: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> blockGroupMember({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.blockGroupMemberUrl,
        context: context,
        showSnackbar: true,
        body: body,
        showLoader: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> leaveGroup({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.leaveGroupUrl,
        context: context,
        showSnackbar: true,
        body: body,
        showLoader: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> getPlannerList({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getDatePlannerList,
        context: context,
        showLoader: true,
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
