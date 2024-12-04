import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutYourSeleftScreen extends StatefulWidget {
  const AboutYourSeleftScreen({
    super.key,
    required this.isFromRelationshipGoals,
    required this.isFromEditProfile,
  });

  final bool isFromRelationshipGoals;
  final bool isFromEditProfile;

  @override
  State<AboutYourSeleftScreen> createState() => _AboutYourSeleftScreenState();
}

class _AboutYourSeleftScreenState extends State<AboutYourSeleftScreen> {
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(),
      body: GetBuilder<ProfileController>(
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
              child: SingleChildScrollView(
                child: Form(
                  key: controller.aboutYorselfFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          widget.isFromRelationshipGoals ? 'Relationship Goals' : 'About Yourself',
                          style: interFont(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      32.verticalSpace,
                      AppInput(
                        label: 'Description',
                        placeHolder: 'Describe yourself...',
                        horizontalMargin: 0,
                        maxLines: 5,
                        maxLenght: 250,
                        controller: controller.aboutYourselfDescriptionController,
                        validator: (name) => appValidator(name!),
                      ),
                      AppInput(
                        label: 'Height',
                        placeHolder: 'Enter Height In Cm',
                        horizontalMargin: 0,
                        inputWidth: 172,
                        keyboardType: TextInputType.number,
                        controller: controller.aboutYourselfHeightController,
                        validator: (name) => heightValidator(name!),
                      ),
                      14.verticalSpace,
                      Text(
                        'Sexual Orientation',
                        style: interFont(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        'Select your sexual orientation',
                        style: interFont(
                          fontSize: 12.8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      24.verticalSpace,
                      Wrap(
                        children: List.generate(
                          controller.sexualOrientationList.length,
                          (index) {
                            final List data = controller.sexualOrientationList;
                            final String selectedData = controller.selectedOrientationText;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8, bottom: 20),
                              child: CustomChip(
                                onTap: () {
                                  controller.selectOrientation(data[index]);
                                },
                                text: data[index],
                                fontSize: 11.0,
                                backgroundColor: selectedData == data[index] ? const Color(0xFFFF1472) : Colors.transparent,
                                borderColor: selectedData == data[index] ? Colors.transparent : Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      16.verticalSpace,
                      if (controller.selectedOrientationText == 'Other')
                        AppInput(
                          label: 'Other',
                          placeHolder: 'Describe...',
                          horizontalMargin: 0,
                          maxLines: 5,
                          maxLenght: 50,
                          controller: controller.aboutYourselfOtherController,
                          validator: (name) => appValidator(name!),
                        ),
                      22.verticalSpace,
                      AppButton(
                        text: 'NEXT',
                        horizontalMargin: 0,
                        onPress: () {
                          controller.onAboutYourself(
                            isFromRelationshipGoals: widget.isFromRelationshipGoals,
                            isFromEditProfile: widget.isFromEditProfile,
                          );
                        },
                      ),
                      22.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
