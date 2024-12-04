import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/pages/feedScreens/feed_screen.dart';
import 'package:double_date/pages/homeScreens/custom_drawer.dart';
import 'package:double_date/pages/homeScreens/home_screen.dart';
import 'package:double_date/pages/homeScreens/notification_screen.dart';
import 'package:double_date/pages/matchedScreens/matched_screen.dart';
import 'package:double_date/pages/messageScreens/message_screen.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _MainScreenState();
}

class _MainScreenState extends State<Dashboard> {
  final bottomNav = Get.put(BottomNavController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var screens = [
    const HomeScreen(),
    const MessageScreen(),
    const FeedScreen(),
    const MatchedScreen(),
  ];

  void _onItemTaapped(int index) {
    bottomNav.navBarChange(index);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (controller) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          drawer: const CustomDrawer(),
          appBar: backButtonAppbar(
            showDrawerIcon: true,
            showNotificationIcon: true,
            onDrawerTap: () => scaffoldKey.currentState!.openDrawer(),
            title: bottomNav.bottomNavCurrentIndex == 2
                ? 'Feeds'
                : bottomNav.bottomNavCurrentIndex == 1
                    ? 'Messages'
                    : '',
            centerTitle: true,
            onNotificationTap: () {
              Get.to(
                () => const NotificationScreen(),
              );
            },
          ),
          body: screens[bottomNav.bottomNavCurrentIndex],
          extendBody: true,
          bottomNavigationBar: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF1472),
                  Color(0xFFB1124C),
                  Color(0xFF831136),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _onItemTaapped(0);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: bottomNav.bottomNavCurrentIndex == 0 ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.asset(
                              bottomNav.bottomNavCurrentIndex == 0 ? selectedHomeIcon : homeIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _onItemTaapped(1);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: bottomNav.bottomNavCurrentIndex == 1 ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.asset(
                              bottomNav.bottomNavCurrentIndex == 1 ? selectedmessageIcon : messageIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _onItemTaapped(2);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: bottomNav.bottomNavCurrentIndex == 2 ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.asset(
                              bottomNav.bottomNavCurrentIndex == 2 ? selectedfeedIcon : feedIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _onItemTaapped(3);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: bottomNav.bottomNavCurrentIndex == 3 ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.asset(
                              bottomNav.bottomNavCurrentIndex == 3 ? selectedmatchesIcon : matchesIcon,
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
      },
    );
  }
}
