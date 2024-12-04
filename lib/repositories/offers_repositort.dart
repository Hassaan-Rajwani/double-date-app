import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> doubleDateOffers({
    required BuildContext context,
    required String name,
    required String date,
    required String activity,
    required String address,
  }) async {
    try {
      final response = await apiService.getApi(
        url: '${AppUrls.getDoubleDateOffersUrl}?name=$name&date=$date&activity=$activity&address=$address',
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

  Future<dynamic> getCategory({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getCategoryUrl,
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

  Future<dynamic> doubleDateOfferById({
    required BuildContext context,
    required String offerId,
  }) async {
    try {
      final response = await apiService.getApi(
        url: '${AppUrls.getDoubleDateOffersUrl}/$offerId',
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

  Future<dynamic> upcomingOffers({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.upcomingOfferUrl,
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

  Future<dynamic> syncOffer({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.syncOfferUrl,
        body: body,
        context: context,
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

  Future<dynamic> unSyncOffer({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.postApi(
        url: AppUrls.unSyncOfferUrl,
        body: body,
        context: context,
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
}
