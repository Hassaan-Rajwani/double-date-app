import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({
    super.key,
    this.label = '',
    this.controller,
    this.horizontalMargin = 20,
    this.bottomMargin = 20,
    this.verticalPadding = 20,
    required this.onInputChanged,
    this.errorMessage = '',
    required this.initialValue,
  });

  final String? label;
  final TextEditingController? controller;
  final double? horizontalMargin;
  final double? bottomMargin;
  final double? verticalPadding;
  final void Function(PhoneNumber)? onInputChanged;
  final String? errorMessage;
  final PhoneNumber initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
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
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1,
                color: errorMessage == null ? const Color(0xFFFF1472) : Colors.red,
              ),
            ),
            child: InternationalPhoneNumberInput(
              errorMessage: null,
              textFieldController: controller,
              onInputChanged: onInputChanged,
              spaceBetweenSelectorAndTextField: 0,
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
                showFlags: false,
                setSelectorButtonAsPrefixIcon: false,
                trailingSpace: false,
              ),
              ignoreBlank: false,
              selectorTextStyle: interFont(
                fontSize: 12.0,
              ),
              textStyle: interFont(
                fontSize: 12.0,
              ),
              inputDecoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                hintStyle: interFont(
                  fontSize: 12.0,
                ),
                border: InputBorder.none,
                hintText: 'Enter your phone number',
              ),
              initialValue: initialValue,
              formatInput: false,
              keyboardType: TextInputType.phone,
            ),
          ),
          if (errorMessage != null)
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                errorMessage!,
                style: interFont(
                  color: Colors.red,
                  fontSize: 12.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
