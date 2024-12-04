import 'dart:io';
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

class IamAScreen extends StatefulWidget {
  const IamAScreen({
    super.key,
    required this.isFromRelationshipGoals,
    required this.isFromEditProfile,
  });

  final bool isFromRelationshipGoals;
  final bool isFromEditProfile;

  @override
  State<IamAScreen> createState() => _IamAScreenState();
}

class _IamAScreenState extends State<IamAScreen> {
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return Container(
            alignment: Alignment.center,
            height: 0.8.sh,
            padding: EdgeInsets.symmetric(
              horizontal: Platform.isAndroid ? 20 : 10,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(heartBg),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: profileController.iamFormKey,
                child: Column(
                  children: [
                    Text(
                      'I AM A',
                      style: interFont(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    32.verticalSpace,
                    Wrap(
                      children: List.generate(
                        controller.iAmAList.length,
                        (index) {
                          final List data = controller.iAmAList;
                          final String selectedData = controller.selectedIamAText;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10, bottom: 20),
                            child: CustomChip(
                              onTap: () {
                                controller.selectIamA(data[index]);
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
                    if (controller.selectedIamAText == 'Other')
                      AppInput(
                        label: 'Other',
                        placeHolder: 'Describe...',
                        horizontalMargin: 0,
                        maxLines: 5,
                        maxLenght: 50,
                        controller: controller.imAOtherController,
                        validator: (name) => appValidator(name!),
                      ),
                    22.verticalSpace,
                    AppButton(
                      text: 'NEXT',
                      horizontalMargin: 0,
                      onPress: () {
                        controller.onIamA(
                          isFromRelationshipGoals: widget.isFromRelationshipGoals,
                          isFromEditProfile: widget.isFromEditProfile,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
