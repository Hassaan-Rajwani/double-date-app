// ignore_for_file: deprecated_member_use
import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    this.icon = '',
    required this.text,
    this.isAppIcon = false,
    this.appIcon,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
  });

  final String? icon;
  final String text;
  final bool? isAppIcon;
  final Color? iconColor;
  final Color? textColor;
  final Widget? appIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (isAppIcon!)
            appIcon!
          else
            SvgPicture.asset(
              icon!,
              color: Colors.white,
              width: 20,
            ),
          5.horizontalSpace,
          Text(
            text,
            style: interFont(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: textColor!,
            ),
          )
        ],
      ),
    );
  }
}
