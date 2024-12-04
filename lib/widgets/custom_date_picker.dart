import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return AppInput(
          controller: controller.dateController,
          label: 'Date of birth',
          inputWidth: 180,
          horizontalMargin: 0,
          placeHolder: controller.dateSet == true ? controller.myFormat.format(controller.dateOfBirth!).toString() : 'DD/MM/YYYY',
          onInputTap: () {
            controller.selectDate(context);
          },
          validator: (date) => dateValidator(date!),
          readOnly: true,
          postfixIcon: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SvgPicture.asset(calenderIcon),
          ),
        );
      },
    );
  }
}
