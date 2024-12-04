import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> homeMatches({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getHomeMatchesUrl,
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

  Future<dynamic> sendLikeRequest({
    required BuildContext context,
    required dynamic body,
    bool? showSnackbar = false,
    bool? showLoader = false,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: true,
        url: AppUrls.sendLikeRequestUrl,
        context: context,
        body: body,
        showLoader: showLoader!,
        showSnackbar: showSnackbar!,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> homeSearch({
    required BuildContext context,
    required String name,
    required String address,
    required String sexualOrientation,
    required String relationshipStatus,
    bool? showLoader = false,
  }) async {
    try {
      final response = await apiService.getApi(
        sendHeaders: true,
        url: '${AppUrls.homeSearchUrl}?name=$name&address=$address&sexualOrientation=$sexualOrientation&relationshipStatus=$relationshipStatus',
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

  Future<dynamic> fetchContacts({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: true,
        url: AppUrls.fetchContactsUrl,
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

  Future<dynamic> getNotifications({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getNotificationsUrl,
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

  Future<dynamic> deleteNotifications({
    required BuildContext context,
    required String id,
  }) async {
    try {
      final response = await apiService.deleteApi(
        url: '${AppUrls.getNotificationsUrl}/$id',
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
