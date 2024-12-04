import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingCard extends StatefulWidget {
  const SettingCard({
    super.key,
    this.showSwitch = false,
    this.onTap,
    required this.text,
  });

  final bool? showSwitch;
  final VoidCallback? onTap;
  final String text;

  @override
  State<SettingCard> createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
  final settingController = Get.put(SettingController());
  final pc = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      builder: (controller) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            width: 1.sw,
            decoration: BoxDecoration(
              border: modalBorder(width: 0.2),
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFA8A8A8).withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  style: interFont(
                    color: const Color(0xFFB1124C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (widget.showSwitch!)
                  GetBuilder<ProfileController>(
                    builder: (pc) {
                      return Container(
                        height: 25,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Switch(
                          value: pc.user.value.isNotificationEnabled!,
                          onChanged: (value) async {
                            await controller.onToggleNotification(context: context, value: value);
                          },
                          activeColor: const Color(0xFFB1124C),
                          activeTrackColor: Colors.white,
                          inactiveThumbColor: Colors.black,
                          inactiveTrackColor: Colors.white,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
