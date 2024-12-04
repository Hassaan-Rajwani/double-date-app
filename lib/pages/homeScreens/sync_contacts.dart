import 'package:double_date/controllers/home_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/utils/font_constant.dart';
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

class SyncContacts extends StatefulWidget {
  const SyncContacts({super.key});

  @override
  State<SyncContacts> createState() => _SyncContactsState();
}

class _SyncContactsState extends State<SyncContacts> {
  final hc = Get.put(HomeController());
  final pc = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(),
      body: GetBuilder<HomeController>(builder: (hc) {
        return SingleChildScrollView(
          child: Container(
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
                14.verticalSpace,
                Text(
                  'Sync Contact From Phonebook',
                  style: interFont(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.verticalSpace,
                AppInput(
                  placeHolder: 'Search for friends',
                  onChanged: (val) {
                    hc.filterContacts(name: val, isAppUsers: false);
                  },
                  horizontalMargin: 0,
                  verticalPadding: 0,
                  postfixIcon: Container(
                    margin: const EdgeInsets.only(right: 15, left: 10),
                    child: SvgPicture.asset(searchIcon),
                  ),
                ),
                hc.contactLoader
                    ? Container(
                        height: 0.65.sh,
                        alignment: Alignment.center,
                        child: spinkit,
                      )
                    : hc.otherFilterContacts.isEmpty
                        ? GetBuilder<ProfileController>(
                            builder: (pc) {
                              return Container(
                                height: 0.65.sh,
                                alignment: Alignment.center,
                                child: Text(
                                  pc.user.value.partner != null ? 'No friends available' : 'Partner required to add contact friends',
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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: hc.otherFilterContacts.length,
                            itemBuilder: (context, index) {
                              final data = hc.otherFilterContacts[index];
                              return card(name: '${data.name}');
                            },
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget card({required String name}) {
  return Column(
    children: [
      16.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: interFont(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
          const CustomChip(
            text: 'ADD',
            verticalPadding: 8,
            // onTap: () {
            //   showDialog(
            //     barrierDismissible: false,
            //     context: context,
            //     builder: (context) {
            //       return const DoubleDatePremiumDialog();
            //     },
            //   );
            // },
          ),
        ],
      ),
      16.verticalSpace,
      SvgPicture.asset(lineIcon)
    ],
  );
}
