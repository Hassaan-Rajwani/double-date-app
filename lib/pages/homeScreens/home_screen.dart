import 'package:double_date/controllers/auth_controller.dart';
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/home_controller.dart';
import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/models/user_model.dart';
import 'package:double_date/pages/doubleDateScreens/double_date_offers.dart';
import 'package:double_date/pages/homeScreens/other_profile_details.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/home_card.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/searchbar.dart';
import 'package:double_date/pages/settingScreens/profile.dart';
import 'package:double_date/repositories/auth_repository.dart';
import 'package:double_date/utils/enums.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/Card%20Swiper/card_swiper.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final hc = Get.put(HomeController());
  final pc = Get.put(ProfileController());
  final mc = Get.put(MatchedController());
  final ac = Get.put(AuthController());

  @override
  void initState() {
    Get.put(SocketController());
    pc.showDetailsInEditProfile();
    getProfile();
    hc.getHomeMatches(context: context);
    super.initState();
  }

  @override
  void dispose() {
    hc.updateCross(false, context, clearSearchBar: true);
    hc.updateFilterCross(false, context, clearData: true);
    super.dispose();
  }

  getProfile() async {
    final res = await AuthRepository().autoLogin(
      context: context,
      showLoader: false,
    );
    if (res != null && res['data'] != null) {
      final fc = Get.put(FeedController());
      pc.saveUserDetails(
        UserModel.fromJson(
          res['data']['user'],
        ),
      );
      fc.editfeedData = res['data']['user']['posts'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          keyboardDismissle(context);
        },
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const HomeSearchbar(),
                  SizedBox(
                    height: 0.7.sh,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GetBuilder<ProfileController>(
                            builder: (pc) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width: 422,
                                    height: controller.showCross || controller.showFilterCross
                                        ? hc.filterData.length >= 3
                                            ? 472
                                            : hc.filterData.length == 2
                                                ? 462
                                                : 442
                                        : hc.homeData.length >= 3
                                            ? 472
                                            : hc.homeData.length == 2
                                                ? 462
                                                : 442,
                                    child: controller.homeLoader
                                        ? spinkit
                                        : pc.user.value.partner == null
                                            ? GestureDetector(
                                                onTap: () async {
                                                  await ac.onSidebarDataStore(context: context);
                                                  Get.to(() => const UserProfileScreen());
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(noPartner),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : controller.showCross || controller.showFilterCross
                                                ? controller.filterData.isEmpty
                                                    ? noMatch()
                                                    : card(showHomeData: false)
                                                : controller.homeData.isEmpty
                                                    ? noMatch()
                                                    : card(showHomeData: true),
                                  ),
                                  30.verticalSpace,
                                  if (pc.user.value.partner != null)
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => const DoubleDateOffersScreen());
                                      },
                                      child: FittedBox(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          width: 1.sw,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.r),
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF93193A),
                                                Color(0xFF3A111C),
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(crownIcon),
                                                22.horizontalSpace,
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Double Date Special Offers',
                                                      style: interFont(
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Lorem ipsum dolor sit amet',
                                                      style: interFont(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w300,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          130.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget noMatch() {
    return Center(
      child: Text(
        'No Matches Available',
        style: interFont(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget card({required bool showHomeData}) {
    return GetBuilder<HomeController>(
      builder: (hc) {
        return CardSwiper(
          padding: EdgeInsets.fromLTRB(
              20,
              hc.showCross || hc.showFilterCross
                  ? hc.filterData.length >= 3
                      ? 50
                      : hc.filterData.length == 2
                          ? 40
                          : 20
                  : hc.homeData.length >= 3
                      ? 50
                      : hc.homeData.length == 2
                          ? 40
                          : 20,
              20,
              0),
          cardsCount: showHomeData ? hc.homeData.length : hc.filterData.length,
          numberOfCardsDisplayed: showHomeData
              ? hc.homeData.length >= 3
                  ? 3
                  : hc.homeData.length
              : hc.filterData.length >= 3
                  ? 3
                  : hc.filterData.length,
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
            final data = showHomeData ? hc.homeData[index] : hc.filterData[index];
            return HomeCard(
              person1Name: data.name!,
              person2Name: data.partner!.name!,
              person1Image: data.profilePicture!,
              person2Image: data.partner!.profilePicture!,
              onImage1Tap: () {
                mc.getPartnersData(context: context, id: data.sId!);
                Get.to(() => const OtherProfileDetailScreen());
              },
              onImage2Tap: () {
                mc.getPartnersData(context: context, id: data.partner!.sId!);
                Get.to(() => const OtherProfileDetailScreen());
              },
              onHeartTap: () async {
                await hc.onSendLikeRequest(
                  context: context,
                  userId: data.sId!,
                  index: index,
                  isFrom: LikeRequestFrom.Home,
                );
              },
            );
          },
          onSwipe: hc.onSwipe,
        );
      },
    );
  }
}
