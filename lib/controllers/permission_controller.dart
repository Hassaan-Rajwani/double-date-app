// ignore_for_file: use_build_context_synchronously
import 'package:double_date/widgets/permission_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  Future<bool> requestMediaPermission({bool oepnCamera = false}) async {
    if (oepnCamera) {
      var status = await Permission.camera.status;
      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        Get.defaultDialog(
          backgroundColor: Colors.transparent,
          title: "",
          content: const PermissionDialog(
            bodyText: 'We need access to your camera to take pictures. Please tap the "Open Settings" button and grant camera permission.',
            heading: 'Permission',
          ),
        );
        return false;
      } else {
        PermissionStatus granted = await Permission.camera.request();
        return granted.isGranted;
      }
    } else {
      var status1 = await Permission.photos.status;
      var status2 = await Permission.storage.status;
      if (status1.isGranted || status2.isGranted) {
        return true;
      } else if (status1.isPermanentlyDenied || status2.isPermanentlyDenied) {
        Get.defaultDialog(
          backgroundColor: Colors.transparent,
          title: "",
          content: const PermissionDialog(
            bodyText:
                'We need access to your photo library to select pictures. Please tap the "Open Settings" button and enable storage/photos permission.',
            heading: 'Permission',
          ),
        );
        return false;
      } else {
        PermissionStatus granted1 = await Permission.photos.request();
        PermissionStatus granted2 = await Permission.storage.request();
        if (granted1.isGranted == true || granted2.isGranted == true) {
          return true;
        } else {
          return false;
        }
      }
    }
  }
}
