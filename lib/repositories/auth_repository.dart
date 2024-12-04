import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> signIn({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: false,
        url: AppUrls.signInUrl,
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

  Future<dynamic> socialLogin({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: false,
        url: AppUrls.socialLoginUrl,
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

  Future<dynamic> forgotPassword({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: false,
        url: AppUrls.forgotPasswordUrl,
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

  Future<dynamic> otpVerify({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: false,
        url: AppUrls.otpVerifyUrl,
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

  Future<dynamic> resetPassword({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: true,
        url: AppUrls.resetPasswordUrl,
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

  Future<dynamic> autoLogin({
    required BuildContext context,
    required bool showLoader,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getProfileUrl,
        context: context,
        showLoader: showLoader,
        showSnackbar: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> signUp({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: false,
        url: AppUrls.signUpUrl,
        context: context,
        body: body,
        showLoader: true,
        sendSignupToken: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> logout({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.logoutUrl,
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
