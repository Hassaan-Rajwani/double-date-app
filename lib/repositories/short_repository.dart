import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShortRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> createShort({
    required BuildContext context,
    required dynamic body,
    dynamic file,
  }) async {
    try {
      final response = await apiService.postMultiParts(
        fileKey: 'file',
        url: AppUrls.createShortUrl,
        context: context,
        body: body,
        file: file,
        isFromEdit: false,
        showSnackbar: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> updateShort({
    required BuildContext context,
    required dynamic body,
    required String shortId,
  }) async {
    try {
      final response = await apiService.putApi(
        url: '${AppUrls.createShortUrl}/$shortId',
        context: context,
        body: body,
        showSnackbar: false,
        showLoader: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> deleteShort({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.deleteApi(
        url: AppUrls.createShortUrl,
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
}
