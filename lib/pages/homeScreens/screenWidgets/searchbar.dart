import 'package:double_date/controllers/home_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/homeScreens/filter_dialog.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeSearchbar extends StatefulWidget {
  const HomeSearchbar({super.key});

  @override
  State<HomeSearchbar> createState() => _HomeSearchbarState();
}

class _HomeSearchbarState extends State<HomeSearchbar> {
  final hc = Get.put(HomeController());
  final pc = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (pc) {
        return GetBuilder<HomeController>(
          builder: (hc) {
            return FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: AppInput(
                      onChanged: (val) {
                        hc.updateCross(false, context);
                      },
                      readOnly: pc.user.value.partner == null,
                      controller: hc.searchController,
                      placeHolder: 'Search your match',
                      horizontalMargin: 0,
                      verticalPadding: 0,
                      inputWidth: 300,
                      postfixIcon: GestureDetector(
                        onTap: () {
                          hc.showCross ? hc.updateCross(false, context, clearSearchBar: true) : hc.onSearch(context: context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, left: 10),
                          child: SvgPicture.asset(hc.showCross ? crossIcon : searchIcon),
                        ),
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      if (pc.user.value.partner != null) {
                        if (hc.showFilterCross) {
                          hc.updateFilterCross(false, context, clearData: true);
                        } else {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return const FilterDialog();
                            },
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 58,
                      height: 50,
                      padding: EdgeInsets.all(hc.showFilterCross ? 10 : 17),
                      decoration: BoxDecoration(
                        color: const Color(0xFF93193A),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: hc.showFilterCross
                          ? SvgPicture.asset(
                              crossIcon,
                            )
                          : SvgPicture.asset(
                              filterIcon,
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
