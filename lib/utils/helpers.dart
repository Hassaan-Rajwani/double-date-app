import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:country_code_picker/country_code_picker.dart';

BoxBorder modalBorder({double width = 1.5}) {
  return GradientBoxBorder(
    gradient: const LinearGradient(
      colors: [
        Color(0xFFFF1472),
        Color(0xFFB1124C),
        Color(0xFF831136),
        Color(0xFFFFFFFF),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    width: width,
  );
}

class HomeCardClass {
  final String person1Name;
  final String person2Name;
  final String person1Image;
  final String person2Image;
  void funtion;

  HomeCardClass({
    required this.person1Name,
    required this.person2Name,
    required this.person1Image,
    required this.person2Image,
  });
}

String emailRegex =
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
String nameRegex = r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";

void keyboardDismissle(BuildContext context) {
  FocusScope.of(context).unfocus();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

int calculateAge(String birthDateString) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final DateTime birthDate = dateFormat.parse(birthDateString);
  final DateTime today = DateTime.now();
  int age = today.year - birthDate.year;
  if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }
  return age;
}

String timeAgo({required String time}) {
  DateTime dateTime = DateTime.parse(time);
  return timeago.format(dateTime, locale: 'en_short');
}

String commentDateConverter({required String time}) {
  DateTime dateTime = DateTime.parse(time).toLocal();
  return DateFormat('dd MMM hh:mm a').format(dateTime);
}

bool containsHttpOrHttps(String url) {
  try {
    final uri = Uri.parse(url);
    return uri.scheme == 'http' || uri.scheme == 'https';
  } catch (e) {
    return false;
  }
}

bool isVideoUrl(String url) {
  final List<String> videoExtensions = ['.mp4', '.avi', '.mkv', '.mov', '.flv', '.wmv'];
  for (var extension in videoExtensions) {
    if (url.toLowerCase().endsWith(extension)) {
      return true;
    }
  }
  return false;
}

String getCountryCode(String isoCode) {
  return CountryCode.fromCountryCode(isoCode != '' && isoCode != 'null' ? isoCode : 'US').dialCode.toString();
}

String formatOffersDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('dd-MMM-yy').format(dateTime);
}

String formatOffersTime(String time) {
  DateTime dateTime = DateTime.parse(time);
  return DateFormat('h:mm a').format(dateTime.toLocal());
}

String formatTimeFromDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString).toLocal();
  String formattedTime = DateFormat('hh:mm a').format(dateTime);
  return formattedTime;
}

String formatEndTime(String endTime) {
  DateTime dateTime = DateTime.parse(endTime).toLocal();
  return DateFormat('HH:mm').format(dateTime);
}

String ticketsDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  return DateFormat("dd-MMM-yyyy").format(dateTime);
}
