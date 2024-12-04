import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/authScreens/create_profile.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PersonProfileImage extends StatefulWidget {
  const PersonProfileImage({
    super.key,
    required this.personMatch,
    required this.image,
    required this.isFromMatched,
    required this.showOtherOption,
    this.onMessageTap,
    this.onRemovePartner,
    // this.onBlockUser,
    this.onReportUser,
    this.showPercentageText = true,
    this.showEditIcon = false,
    this.isFromProfile = false,
    this.isNetworkImage = false,
  });

  final String personMatch;
  final String image;
  final bool isFromMatched;
  final bool showOtherOption;
  final VoidCallback? onMessageTap;
  // final VoidCallback? onBlockUser;
  final VoidCallback? onReportUser;
  final VoidCallback? onRemovePartner;
  final bool? showPercentageText;
  final bool? showEditIcon;
  final bool? isFromProfile;
  final bool? isNetworkImage;

  @override
  State<PersonProfileImage> createState() => _PersonProfileImageState();
}

class _PersonProfileImageState extends State<PersonProfileImage> {
  final matchedController = Get.put(MatchedController());
  final pc = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchedController>(
      builder: (controller) {
        return SizedBox(
          width: 1.sw,
          height: 270,
          child: Stack(
            children: [
              if (widget.isNetworkImage!)
                LoaderImage(
                  url: widget.image,
                  height: 270,
                  width: 1.sw,
                  borderRadius: 0,
                )
              else
                Image.asset(
                  width: 1.sw,
                  height: 270,
                  widget.image,
                  fit: BoxFit.cover,
                ),
              if (!widget.isFromMatched && widget.showPercentageText!)
                Positioned(
                  right: 25,
                  bottom: 25,
                  child: CustomChip(
                    text: widget.personMatch,
                    textColor: Colors.black,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    backgroundColor: Colors.white,
                    verticalPadding: 5,
                    horizontalPadding: 10,
                    showIcon: true,
                    icon: SvgPicture.asset(meterIcon),
                  ),
                ),
              Positioned(
                top: 60,
                left: 30,
                child: GestureDetector(
                  onTap: () {
                    if (widget.isFromProfile!) {
                      Get.offAll(() => const Dashboard());
                    } else {
                      Get.back();
                    }
                  },
                  child: SvgPicture.asset(whiteBackIcon),
                ),
              ),
              if (widget.showEditIcon!)
                Positioned(
                  top: 60,
                  right: 30,
                  child: GestureDetector(
                    onTap: () {
                      pc.showDetailsInEditProfile();
                      Get.to(
                        () => const CreateProfile(
                          isFromEditProfile: true,
                          isFromRelationshipGoals: false,
                        ),
                      );
                    },
                    child: SvgPicture.asset(editIcon),
                  ),
                ),
              if (widget.showOtherOption)
                Positioned(
                  top: 60,
                  right: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          if (widget.isFromProfile!)
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: widget.onMessageTap,
                                  child: SvgPicture.asset(message2Icon),
                                ),
                                12.horizontalSpace,
                              ],
                            ),
                          GestureDetector(
                            onTap: () {
                              controller.showOtherOption ? controller.hideOtherOption() : controller.enableOtherOption();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF161616),
                                borderRadius: BorderRadius.circular(8),
                                border: modalBorder(width: 0.5),
                              ),
                              child: SvgPicture.asset(threeDotsIcon),
                            ),
                          ),
                        ],
                      ),
                      if (controller.showOtherOption)
                        Column(
                          children: [
                            10.verticalSpace,
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF161616),
                                borderRadius: BorderRadius.circular(8),
                                border: modalBorder(width: 0.5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.isFromProfile!)
                                    Column(
                                      children: [
                                        // 12.verticalSpace,
                                        GestureDetector(
                                          onTap: widget.onRemovePartner,
                                          child: Text(
                                            'Remove Partner',
                                            style: interFont(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // GestureDetector(
                                        //   // onTap: widget.onBlockUser,
                                        //   child: Text(
                                        //     'Block User',
                                        //     style: interFont(
                                        //       fontWeight: FontWeight.w700,
                                        //     ),
                                        //   ),
                                        // ),
                                        // 12.verticalSpace,
                                        GestureDetector(
                                          onTap: widget.onReportUser,
                                          child: Text(
                                            'Report User',
                                            style: interFont(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
