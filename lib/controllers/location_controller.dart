import 'package:double_date/controllers/permission_controller.dart';
import 'package:double_date/widgets/permission_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  final permissionController = Get.put(PermissionController());

  @override
  void onInit() {
    _getLocationPermission();
    super.onInit();
  }

  Future<bool> _getLocationPermission() async {
    bool result = false;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission.name == "deniedForever") {
        Get.defaultDialog(
          backgroundColor: Colors.transparent,
          title: "",
          content: const PermissionDialog(
            bodyText: 'We need access to your location. Please tap the "Open Settings" button and grant location permission.',
            heading: 'Permission',
          ),
        );
        result = false;
      } else {
        result = true;
      }
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      _getCurrentLocation();
      result = true;
    }
    return result;
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude.value = position.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getAddressFromLatLng(lat, lng) async {
    bool status = await _getLocationPermission();
    if (status) {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks[0];
        String completeAddress =
            '${placemark.street},${placemark.subLocality},${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
        debugPrint(completeAddress.toString());
        city.value = "${placemark.locality}";
        state.value = "${placemark.administrativeArea}";
        return completeAddress;
      }
      return "Unable to get address";
    }
    return "";
  }
}
