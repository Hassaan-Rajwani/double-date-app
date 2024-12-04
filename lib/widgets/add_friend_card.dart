import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddFriendsCard extends StatelessWidget {
  const AddFriendsCard({
    super.key,
    required this.nameAge,
    required this.city,
    required this.imageHeight,
    this.showAddedButton = false,
    this.onTap,
    required this.image,
    this.personMatch = '50',
    this.showButton = true,
    this.twoMoreFields = false,
    this.showMeterIcon = false,
    this.fontSize = 16.0,
    this.relationShipStatus = '',
    this.orientation = '',
    this.allowTopPadding = false,
    required this.showNetworkImage,
    this.partnerName = '',
    this.width = 0.72,
  });

  final String nameAge;
  final String city;
  final bool? showAddedButton;
  final VoidCallback? onTap;
  final String image;
  final String? partnerName;
  final String? personMatch;
  final bool? showButton;
  final bool? showMeterIcon;
  final bool? twoMoreFields;
  final double? fontSize;
  final String? relationShipStatus;
  final String? orientation;
  final bool? allowTopPadding;
  final bool showNetworkImage;
  final double imageHeight;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.sw,
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
              Padding(
                padding: EdgeInsets.only(top: allowTopPadding! ? 6 : 0),
                child: showNetworkImage
                    ? LoaderImage(
                        url: image,
                        width: 0.72.sw,
                        height: imageHeight.h,
                        borderRadius: 10.r,
                      )
                    : SizedBox(
                        width: 0.72.sw,
                        height: imageHeight.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              Positioned(
                right: 10,
                top: 20,
                child: CustomChip(
                  text: '${personMatch!}% match',
                  textColor: Colors.black,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                  backgroundColor: Colors.white,
                  verticalPadding: 5,
                  horizontalPadding: 10,
                  showIcon: showMeterIcon!,
                  icon: SvgPicture.asset(meterIcon),
                ),
              ),
            ],
          ),
          5.verticalSpace,
          Text(
            nameAge,
            style: interFont(
              fontSize: fontSize!,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (partnerName != '')
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Partner: ',
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      partnerName!,
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB1124C),
                      ),
                    ),
                  ],
                ),
                5.verticalSpace,
              ],
            ),
          Text(
            city,
            style: interFont(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          6.verticalSpace,
          if (twoMoreFields!)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Relationship Status: ',
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      relationShipStatus!,
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB1124C),
                      ),
                    ),
                  ],
                ),
                6.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Orientation: ',
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      orientation!,
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB1124C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          6.verticalSpace,
          if (showButton!)
            GestureDetector(
              onTap: showAddedButton! ? null : onTap,
              child: Container(
                width: 137.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: showAddedButton! ? Colors.white : const Color(0xFF93193A),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    showAddedButton! ? 'Added' : 'Add',
                    style: interFont(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: showAddedButton! ? const Color(0xFF93193A) : Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
