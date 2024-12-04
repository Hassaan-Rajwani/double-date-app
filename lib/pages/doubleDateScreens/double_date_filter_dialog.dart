import 'package:double_date/controllers/double_date_controller.dart';
import 'package:double_date/controllers/location_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_dropdown.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DoubleDateFilterDialog extends StatefulWidget {
  const DoubleDateFilterDialog({super.key});

  @override
  State<DoubleDateFilterDialog> createState() => _DoubleDateFilterDialogState();
}

class _DoubleDateFilterDialogState extends State<DoubleDateFilterDialog> {
  final dbController = Get.put(DoubleDateController());
  final lc = Get.put(LocationController());

  @override
  void dispose() {
    dbController.clearFilter(false, context, clearData: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoubleDateController>(
      builder: (controller) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: 0.9.sw,
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(20.r),
              border: modalBorder(),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Filter',
                              style: interFont(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            14.verticalSpace,
                            AppInput(
                              controller: controller.locationController,
                              placeHolder: 'Location',
                              label: 'Location',
                              horizontalMargin: 0,
                              bottomMargin: 10,
                              postfixIcon: GestureDetector(
                                onTap: () async {
                                  controller.locationController.text = await lc.getAddressFromLatLng(
                                    lc.latitude.value,
                                    lc.longitude.value,
                                  );
                                },
                                child: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              backColor: Colors.transparent,
                            ),
                            AppInput(
                              controller: controller.dateController,
                              label: 'Date',
                              horizontalMargin: 0,
                              placeHolder: controller.dateSet == true ? controller.dateController.text : 'DD/MM/YYYY',
                              onInputTap: () {
                                controller.selectDate(context);
                              },
                              readOnly: true,
                              backColor: Colors.transparent,
                              postfixIcon: Padding(
                                padding: const EdgeInsets.only(right: 15, left: 10),
                                child: SvgPicture.asset(calenderIcon),
                              ),
                              bottomMargin: 10,
                            ),
                            AppDropDown(
                              label: 'Event Type',
                              placeholder: 'Select Type',
                              list: controller.eventTypeList,
                              onChanged: (String? newValue) {
                                controller.updateEventType(newValue);
                              },
                              horizontalMargin: 0,
                              backColor: Colors.transparent,
                            ),
                            14.verticalSpace,
                            SizedBox(
                              width: 1.sw,
                              height: 50,
                              child: AppButton(
                                text: 'UPDATE SEARCH',
                                horizontalMargin: 0,
                                onPress: () {
                                  Get.close(1);
                                  controller.getOffersData(context: context, allowFilter: true);
                                },
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: SvgPicture.asset(crossIcon),
                          ),
                        ),
                      ],
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
