import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.text1,
    required this.text2,
    this.hideLine = false,
  });

  final String text1;
  final String text2;
  final bool? hideLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: interFont(fontSize: 12.0),
            ),
            Text(
              text2,
              style: interFont(fontSize: 12.0),
            ),
          ],
        ),
        if (!hideLine!)
          Column(
            children: [
              10.verticalSpace,
              const Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              10.verticalSpace,
            ],
          )
      ],
    );
  }
}
