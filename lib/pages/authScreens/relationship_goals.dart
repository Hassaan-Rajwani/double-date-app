import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RelationshipGoalsScreen extends StatefulWidget {
  const RelationshipGoalsScreen({
    super.key,
    required this.isFromRelationshipGoals,
    required this.isFromEditProfile,
  });

  final bool isFromRelationshipGoals;
  final bool isFromEditProfile;

  @override
  State<RelationshipGoalsScreen> createState() => _IamAScreenState();
}

class _IamAScreenState extends State<RelationshipGoalsScreen> {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Relationship Goals',
                      style: interFont(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  32.verticalSpace,
                  Wrap(
                    children: List.generate(
                      controller.relationshipGoalsList.length,
                      (index) {
                        final List data = controller.relationshipGoalsList;
                        final List<String> selectedData = controller.selectedRelationshipGoalList;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 20),
                          child: CustomChip(
                            onTap: () {
                              controller.selectRelationshipGoals(data[index]);
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
                  22.verticalSpace,
                  AppButton(
                    text: 'NEXT',
                    horizontalMargin: 0,
                    onPress: () {
                      controller.onRelationshipGoals(
                        isFromRelationshipGoals: widget.isFromRelationshipGoals,
                        isFromEditProfile: widget.isFromEditProfile,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
