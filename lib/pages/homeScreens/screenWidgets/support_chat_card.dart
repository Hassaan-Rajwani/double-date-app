// ignore_for_file: deprecated_member_use

import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportChatCard extends StatelessWidget {
  const SupportChatCard({
    super.key,
    required this.userName,
    required this.isSender,
    required this.time,
    required this.title,
    required this.msg,
  });

  final String userName;
  final String time;
  final bool isSender;
  final String title;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 16,
        left: isSender ? 30 : 0,
        right: isSender ? 0 : 30,
      ),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: isSender
              ? BoxDecoration(
                  color: const Color(0xFFB1124C),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFA8A8A8).withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                )
              : BoxDecoration(
                  border: modalBorder(width: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFA8A8A8).withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userName,
                    style: interFont(
                      color: isSender ? Colors.white : const Color(0xFFB1124C),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  5.horizontalSpace,
                  Text(
                    time,
                    style: interFont(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Divider(color: Color.fromARGB(255, 88, 88, 88)),
              Text(
                title,
                style: interFont(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              6.verticalSpace,
              Text(
                msg,
                style: interFont(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Divider(color: isSender ? Colors.white : const Color.fromARGB(255, 88, 88, 88)),
              5.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset(
                    mediaIcon,
                    width: 18.w,
                    height: 18.h,
                    color: isSender ? Colors.white : const Color(0xFFB1124C),
                  ),
                  8.horizontalSpace,
                  Text(
                    'attachments',
                    style: interFont(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: isSender ? Colors.white : const Color(0xFFB1124C),
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Text(
                'img-001',
                style: interFont(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
