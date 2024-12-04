import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/controllers/home_controller.dart';
import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/person_profile_image.dart';
import 'package:double_date/pages/matchedScreens/report_user_dialog.dart';
import 'package:double_date/pages/settingScreens/screenWidgets/other_profile_stories.dart';
import 'package:double_date/utils/enums.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OtherProfileDetailScreen extends StatefulWidget {
  const OtherProfileDetailScreen({
    super.key,
    this.isFromMatched = false,
    this.showAcceptDenyButton = true,
    this.showOtherOption = false,
    this.isFromProfile = false,
    this.requestStatus = '',
    this.isFrom = '',
  });

  final bool? isFromMatched;
  final bool? showAcceptDenyButton;
  final bool? showOtherOption;
  final bool? isFromProfile;
  final String? requestStatus;
  final String? isFrom;

  @override
  State<OtherProfileDetailScreen> createState() => OtherProfileDetailScreenState();
}

class OtherProfileDetailScreenState extends State<OtherProfileDetailScreen> {
  final mc = Get.put(MatchedController());
  final btController = Get.put(BottomNavController());
  final pc = Get.put(ProfileController());
  final hc = Get.put(HomeController());
  final sc = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchedController>(
      builder: (controller) {
        dynamic userData;
        dynamic partnerData;
        if (mc.pairedUserData.user != null) {
          userData = mc.pairedUserData.user!;
          partnerData = mc.pairedUserData.user!.partner!.user!;
        }
        return GestureDetector(
          onTap: () {
            controller.hideOtherOption();
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: mc.pairedLoader
                ? Center(child: spinkit)
                : SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(heartBg),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          PersonProfileImage(
                            personMatch: '${userData.partner!.matchPercentage}%',
                            image: !controller.changePartner ? userData.profilePicture! : partnerData.profilePicture!,
                            isFromMatched: widget.isFromMatched!,
                            showOtherOption: widget.showOtherOption!,
                            isFromProfile: widget.isFromProfile,
                            isNetworkImage: true,
                            //   onMessageTap: () {
                            //     if (widget.isFromProfile!) {
                            //       controller.hideOtherOption();
                            //       btController.navBarChange(1);
                            //       Get.close(2);
                            //     } else {
                            //       controller.hideOtherOption();
                            //       btController.navBarChange(1);
                            //       Get.close(1);
                            //     }
                            //   },
                            //   onBlockUser: () {
                            //     controller.hideOtherOption();
                            //     showDialog(
                            //       barrierDismissible: false,
                            //       context: context,
                            //       builder: (context) {
                            //         return DoubleButtonDialog(
                            //           onNo: () {
                            //             Get.back();
                            //           },
                            //           onYes: () {
                            //             Get.back();
                            //             Get.back();
                            //           },
                            //           heading: 'Block User',
                            //           bodyText: 'Are you sure you want to\nblock this User?',
                            //         );
                            //       },
                            //     );
                            //   },
                            //   onRemovePartner: () async {
                            //     await pc.onRemovePartner(context: context);
                            //   },
                            onReportUser: () {
                              controller.hideOtherOption();
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return ReportUserDialog(
                                    heading: 'Report User',
                                    onTap: () async {
                                      await sc.onReportUser(
                                        context: context,
                                        userId: !controller.changePartner ? userData.sId! : partnerData.sId!,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: const Border(
                                top: BorderSide(
                                  color: Colors.pink,
                                  width: 1,
                                ),
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              ),
                            ),
                            child: Column(
                              children: [
                                OtherProfileStory(shorts: !controller.changePartner ? userData.shorts! : partnerData.shorts!),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      !controller.changePartner ? userData.name! : partnerData.name!,
                                                      style: interFont(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 230.w,
                                                      child: Text(
                                                        !controller.changePartner ? userData.location!.address! : partnerData.location!.address!,
                                                        style: interFont(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                if (widget.isFromProfile!)
                                                  CustomChip(
                                                    text: userData.name!,
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                  )
                                                else
                                                  CustomChip(
                                                    text: controller.changePartner ? userData.name! : partnerData.name!,
                                                    onTap: () {
                                                      widget.isFromProfile! ? Get.back() : controller.updateChangePartner();
                                                    },
                                                  ),
                                                12.horizontalSpace,
                                                if (widget.isFromMatched!)
                                                  CustomChip(
                                                    text: '${userData.partner!.matchPercentage}%',
                                                    textColor: Colors.black,
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w400,
                                                    backgroundColor: Colors.white,
                                                    verticalPadding: 5,
                                                    horizontalPadding: 10,
                                                    showIcon: true,
                                                    icon: SvgPicture.asset(meterIcon),
                                                  )
                                                else
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await hc.onSendLikeRequest(
                                                        context: context,
                                                        userId: partnerData.sId!,
                                                        isFrom: LikeRequestFrom.OtherProfile,
                                                      );
                                                    },
                                                    child: SvgPicture.asset(likeIcon),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      20.verticalSpace,
                                      const Divider(
                                        color: Colors.white,
                                      ),
                                      20.verticalSpace,
                                      Text(
                                        'About:',
                                        style: interFont(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      8.verticalSpace,
                                      Text(
                                        !controller.changePartner ? userData.aboutYourself!.description! : partnerData.aboutYourself!.description!,
                                        style: interFont(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      24.verticalSpace,
                                      Text(
                                        'Phone Number:',
                                        style: interFont(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      8.verticalSpace,
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.phone_outlined,
                                            color: Color(0xFFB1124C),
                                          ),
                                          8.horizontalSpace,
                                          Text(
                                            !controller.changePartner
                                                ? '${getCountryCode('${userData.countryCode}')} ${userData.phone}'
                                                : '${getCountryCode('${partnerData.countryCode}')} ${partnerData.phone}',
                                            style: interFont(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      24.verticalSpace,
                                      Text(
                                        'Interest:',
                                        style: interFont(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      8.verticalSpace,
                                      Wrap(
                                        children: List.generate(
                                          !controller.changePartner ? userData.interest!.length : partnerData.interest!.length,
                                          (index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 8, bottom: 20),
                                              child: !controller.changePartner
                                                  ? Column(
                                                      children: [
                                                        if (userData.interest![index] != 'Other')
                                                          CustomChip(
                                                            text: userData.interest![index],
                                                            onTap: () {},
                                                          ),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        if (partnerData.interest![index] != 'Other')
                                                          CustomChip(
                                                            text: partnerData.interest![index],
                                                            onTap: () {},
                                                          ),
                                                      ],
                                                    ),
                                            );
                                          },
                                        ),
                                      ),
                                      24.verticalSpace,
                                      Text(
                                        'Relationship Preferences:',
                                        style: interFont(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      8.verticalSpace,
                                      Wrap(
                                        children: List.generate(
                                            !controller.changePartner ? userData.relationshipGoals!.length : partnerData.relationshipGoals!.length,
                                            (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 8, bottom: 20),
                                            child: Column(
                                              children: [
                                                CustomChip(
                                                  text: !controller.changePartner
                                                      ? userData.relationshipGoals![index]
                                                      : partnerData.relationshipGoals![index],
                                                  onTap: () {},
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                      24.verticalSpace,
                                      Text(
                                        'Sexual Orientation:',
                                        style: interFont(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      8.verticalSpace,
                                      CustomChip(
                                        text: !controller.changePartner
                                            ? userData.aboutYourself!.sexualOrientation == ''
                                                ? userData.aboutYourself!.otherSexualOrientation!
                                                : userData.aboutYourself!.sexualOrientation!
                                            : partnerData.aboutYourself!.sexualOrientation == ''
                                                ? partnerData.aboutYourself!.otherSexualOrientation!
                                                : partnerData.aboutYourself!.sexualOrientation!,
                                      ),
                                      24.verticalSpace,
                                      Text(
                                        'Iam A:',
                                        style: interFont(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      8.verticalSpace,
                                      CustomChip(
                                        text: !controller.changePartner
                                            ? userData.seekingFor! == ''
                                                ? userData.otherSeekingFor!
                                                : userData.seekingFor!
                                            : partnerData.seekingFor! == ''
                                                ? partnerData.otherSeekingFor!
                                                : partnerData.seekingFor!,
                                      ),
                                      44.verticalSpace,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            bottomNavigationBar: widget.isFromMatched! &&
                    widget.showAcceptDenyButton! &&
                    mc.pairedLoader == false &&
                    widget.requestStatus == RequestStatus.Pending.name &&
                    widget.isFrom == 'Like Recieved'
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            text: 'Accept',
                            minWidth: 175,
                            horizontalMargin: 0,
                            onPress: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return BasicDialog(
                                    heading: 'Invite Accepted',
                                    bodyText: 'You have accepted Like request.',
                                    onTap: () {
                                      Get.back();
                                      Get.back();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          20.horizontalSpace,
                          AppButton(
                            text: 'Reject',
                            minWidth: 175,
                            backgroundColor: Colors.black,
                            isGradinet: false,
                            borderColor: Colors.white,
                            horizontalMargin: 0,
                            onPress: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return BasicDialog(
                                    heading: 'Invite Denied',
                                    bodyText: 'You have denied Like request.',
                                    onTap: () {
                                      Get.back();
                                      Get.back();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                    height: 1,
                  ),
          ),
        );
      },
    );
  }
}
