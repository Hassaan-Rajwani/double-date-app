import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

PreferredSizeWidget chatAppbar({
  required String title,
  required String imageUrl,
  required VoidCallback otherOptionTap,
  VoidCallback? onProfileTap,
  required VoidCallback onBack,
  required bool isDisable,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: GestureDetector(
      onTap: onBack,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: SvgPicture.asset(
          backIcon,
        ),
      ),
    ),
    title: GestureDetector(
      onTap: isDisable == false ? onProfileTap : null,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.pink,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: LoaderImage(
              url: imageUrl,
              width: 50,
              height: 50,
            ),
          ),
          12.horizontalSpace,
          SizedBox(
            width: 0.4.sw,
            child: Text(
              title,
              style: interFont(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
    actions: [
      if (isDisable == false)
        GestureDetector(
          onTap: otherOptionTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(8),
                border: modalBorder(width: 0.5),
              ),
              child: SvgPicture.asset(threeDotsIcon),
            ),
          ),
        ),
    ],
  );
}
