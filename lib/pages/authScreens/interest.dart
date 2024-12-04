// ignore_for_file: use_build_context_synchronously, deprecated_member_use
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

class SelectInterestScreen extends StatefulWidget {
  const SelectInterestScreen({
    super.key,
    required this.isFromRelationshipGoals,
    required this.isFromEditProfile,
  });

  final bool isFromRelationshipGoals;
  final bool isFromEditProfile;

  @override
  State<SelectInterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<SelectInterestScreen> {
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        allowCustomOnBack: true,
        customOnBack: () async {
          if (widget.isFromEditProfile) {
            profileController.getInterestAgain(context: context);
            Get.back();
          } else {
            Get.back();
          }
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (widget.isFromEditProfile) {
            profileController.getInterestAgain(context: context);
          }
          return true;
        },
        child: GetBuilder<ProfileController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Form(
                key: profileController.interestFormKey,
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
                          'Interest',
                          style: interFont(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      32.verticalSpace,
                      Wrap(
                        children: List.generate(
                          controller.interestList.length,
                          (index) {
                            final List data = controller.interestList;
                            final List<String> selectedData = controller.selectedInterestList;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10, bottom: 20),
                              child: CustomChip(
                                onTap: () {
                                  controller.selectInterest(data[index]);
                                },
                                text: data[index],
                                fontSize: 11.0,
                                backgroundColor: selectedData.contains(data[index]) ? const Color(0xFFFF1472) : Colors.transparent,
                                borderColor: selectedData.contains(data[index]) ? Colors.transparent : Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      16.verticalSpace,
                      if (controller.selectedInterestList.contains('Other'))
                        AppInput(
                          label: 'Other',
                          placeHolder: 'Describe...',
                          horizontalMargin: 0,
                          maxLines: 5,
                          maxLenght: 50,
                          controller: controller.interestOtherController,
                          validator: (name) => appValidator(name!),
                        ),
                      22.verticalSpace,
                      AppButton(
                        text: widget.isFromRelationshipGoals || widget.isFromEditProfile ? 'UPDATE' : 'SAVE',
                        horizontalMargin: 0,
                        onPress: () {
                          controller.onCompleteProfile(
                            context: context,
                            isFromRelationshipGoals: widget.isFromRelationshipGoals,
                            isFromEditProfile: widget.isFromEditProfile,
                          );
                        },
                      ),
                      30.verticalSpace,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
