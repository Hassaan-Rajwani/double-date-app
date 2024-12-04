import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> createProfile({
    required BuildContext context,
    required dynamic body,
    dynamic file,
    required bool isFromEditProfile,
    required String fileKey,
  }) async {
    try {
      final response = await apiService.postMultiParts(
        fileKey: fileKey,
        url: isFromEditProfile ? AppUrls.editProfileUrl : AppUrls.createProfileUrl,
        context: context,
        body: body,
        file: file,
        isFromEdit: isFromEditProfile,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> getItems({required BuildContext context}) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getItemsUrl,
        context: context,
        showLoader: false,
        showSnackbar: false,
        sendHeaders: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> changePassword({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: true,
        url: AppUrls.changePasswordUrl,
        context: context,
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

  Future<dynamic> removePartner({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: true,
        url: AppUrls.removePartnerUrl,
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

  Future<dynamic> pairPartner({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: true,
        url: AppUrls.pairPartnerUrl,
        context: context,
        showLoader: true,
        showSnackbar: true,
        body: body,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> addPartnerRequest({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: true,
        url: AppUrls.addPartnerRequestUrl,
        context: context,
        showLoader: true,
        showSnackbar: true,
        body: body,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }
}
