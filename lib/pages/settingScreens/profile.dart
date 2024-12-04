// ignore_for_file: deprecated_member_use
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/authScreens/add_partner_dialog.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/post_card.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/pages/homeScreens/partner_profile_screen.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/person_profile_image.dart';
import 'package:double_date/pages/settingScreens/screenWidgets/profile_story.dart';
import 'package:double_date/utils/enums.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final fc = Get.put(FeedController());
  final pc = Get.put(ProfileController());
  final mc = Get.put(MatchedController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const Dashboard());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<ProfileController>(
          builder: (pc) {
            final user = pc.user.value;
            return GetBuilder<FeedController>(
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    controller.hidePostOption();
                  },
                  child: SingleChildScrollView(
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
                            personMatch: '${user.partner != null ? user.partner!.matchPercentage : ''}',
                            image: user.profilePicture!,
                            isNetworkImage: true,
                            isFromMatched: false,
                            showOtherOption: false,
                            showPercentageText: false,
                            showEditIcon: true,
                            isFromProfile: true,
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
                                const ProfileStory(),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${user.name!} ${calculateAge(
                                                    user.dateofbirth!,
                                                  )}',
                                                  style: interFont(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(right: 20.w),
                                                  width: 230.w,
                                                  child: Text(
                                                    user.location!.address!,
                                                    style: interFont(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                if (user.partner == null)
                                                  CustomChip(
                                                    text: 'Add Partner',
                                                    onTap: () {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return AddPartnerDialog(
                                                            onTap: () async {
                                                              if (pc.fieldTypePartnerModal == FieldTypeInPartnerModal.Code.name) {
                                                                await pc.pairPartner(context: context);
                                                              } else {
                                                                await pc.onAddPartnerRequest(context: context);
                                                              }
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  )
                                                else
                                                  CustomChip(
                                                    text: user.partner!.user!.name!,
                                                    onTap: () {
                                                      Get.to(
                                                        () => PartnerProfileDetailScreen(
                                                          showAcceptDenyButton: false,
                                                          isFromMatched: true,
                                                          showOtherOption: true,
                                                          data: user,
                                                        ),
                                                      );
                                                    },
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
                                        user.aboutYourself!.description!,
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
                                            '${getCountryCode(user.countryCode!)} ${user.phone}',
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
                                        children: [
                                          ...List.generate(user.interest!.length, (index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 8, bottom: 20),
                                              child: Column(
                                                children: [
                                                  if (user.interest![index] != 'Other')
                                                    CustomChip(
                                                      text: user.interest![index],
                                                      onTap: () {},
                                                    ),
                                                ],
                                              ),
                                            );
                                          }),
                                          if (user.otherInterest != '')
                                            CustomChip(
                                              text: user.otherInterest!,
                                              onTap: () {},
                                            ),
                                        ],
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
                                        children: List.generate(user.relationshipGoals!.length, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 8, bottom: 20),
                                            child: Column(
                                              children: [
                                                CustomChip(
                                                  text: user.relationshipGoals![index],
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
                                        text: user.aboutYourself!.sexualOrientation == ''
                                            ? user.aboutYourself!.otherSexualOrientation!
                                            : user.aboutYourself!.sexualOrientation!,
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
                                        text: user.seekingFor! == '' ? user.otherSeekingFor! : user.seekingFor!,
                                      ),
                                      44.verticalSpace,
                                      Stack(
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: user.posts!.length,
                                            itemBuilder: (context, index) {
                                              final data = user.posts![index];
                                              return PostCard(
                                                index: index,
                                                data: data,
                                                showReportOption: data.sId != user.sId,
                                              );
                                            },
                                          ),
                                          if (user.posts!.isNotEmpty)
                                            Positioned(
                                              top: 0,
                                              child: Text(
                                                'My Posts:',
                                                style: interFont(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
