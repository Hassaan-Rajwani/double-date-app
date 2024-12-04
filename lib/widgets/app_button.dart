import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    this.onPress,
    this.backgroundColor,
    this.buttonLoader = false,
    this.textColor = Colors.white,
    this.horizontalMargin = 20,
    this.verticalMargin = 15,
    this.minWidth = 390.0,
    this.borderColor,
    this.isGradinet = true,
    this.showIcon = false,
    this.icon,
    this.borderRadius = 100,
    super.key,
  });

  final VoidCallback? onPress;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final bool? buttonLoader;
  final double? horizontalMargin;
  final double? verticalMargin;
  final double? borderRadius;
  final double minWidth;
  final Color? borderColor;
  final bool? isGradinet;
  final Widget? icon;
  final bool? showIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin!,
      ),
      decoration: isGradinet!
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
              borderRadius: BorderRadius.circular(
                borderRadius!,
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(
                borderRadius!,
              ),
            ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: isGradinet! ? Colors.transparent : backgroundColor,
              backgroundColor: isGradinet! ? Colors.transparent : backgroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor ?? Colors.transparent),
                borderRadius: BorderRadius.circular(
                  borderRadius!,
                ),
              ),
              textStyle: interFont(fontWeight: FontWeight.w700),
              padding: EdgeInsets.symmetric(
                vertical: verticalMargin!,
              ),
              elevation: 0,
              minimumSize: Size(
                minWidth == 0 ? 0 : minWidth,
                0,
              ),
            ),
            onPressed: buttonLoader! ? null : onPress,
            child: buttonLoader!
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : showIcon! == false
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          text,
                          style: interFont(
                            fontWeight: FontWeight.w700,
                            color: textColor!,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icon!,
                            5.horizontalSpace,
                            Text(
                              text,
                              style: interFont(
                                fontWeight: FontWeight.w700,
                                color: textColor!,
                              ),
                            ),
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }
}
