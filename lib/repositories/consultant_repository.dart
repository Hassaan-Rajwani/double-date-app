import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultantRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> getConsultantQuestions({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getQuestionsList,
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
