// ignore_for_file: deprecated_member_use
import 'package:double_date/controllers/home_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/app_user_contact_model.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/pages/homeScreens/sync_contacts.dart';
import 'package:double_date/pages/matchedScreens/screenWidgets/matched_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({super.key, required this.isFromHome});

  final bool isFromHome;

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  final hc = Get.put(HomeController());
  final pc = Get.put(ProfileController());

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  getContacts() async {
    await hc.fetchContacts(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
          allowCustomOnBack: widget.isFromHome ? false : true,
          customOnBack: () {
            Get.offAll(() => const Dashboard());
          },
          showSkipButton: widget.isFromHome == false,
          onSkipTap: () {
            Get.offAll(() => const Dashboard());
          }),
      body: WillPopScope(
        onWillPop: () async {
          Get.offAll(() => const Dashboard());
          return true;
        },
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(heartBg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Add Friends',
                        style: interFont(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    18.verticalSpace,
                    Center(
                      child: Text(
                        'Add some friends to match with other pairs\n(up to 3 friends)',
                        style: interFont(
                          fontSize: 12.8,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    24.verticalSpace,
                    FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppInput(
                            placeHolder: 'Search for friends',
                            onChanged: (val) {
                              hc.filterContacts(name: val, isAppUsers: true);
                            },
                            horizontalMargin: 0,
                            verticalPadding: 0,
                            inputWidth: 280,
                            postfixIcon: Container(
                              margin: const EdgeInsets.only(right: 15, left: 10),
                              child: SvgPicture.asset(searchIcon),
                            ),
                          ),
                          16.horizontalSpace,
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: CustomChip(
                              onTap: () {
                                Get.to(() => const SyncContacts());
                              },
                              text: '',
                              showIcon: true,
                              icon: const Icon(
                                Icons.sync,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    controller.contactLoader
                        ? Container(
                            height: 0.6.sh,
                            alignment: Alignment.center,
                            child: spinkit,
                          )
                        : controller.appUserFilterContacts.isEmpty
                            ? GetBuilder<ProfileController>(
                                builder: (pc) {
                                  return Container(
                                    height: 0.6.sh,
                                    alignment: Alignment.center,
                                    child: Text(
                                      pc.user.value.partner != null
                                          ? 'This app is not being used by any friends at the moment.'
                                          : 'Partner required to add contact friends',
                                      style: interFont(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: (controller.appUserFilterContacts.length / 2).ceil(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final int firstIndex = index * 2;
                                  final int secondIndex = firstIndex + 1;
                                  return Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    margin: EdgeInsets.only(left: 3.5.sp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (firstIndex < controller.appUserFilterContacts.length)
                                          buildCard(
                                            data: controller.appUserFilterContacts[firstIndex],
                                            context: context,
                                            onTap: () async {
                                              await hc.sendRequestToContactUser(
                                                context: context,
                                                userId: controller.appUserFilterContacts[firstIndex].sId!,
                                                index: index,
                                              );
                                            },
                                          ),
                                        10.horizontalSpace,
                                        if (secondIndex < controller.appUserFilterContacts.length)
                                          buildCard(
                                            data: controller.appUserFilterContacts[secondIndex],
                                            context: context,
                                            onTap: () async {
                                              await hc.sendRequestToContactUser(
                                                context: context,
                                                userId: controller.appUserFilterContacts[secondIndex].sId!,
                                                index: index,
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCard({
    required BuildContext context,
    required AppUserContactModel data,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: MatchedCard(
        width: 0.41,
        image: data.profilePicture!,
        city: data.location!.address!,
        nameAge: '${data.name!} ${calculateAge(
          data.dateofbirth!,
        )}',
        showSingleButton: true,
        singleButtonText: 'Add',
        singleButtonTextColor: Colors.white,
        singleButtonBackgoundColor: const Color(0xFF93193A),
        singleButtonOntap: onTap,
      ),
    );
  }
}
