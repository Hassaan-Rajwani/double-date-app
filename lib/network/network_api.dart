// ignore_for_file: use_build_context_synchronously,, depend_on_referenced_packages
import 'dart:convert';
import 'package:double_date/utils/global_varibles.dart';
import 'package:double_date/utils/storage.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class NetworkApi {
  Future<dynamic> getApi({
    required String url,
    required BuildContext context,
    bool showLoader = false,
    bool showSnackbar = false,
    bool sendHeaders = true,
  }) async {
    final token = await getDataFromStorage(StorageKeys.token);
    dynamic responseJson;
    try {
      if (showLoader) {
        dialogSpinkit(context: context);
      }
      final headers = {
        'Content-Type': 'application/json',
        if (sendHeaders) 'Authorization': 'Bearer ${token!}',
      };
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (showLoader) {
        Get.back();
      }
      responseJson = showSnackbar ? returnResponseGet(response) : jsonDecode(response.body);
    } catch (e) {
      if (showLoader) {
        Get.back();
      }
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
    return responseJson;
  }

  Future<dynamic> postApi({
    required String url,
    required BuildContext context,
    dynamic body,
    bool sendHeaders = true,
    bool showLoader = false,
    bool showSnackbar = true,
    bool sendSignupToken = false,
  }) async {
    final token = await getDataFromStorage(StorageKeys.token);
    dynamic responseJson;
    try {
      if (showLoader) {
        dialogSpinkit(context: context);
      }
      final headers = {
        'Content-Type': 'application/json',
        if (sendHeaders) 'Authorization': 'Bearer ${token!}',
        if (sendSignupToken) 'auth_token': GlobalVariable.signupAuthToken,
      };
      final response = body != null
          ? await http.post(
              Uri.parse(url),
              headers: headers,
              body: jsonEncode(body),
            )
          : await http.post(
              Uri.parse(url),
              headers: headers,
            );
      if (showLoader) {
        Get.back();
      }
      responseJson = showSnackbar ? returnResponseGet(response) : jsonDecode(response.body);
    } catch (e) {
      if (showLoader) {
        Get.back();
      }
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
    return responseJson;
  }

  Future<dynamic> postMultiParts({
    required String url,
    required BuildContext context,
    required dynamic body,
    required bool isFromEdit,
    required String fileKey,
    dynamic file,
    dynamic multipleFile,
    bool showSnackbar = true,
    bool showLoader = true,
  }) async {
    final token = await getDataFromStorage(StorageKeys.token);
    dynamic responseJson;
    try {
      if (showLoader) {
        dialogSpinkit(context: context);
      }
      final headers = {
        'Authorization': 'Bearer ${token!}',
      };
      final request = http.MultipartRequest(isFromEdit ? 'PUT' : 'POST', Uri.parse(url));
      if (body != null) {
        request.fields.addAll(body);
      }
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        var multipartFile = await http.MultipartFile.fromPath(
          fileKey,
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType(mimeType!.split('/')[0], "${file.path.split('.').last}"),
        );
        request.files.add(multipartFile);
      }
      if (multipleFile != null) {
        for (var multi in multipleFile) {
          var mimeType = lookupMimeType(multi.path);
          var multipartFile = await http.MultipartFile.fromPath(
            fileKey,
            multi.path,
            filename: multi.path.split('/').last,
            contentType: MediaType(mimeType!.split('/')[0], multi.path.split('.').last),
          );
          request.files.add(multipartFile);
        }
      }
      request.headers.addAll(headers);
      var response = await request.send();
      var responsed = await http.Response.fromStream(response);
      if (showLoader) {
        Get.back();
      }
      responseJson = showSnackbar ? returnResponseGet(responsed) : jsonDecode(responsed.body);
    } catch (e) {
      if (showLoader) {
        Get.back();
      }
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
    return responseJson;
  }

  Future<dynamic> updateMultiParts({
    required String url,
    required BuildContext context,
    required dynamic body,
    required String fileKey,
    dynamic multipleFile,
    bool showSnackbar = true,
  }) async {
    final token = await getDataFromStorage(StorageKeys.token);
    dynamic responseJson;
    try {
      dialogSpinkit(context: context);
      final headers = {
        'Authorization': 'Bearer ${token!}',
      };
      final request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields.addAll(body);
      for (var multi in multipleFile) {
        if (multi != null) {
          if (multi['_id'] == 'no') {
            var multipartFile = await http.MultipartFile.fromPath(
              fileKey,
              multi['url'],
              filename: multi['url'].split('/').last,
              contentType: MediaType(fileKey, multi['url'].split('.').last),
            );
            request.files.add(multipartFile);
          }
        }
      }
      request.headers.addAll(headers);
      var response = await request.send();
      var responsed = await http.Response.fromStream(response);
      Get.back();
      responseJson = showSnackbar ? returnResponseGet(responsed) : jsonDecode(responsed.body);
    } catch (e) {
      Get.back();
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
    return responseJson;
  }

  Future<dynamic> deleteApi({
    required String url,
    required BuildContext context,
    dynamic body,
    bool showLoader = false,
    bool showSnackbar = true,
  }) async {
    final token = await getDataFromStorage(StorageKeys.token);
    dynamic responseJson;
    try {
      if (showLoader) {
        dialogSpinkit(context: context);
      }
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}',
      };
      final response = body != null
          ? await http.delete(
              Uri.parse(url),
              headers: headers,
              body: jsonEncode(body),
            )
          : await http.delete(
              Uri.parse(url),
              headers: headers,
            );
      if (showLoader) {
        Get.back();
      }
      responseJson = showSnackbar ? returnResponseGet(response) : jsonDecode(response.body);
    } catch (e) {
      if (showLoader) {
        Get.back();
      }
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
    return responseJson;
  }

  Future<dynamic> putApi({
    required String url,
    required BuildContext context,
    required dynamic body,
    bool showLoader = false,
    bool showSnackbar = true,
  }) async {
    final token = await getDataFromStorage(StorageKeys.token);
    dynamic responseJson;
    try {
      if (showLoader) {
        dialogSpinkit(context: context);
      }
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}',
      };
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (showLoader) {
        Get.back();
      }
      responseJson = showSnackbar ? returnResponseGet(response) : jsonDecode(response.body);
    } catch (e) {
      if (showLoader) {
        Get.back();
      }
      Get.snackbar('Error', '$e', backgroundColor: Colors.white);
    }
    return responseJson;
  }

  dynamic returnResponseGet(http.Response response) {
    if (response.statusCode == 200) {
      dynamic responseJson = jsonDecode(response.body);
      if (responseJson["status"] == false) {
        Get.snackbar(
          'Error',
          responseJson["message"],
          backgroundColor: Colors.white,
        );
      } else {
        Get.snackbar(
          'Success',
          responseJson["message"],
          backgroundColor: Colors.white,
        );
      }
      return responseJson;
    } else {
      dynamic responseJson = jsonDecode(response.body);
      Get.snackbar(
        'Error',
        responseJson["message"],
        backgroundColor: Colors.white,
      );
      return responseJson;
    }
  }
}
