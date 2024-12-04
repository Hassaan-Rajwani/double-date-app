// ignore_for_file: use_build_context_synchronously
import 'package:double_date/network/api_urls.dart';
import 'package:double_date/network/network_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedRepository {
  NetworkApi apiService = NetworkApi();

  Future<dynamic> getFeeds({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getApi(
        url: AppUrls.getFeedsUrl,
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

  Future<dynamic> getSinglePost({
    required BuildContext context,
    required String postId,
  }) async {
    try {
      final response = await apiService.getApi(
        url: '${AppUrls.createFeedUrl}/$postId',
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

  Future<dynamic> getPostLikes({
    required BuildContext context,
    required String postId,
  }) async {
    try {
      final response = await apiService.getApi(
        url: '${AppUrls.createFeedUrl}/$postId/likes',
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

  Future<dynamic> getPostComments({
    required BuildContext context,
    required String postId,
  }) async {
    try {
      final response = await apiService.getApi(
        url: '${AppUrls.createFeedUrl}/$postId/comments',
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

  Future<dynamic> createPost({
    required BuildContext context,
    required dynamic body,
    dynamic multipleFile,
    required String fileKey,
  }) async {
    try {
      final response = await apiService.postMultiParts(
        fileKey: fileKey,
        url: AppUrls.createFeedUrl,
        context: context,
        body: body,
        multipleFile: multipleFile,
        isFromEdit: false,
        showSnackbar: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> updatePost({
    required BuildContext context,
    required dynamic body,
    dynamic multipleFile,
    required String fileKey,
    required String postId,
  }) async {
    try {
      final response = await apiService.updateMultiParts(
        url: '${AppUrls.createFeedUrl}/$postId',
        context: context,
        body: body,
        fileKey: fileKey,
        multipleFile: multipleFile,
        showSnackbar: true,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> likePost({
    required BuildContext context,
    required dynamic body,
    required String postId,
  }) async {
    try {
      final response = await apiService.postApi(
        sendHeaders: true,
        url: '${AppUrls.createFeedUrl}/$postId/like',
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

  Future<dynamic> commentPost({
    required BuildContext context,
    required dynamic body,
    dynamic file,
    required String postId,
  }) async {
    try {
      final response = await apiService.postMultiParts(
        url: '${AppUrls.createFeedUrl}/$postId/comment',
        context: context,
        body: body,
        isFromEdit: false,
        fileKey: 'file',
        file: file,
        showSnackbar: false,
        showLoader: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> onReplyComment({
    required BuildContext context,
    required dynamic body,
    required String postId,
    required String commentId,
    dynamic file,
  }) async {
    try {
      final response = await apiService.postMultiParts(
        url: '${AppUrls.createFeedUrl}/$postId/comments/$commentId/reply',
        context: context,
        body: body,
        showLoader: false,
        showSnackbar: false,
        fileKey: 'file',
        isFromEdit: false,
        file: file,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
  }

  Future<dynamic> deletePost({
    required BuildContext context,
    required dynamic body,
  }) async {
    try {
      final response = await apiService.deleteApi(
        url: AppUrls.createFeedUrl,
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
}
