import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/controllers/home_controller.dart';
import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/user_model.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/person_profile_image.dart';
import 'package:double_date/pages/settingScreens/screenWidgets/other_profile_stories.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PartnerProfileDetailScreen extends StatefulWidget {
  const PartnerProfileDetailScreen({
    super.key,
    this.isFromMatched = false,
    this.showAcceptDenyButton = true,
    this.showOtherOption = false,
    required this.data,
  });

  final bool? isFromMatched;
  final bool? showAcceptDenyButton;
  final bool? showOtherOption;
  final UserModel data;

  @override
  State<PartnerProfileDetailScreen> createState() => PartnerProfileDetailScreenState();
}

class PartnerProfileDetailScreenState extends State<PartnerProfileDetailScreen> {
  final matchedController = Get.put(MatchedController());
  final btController = Get.put(BottomNavController());
  final pc = Get.put(ProfileController());
  final hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return GetBuilder<MatchedController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            controller.hideOtherOption();
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
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
                      personMatch: '${data.partner!.matchPercentage}%',
                      image: controller.changePartner ? data.profilePicture! : data.partner!.user!.profilePicture!,
                      isFromMatched: widget.isFromMatched!,
                      showOtherOption: widget.showOtherOption!,
                      isFromProfile: true,
                      isNetworkImage: true,
                      onMessageTap: () {
                        controller.hideOtherOption();
                        btController.navBarChange(1);
                        Get.close(2);
                      },
                      // onBlockUser: () {
                      //   controller.hideOtherOption();
                      //   showDialog(
                      //     barrierDismissible: false,
                      //     context: context,
                      //     builder: (context) {
                      //       return DoubleButtonDialog(
                      //         onNo: () {
                      //           Get.back();
                      //         },
                      //         onYes: () {
                      //           Get.back();
                      //           Get.back();
                      //         },
                      //         heading: 'Block User',
                      //         bodyText: 'Are you sure you want to\nblock this User?',
                      //       );
                      //     },
                      //   );
                      // },
                      onRemovePartner: () async {
                        await pc.onRemovePartner(context: context);
                      },
                      // onReportUser: () {
                      //   controller.hideOtherOption();
                      //   showDialog(
                      //     barrierDismissible: false,
                      //     context: context,
                      //     builder: (context) {
                      //       return ReportUserDialog(
                      //         heading: 'Report User',
                      //         onTap: () {
                      //           Get.back();
                      //           showDialog(
                      //             barrierDismissible: false,
                      //             context: context,
                      //             builder: (context) {
                      //               return BasicDialog(
                      //                 heading: 'Report Submitted',
                      //                 bodyText: 'Your report has been submitted.',
                      //                 onTap: () {
                      //                   Get.back();
                      //                   Get.back();
                      //                   Get.back();
                      //                 },
                      //               );
                      //             },
                      //           );
                      //         },
                      //       );
                      //     },
                      //   );
                      // },
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
                          OtherProfileStory(
                            shorts: controller.changePartner ? data.shorts! : data.partner!.user!.shorts!,
                          ),
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
                                                controller.changePartner ? data.name! : data.partner!.user!.name!,
                                                style: interFont(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 230.w,
                                                child: Text(
                                                  controller.changePartner ? data.location!.address! : data.partner!.user!.location!.address!,
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
                                          CustomChip(
                                            text: data.name!,
                                            onTap: () {
                                              Get.back();
                                            },
                                          ),
                                          12.horizontalSpace,
                                          CustomChip(
                                            text: '${data.partner!.matchPercentage}%',
                                            textColor: Colors.black,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w400,
                                            backgroundColor: Colors.white,
                                            verticalPadding: 5,
                                            horizontalPadding: 10,
                                            showIcon: true,
                                            icon: SvgPicture.asset(meterIcon),
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
                                  controller.changePartner ? data.aboutYourself!.description! : data.partner!.user!.aboutYourself!.description!,
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
                                      controller.changePartner
                                          ? '${getCountryCode(data.countryCode!)} ${data.phone}'
                                          : '${getCountryCode(data.partner!.user!.countryCode!)} ${data.partner!.user!.phone}',
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
                                    controller.changePartner ? data.interest!.length : data.partner!.user!.interest!.length,
                                    (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8, bottom: 20),
                                        child: controller.changePartner
                                            ? Column(
                                                children: [
                                                  if (data.interest![index] != 'Other')
                                                    CustomChip(
                                                      text: data.interest![index],
                                                      onTap: () {},
                                                    ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  if (data.partner!.user!.interest![index] != 'Other')
                                                    CustomChip(
                                                      text: data.partner!.user!.interest![index],
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
                                      controller.changePartner ? data.relationshipGoals!.length : data.partner!.user!.relationshipGoals!.length,
                                      (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8, bottom: 20),
                                      child: Column(
                                        children: [
                                          CustomChip(
                                            text: controller.changePartner
                                                ? data.relationshipGoals![index]
                                                : data.partner!.user!.relationshipGoals![index],
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
                                  text: controller.changePartner
                                      ? data.aboutYourself!.sexualOrientation == ''
                                          ? data.aboutYourself!.otherSexualOrientation!
                                          : data.aboutYourself!.sexualOrientation!
                                      : data.partner!.user!.aboutYourself!.sexualOrientation == ''
                                          ? data.partner!.user!.aboutYourself!.otherSexualOrientation!
                                          : data.partner!.user!.aboutYourself!.sexualOrientation!,
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
                                      ? data.seekingFor! == ''
                                          ? data.otherSeekingFor!
                                          : data.seekingFor!
                                      : data.partner!.user!.seekingFor! == ''
                                          ? data.partner!.user!.otherSeekingFor!
                                          : data.partner!.user!.seekingFor!,
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
          ),
        );
      },
    );
  }
}
