import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.text,
    this.fontSize = 14.0,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.onTap,
    this.horizontalPadding = 20,
    this.verticalPadding = 10,
    this.showIcon = false,
    this.icon,
  });

  final String text;
  final double? fontSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final bool? showIcon;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding!, horizontal: horizontalPadding!),
        decoration: backgroundColor == null
            ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF1472),
                    Color(0xFFB1124C),
                    Color(0xFF831136),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                border: Border.all(
                  width: 1,
                  color: borderColor!,
                ),
                borderRadius: BorderRadius.circular(100),
              )
            : BoxDecoration(
                color: backgroundColor,
                border: Border.all(
                  width: 1,
                  color: borderColor!,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
        child: showIcon!
            ? Row(
                children: [
                  icon!,
                  3.horizontalSpace,
                  Text(
                    text,
                    style: interFont(
                      fontWeight: fontWeight!,
                      fontSize: fontSize!,
                      color: textColor!,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: interFont(
                  fontWeight: fontWeight!,
                  fontSize: fontSize!,
                  color: textColor!,
                ),
              ),
      ),
    );
  }
}
