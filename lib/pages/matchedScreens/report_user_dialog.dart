import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_dropdown.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReportUserDialog extends StatefulWidget {
  const ReportUserDialog({
    super.key,
    required this.onTap,
    required this.heading,
  });

  final VoidCallback onTap;
  final String heading;

  @override
  State<ReportUserDialog> createState() => ReportUserDialogState();
}

class ReportUserDialogState extends State<ReportUserDialog> {
  final sc = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
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
                child: Form(
                  key: controller.reportUserFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Text(
                                widget.heading,
                                style: interFont(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              24.verticalSpace,
                              AppDropDown(
                                label: 'Reason of report',
                                list: controller.reportUserReasonsList,
                                onChanged: (String? newValue) async {
                                  controller.updateReportReason(newValue);
                                },
                                placeholder: controller.selectedReason,
                                horizontalMargin: 0,
                                backColor: const Color(0xFF161616),
                              ),
                              14.verticalSpace,
                              AppInput(
                                label: 'Description',
                                placeHolder: 'Write Description',
                                horizontalMargin: 0,
                                maxLines: 5,
                                maxLenght: 250,
                                backColor: const Color(0xFF161616),
                                controller: controller.reportDescriptionController,
                                validator: (des) => appValidator(des!),
                              ),
                              14.verticalSpace,
                              SizedBox(
                                width: 1.sw,
                                height: 50,
                                child: AppButton(
                                  text: 'SUBMIT',
                                  horizontalMargin: 0,
                                  onPress: widget.onTap,
                                ),
                              ),
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
          ),
        );
      },
    );
  }
}
