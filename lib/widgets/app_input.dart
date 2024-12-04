import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    required this.placeHolder,
    this.error = '',
    this.label = '',
    this.keyboardType,
    this.controller,
    this.showPasswordIcon = false,
    this.onTap,
    this.obscureText = false,
    this.validator,
    this.enabled,
    this.horizontalMargin = 20,
    this.borderRadius = 10,
    this.bottomMargin = 20,
    this.verticalPadding = 20,
    this.maxLines = 1,
    this.maxLenght = 100,
    this.prefixIcon,
    this.postfixIcon,
    this.onChanged,
    this.onEnventSumbit,
    this.textarea = true,
    this.backColor,
    this.inputWidth,
    this.onInputTap,
    this.minLine,
    this.focusNode,
    this.isCounterText = false,
    this.isAutoFocus = false,
    this.readOnly = false,
    this.borderColor = const Color(0xFFFF1472),
    super.key,
  });

  final String placeHolder;
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? showPasswordIcon;
  final VoidCallback? onTap;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onEnventSumbit;
  final bool? enabled;
  final double? horizontalMargin;
  final double? bottomMargin;
  final double? verticalPadding;
  final double? borderRadius;
  final double? inputWidth;
  final int? maxLines;
  final int? maxLenght;
  final Widget? prefixIcon;
  final Widget? postfixIcon;
  final String error;
  final bool textarea;
  final Color? backColor;
  final bool isCounterText;
  final bool isAutoFocus;
  final Color? borderColor;
  final VoidCallback? onInputTap;
  final bool readOnly;
  final FocusNode? focusNode;
  final int? minLine;

  @override
  Widget build(BuildContext context) {
    final customInputDecoration = InputDecoration(
      prefixIcon: prefixIcon,
      counterText: isCounterText ? null : '',
      filled: true,
      fillColor: backColor ?? Colors.transparent,
      hintText: placeHolder,
      iconColor: const Color(0xFFD4DDE5),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalPadding!),
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor!),
        borderRadius: BorderRadius.circular(
          borderRadius!.r,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor!,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius!.r,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(
          8.r,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(
          8.r,
        ),
      ),
      hintStyle: interFont(
        fontSize: 12.0,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(
          8.r,
        ),
      ),
      suffixIcon: showPasswordIcon!
          ? InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  5.sp,
                  5.sp,
                  2.sp,
                  5.sp,
                ),
                child: !obscureText!
                    ? const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color(0xFFCACACA),
                      )
                    : const Icon(
                        FontAwesomeIcons.eyeSlash,
                        size: 18,
                        color: Color(0xFFCACACA),
                      ),
              ),
            )
          : postfixIcon,
      errorText: error.isEmpty ? null : error,
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 12.sp,
      ),
      counterStyle: TextStyle(
        fontSize: 12.sp,
        color: Colors.white,
      ),
      errorMaxLines: 2,
    );

    return Container(
      width: inputWidth,
      margin: EdgeInsets.fromLTRB(
        horizontalMargin!,
        0,
        horizontalMargin!,
        bottomMargin!,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label! == '')
            Container()
          else
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                label!,
                style: interFont(
                  color: const Color(0xFF93193A),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          8.verticalSpace,
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: minLine != null
                ? TextFormField(
                    focusNode: focusNode,
                    readOnly: readOnly,
                    onTap: onInputTap,
                    onFieldSubmitted: onEnventSumbit,
                    autofocus: isAutoFocus,
                    style: interFont(
                      fontSize: 12.0,
                    ),
                    keyboardType: keyboardType,
                    controller: controller,
                    onChanged: onChanged,
                    decoration: customInputDecoration,
                    obscureText: obscureText!,
                    validator: validator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    enabled: enabled,
                    maxLines: maxLines,
                    maxLength: maxLenght,
                    minLines: 1,
                  )
                : TextFormField(
                    focusNode: focusNode,
                    readOnly: readOnly,
                    onTap: onInputTap,
                    onFieldSubmitted: onEnventSumbit,
                    autofocus: isAutoFocus,
                    style: interFont(
                      fontSize: 12.0,
                    ),
                    keyboardType: keyboardType,
                    controller: controller,
                    onChanged: onChanged,
                    decoration: customInputDecoration,
                    obscureText: obscureText!,
                    validator: validator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    enabled: enabled,
                    maxLines: maxLines,
                    maxLength: maxLenght,
                  ),
          ),
        ],
      ),
    );
  }
}
