import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDown extends StatelessWidget {
  const AppDropDown({
    this.label = '',
    this.borderColor = const Color(0xFFFF1472),
    this.horizontalMargin = 20,
    this.bottomMargin = 20,
    this.backColor,
    required this.list,
    required this.onChanged,
    required this.placeholder,
    this.validator,
    super.key,
  });

  final String? label;
  final Color? borderColor;
  final double? horizontalMargin;
  final double? bottomMargin;
  final List<String> list;
  final ValueChanged<String?> onChanged;
  final String placeholder;
  final Color? backColor;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label! == '')
          Container()
        else
          Container(
            margin: const EdgeInsets.only(left: 8, bottom: 10),
            child: Text(
              label!,
              style: interFont(
                color: const Color(0xFF93193A),
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.only(bottom: bottomMargin!),
          child: DropdownButtonFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            dropdownColor: const Color(0xFFFF1472),
            alignment: Alignment.topCenter,
            isDense: true,
            borderRadius: BorderRadius.circular(15.r),
            iconEnabledColor: Colors.white,
            items: list.map(
              (category) {
                return DropdownMenuItem(
                  value: category,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: SizedBox(
                      child: Text(
                        category.toString(),
                        style: interFont(
                          fontSize: 12.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              counterText: null,
              filled: true,
              fillColor: backColor ?? Colors.transparent,
              hintText: placeholder,
              alignLabelWithHint: true,
              iconColor: const Color(0xFFD4DDE5),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17.5),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor!),
                borderRadius: BorderRadius.circular(
                  10.r,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor!,
                ),
                borderRadius: BorderRadius.circular(
                  10.r,
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
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 12.sp,
              ),
              counterStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              ),
              errorMaxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}
