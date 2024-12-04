import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShortsBottomSheet extends StatefulWidget {
  const ShortsBottomSheet({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
    this.title = 'Add Shorts',
    this.firstButtonTitle = 'CAMERA',
    this.secondButtonTitle = 'GALLERY',
  });

  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final String? title;
  final String? firstButtonTitle;
  final String? secondButtonTitle;

  @override
  State<ShortsBottomSheet> createState() => _ShortsBottomSheetState();
}

class _ShortsBottomSheetState extends State<ShortsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 260,
      width: 1.sw,
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        border: const Border(
          top: BorderSide(
            color: Color.fromARGB(255, 219, 89, 128),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Text(
                widget.title!,
                style: interFont(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
              40.verticalSpace,
              AppButton(
                text: widget.firstButtonTitle!,
                onPress: widget.onCameraTap,
              ),
              24.verticalSpace,
              AppButton(
                text: widget.secondButtonTitle!,
                onPress: widget.onGalleryTap,
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                crossIcon,
              ),
            ),
          )
        ],
      ),
    );
  }
}
