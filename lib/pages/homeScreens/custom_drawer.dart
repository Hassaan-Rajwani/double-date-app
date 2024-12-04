import 'package:double_date/controllers/auth_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/authScreens/about_yourself.dart';
import 'package:double_date/pages/authScreens/add_friends.dart';
import 'package:double_date/pages/doubleDateScreens/double_date_offers.dart';
import 'package:double_date/pages/homeScreens/dating_consultant.dart';
import 'package:double_date/pages/homeScreens/help_and_feedback.dart';
import 'package:double_date/pages/homeScreens/subscription_screen.dart';
import 'package:double_date/pages/scheduleDoubleDate/upcoming_double_dates_calendar.dart';
import 'package:double_date/pages/settingScreens/profile.dart';
import 'package:double_date/pages/settingScreens/settings.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/global_varibles.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/drawer_card.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final ac = Get.put(AuthController());
    return SingleChildScrollView(
      child: Container(
        width: 0.8.sw,
        height: 0.95.sh,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          border: modalBorder(width: 0.3),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA8A8A8).withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              30.r,
            ),
            bottomRight: Radius.circular(
              30.r,
            ),
          ),
          image: DecorationImage(
            image: AssetImage(heartBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(crossIcon),
                  ),
                ),
              ),
              GetBuilder<ProfileController>(
                builder: (controller) {
                  return GestureDetector(
                    onTap: () async {
                      await ac.onSidebarDataStore(context: context);
                      Get.back();
                      Get.to(() => const UserProfileScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.pink,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: LoaderImage(
                              url: controller.user.value.profilePicture!,
                            ),
                          ),
                          12.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: interFont(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              4.verticalSpace,
                              Text(
                                controller.user.value.name!,
                                style: interFont(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB1124C),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              14.verticalSpace,
              GestureDetector(
                onTap: () {
                  GlobalVariable.isFromSidebar = true;
                  Get.back();
                  Get.to(
                    () => const DoubleDateOffersScreen(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SvgPicture.asset(doubleDateOfferIcon),
                ),
              ),
              DrawerCard(
                icon: calendar2Icon,
                text: 'Double Date Calendar',
                onTap: () {
                  Get.back();
                  Get.to(
                    () => const UpcomingDoubleDatesCalendar(),
                  );
                },
              ),
              15.verticalSpace,
              DrawerCard(
                icon: crown2Icon,
                text: 'Subscription',
                onTap: () {
                  Get.back();
                  Get.to(
                    () => const SubscriptionScreen(),
                  );
                },
              ),
              15.verticalSpace,
              DrawerCard(
                icon: helpIcon,
                text: 'Help & Feedback',
                onTap: () {
                  Get.back();
                  Get.to(
                    () => const HelpAndFeedbackScreen(),
                  );
                },
              ),
              15.verticalSpace,
              DrawerCard(
                icon: relationGoalIcon,
                text: 'Relationship Goals',
                onTap: () {
                  Get.back();
                  Get.to(
                    () => const AboutYourSeleftScreen(
                      isFromRelationshipGoals: true,
                      isFromEditProfile: false,
                    ),
                  );
                },
              ),
              15.verticalSpace,
              DrawerCard(
                icon: settingIcon,
                text: 'Settings',
                onTap: () {
                  Get.back();
                  Get.to(
                    () => const SettingsScreen(),
                  );
                },
              ),
              15.verticalSpace,
              DrawerCard(
                icon: adduserIcon,
                text: 'Add Friends',
                onTap: () {
                  Get.close(1);
                  Get.to(
                    () => const AddFriendsScreen(
                      isFromHome: true,
                    ),
                  );
                },
              ),
              15.verticalSpace,
              DrawerCard(
                icon: faqIcon,
                text: 'Dating Consultant',
                onTap: () {
                  Get.close(1);
                  Get.to(
                    () => const DatingConsultant(),
                  );
                },
              ),
              50.verticalSpace,
              GestureDetector(
                onTap: () {
                  Get.close(1);
                  profileController.onLogout(context: context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        logoutIcon,
                      ),
                      12.horizontalSpace,
                      Text(
                        'Logout',
                        style: interFont(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFB1124C),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
