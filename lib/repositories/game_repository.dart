import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> getGameList({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getGameList,
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
