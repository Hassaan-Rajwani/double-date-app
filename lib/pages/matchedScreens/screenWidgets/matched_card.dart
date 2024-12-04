import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchedCard extends StatelessWidget {
  const MatchedCard({
    super.key,
    required this.nameAge,
    required this.city,
    this.onTap,
    this.onAccept,
    this.onDeny,
    this.image = '',
    this.showAcceptDenyButton = false,
    this.showSingleButton = false,
    this.singleButtonText = '',
    this.matchCount = '50',
    this.width = 0.72,
    this.singleButtonBackgoundColor = Colors.white,
    this.singleButtonTextColor = const Color(0xFF93193A),
    this.singleButtonOntap,
  });

  final String nameAge;
  final String city;
  final VoidCallback? onTap;
  final String? image;
  final double? width;
  final String? singleButtonText;
  final String? matchCount;
  final bool? showAcceptDenyButton;
  final VoidCallback? onAccept;
  final VoidCallback? onDeny;
  final bool? showSingleButton;
  final Color? singleButtonBackgoundColor;
  final Color? singleButtonTextColor;
  final VoidCallback? singleButtonOntap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width!.sw,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFFF1472),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                image != ''
                    ? LoaderImage(
                        url: image!,
                        height: 155.h,
                        width: 0.72.sw,
                        borderRadius: 10.r,
                      )
                    : SizedBox(
                        width: 0.72.sw,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            sarah,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                if (matchCount != '0')
                  Positioned(
                    right: 10,
                    top: 10,
                    child: CustomChip(
                      text: '$matchCount% match',
                      textColor: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      backgroundColor: Colors.white,
                      verticalPadding: 5,
                      horizontalPadding: 10,
                    ),
                  ),
              ],
            ),
            5.verticalSpace,
            Text(
              nameAge,
              style: interFont(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              city,
              style: interFont(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            if (showSingleButton!)
              Column(
                children: [
                  6.verticalSpace,
                  GestureDetector(
                    onTap: singleButtonOntap,
                    child: Container(
                      width: 135.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: singleButtonBackgoundColor!,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          singleButtonText!,
                          style: interFont(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            color: singleButtonTextColor!,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (showAcceptDenyButton!)
              Column(
                children: [
                  6.verticalSpace,
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: onAccept,
                          child: Container(
                            width: 70.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF93193A),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'Accept',
                                style: interFont(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        5.horizontalSpace,
                        GestureDetector(
                          onTap: onDeny,
                          child: Container(
                            width: 70.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'Deny',
                                style: interFont(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF93193A),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
