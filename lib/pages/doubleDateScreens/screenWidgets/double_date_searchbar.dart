// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:double_date/controllers/double_date_controller.dart';
import 'package:double_date/pages/doubleDateScreens/double_date_filter_dialog.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DoubleDateSearchBar extends StatefulWidget {
  const DoubleDateSearchBar({super.key});

  @override
  State<DoubleDateSearchBar> createState() => _DoubleDateSearchBarState();
}

class _DoubleDateSearchBarState extends State<DoubleDateSearchBar> {
  final dd = Get.put(DoubleDateController());
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoubleDateController>(
      builder: (dd) {
        return FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: AppInput(
                  onChanged: (val) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 300), () {
                      dd.getOffersData(
                        context: context,
                      );
                    });
                  },
                  controller: dd.searchController,
                  placeHolder: 'Search activities',
                  horizontalMargin: 0,
                  verticalPadding: 0,
                  inputWidth: 300,
                  postfixIcon: Container(
                    margin: const EdgeInsets.only(right: 15, left: 10),
                    child: SvgPicture.asset(searchIcon),
                  ),
                ),
              ),
              10.horizontalSpace,
              GestureDetector(
                onTap: () async {
                  if (dd.showFilterCross) {
                    dd.clearFilter(false, context, clearData: true);
                    dd.getOffersData(context: context);
                  } else {
                    await dd.getCategoryList(context: context);
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const DoubleDateFilterDialog();
                      },
                    );
                  }
                },
                child: Container(
                  width: 58,
                  height: 50,
                  padding: EdgeInsets.all(dd.showFilterCross ? 10 : 17),
                  decoration: BoxDecoration(
                    color: const Color(0xFF93193A),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: dd.showFilterCross
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
  }
}
