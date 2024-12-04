import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

PreferredSizeWidget backButtonAppbar({
  bool showSkipButton = false,
  String title = '',
  String skipButtonText = 'SKIP',
  bool showDrawerIcon = false,
  bool showNotificationIcon = false,
  bool centerTitle = false,
  String showIconOnSkipArea = '',
  double skipIconWidth = 40,
  double skipIconheight = 40,
  double titleSize = 20.0,
  double skipSize = 14.0,
  VoidCallback? onDrawerTap,
  VoidCallback? onNotificationTap,
  VoidCallback? onSkipTap,
  bool? allowCustomOnBack = false,
  VoidCallback? customOnBack,
  bool customeSkipPadding = false,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: GestureDetector(
      onTap: showDrawerIcon
          ? onDrawerTap
          : allowCustomOnBack!
              ? customOnBack
              : () {
                  Get.back();
                },
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: SvgPicture.asset(
          showDrawerIcon ? drawerIcon : backIcon,
        ),
      ),
    ),
    actions: [
      if (showSkipButton)
        if (showIconOnSkipArea == '')
          Container(
            margin: customeSkipPadding ? const EdgeInsets.only(bottom: 9, top: 10) : EdgeInsets.zero,
            padding: customeSkipPadding ? const EdgeInsets.only(right: 15) : const EdgeInsets.only(top: 16, right: 15),
            child: CustomChip(
              text: skipButtonText,
              onTap: onSkipTap,
              fontSize: skipSize,
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: onSkipTap,
              child: SvgPicture.asset(
                showIconOnSkipArea,
                width: 40,
                height: 40,
              ),
            ),
          )
      else if (showNotificationIcon)
        GestureDetector(
          onTap: onNotificationTap,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 15),
            child: SvgPicture.asset(notificationIcon),
          ),
        )
    ],
    title: Text(
      title,
      style: interFont(
        fontWeight: FontWeight.w600,
        fontSize: titleSize,
      ),
    ),
    centerTitle: centerTitle,
  );
}
