import 'package:double_date/controllers/home_controller.dart';
import 'package:double_date/controllers/location_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/slider_thumb_shape.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_dropdown.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final homeController = Get.put(HomeController());
  final lc = Get.put(LocationController());

  @override
  void dispose() {
    homeController.updateFilterCross(false, context, clearData: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
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
                          mainAxisSize: MainAxisSize.min,
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                        'Age Range',
                                        style: interFont(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 27),
                                      child: Text(
                                        'Between 24 and 30',
                                        style: interFont(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                8.verticalSpace,
                                SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 10.0,
                                    activeTrackColor: const Color(0xFF831136),
                                    inactiveTrackColor: Colors.white,
                                    thumbColor: const Color(0xFF831136),
                                    thumbShape: const BorderThumbShape(
                                      thumbRadius: 9.0,
                                      borderWidth: 2.0,
                                      borderColor: Colors.white,
                                    ),
                                    overlayColor: Colors.red.withAlpha(32),
                                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                                    tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
                                    activeTickMarkColor: Colors.redAccent,
                                    inactiveTickMarkColor: Colors.white,
                                  ),
                                  child: Slider(
                                    value: controller.sliderValue,
                                    max: 30,
                                    divisions: 30,
                                    label: controller.sliderValue.round().toString(),
                                    onChanged: (double value) {
                                      controller.updateSliderValue(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            14.verticalSpace,
                            AppDropDown(
                              label: 'Relationship Status',
                              placeholder: controller.relationshipStatusValue,
                              list: controller.relationShipStatusListForFilter,
                              onChanged: (String? newValue) {
                                controller.updateRelationshipStatus(newValue);
                              },
                              horizontalMargin: 0,
                            ),
                            AppDropDown(
                              label: 'Sexual Orientation',
                              placeholder: controller.sexualOrientationValue,
                              list: controller.sexualOrientationListForFilter,
                              onChanged: (String? newValue) {
                                controller.updateSexualOrientation(newValue);
                              },
                              horizontalMargin: 0,
                            ),
                            14.verticalSpace,
                            SizedBox(
                              width: 1.sw,
                              height: 50,
                              child: AppButton(
                                text: 'UPDATE SEARCH',
                                horizontalMargin: 0,
                                onPress: () async {
                                  await controller.onFilter(context: context);
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
