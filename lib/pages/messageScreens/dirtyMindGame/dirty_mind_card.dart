// ignore_for_file: deprecated_member_use
import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DirtyMindCard extends StatefulWidget {
  const DirtyMindCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.questionLength,
    required this.showAnswer,
  });

  final String question;
  final String questionNumber;
  final int questionLength;
  final bool showAnswer;

  @override
  State<DirtyMindCard> createState() => DirtyMindCardState();
}

class DirtyMindCardState extends State<DirtyMindCard> {
  final gameController = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 540,
              padding: const EdgeInsets.all(24),
              width: 0.7.sw,
              decoration: BoxDecoration(
                border: modalBorder(width: 0.2),
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFA8A8A8).withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            Container(
              height: 515,
              padding: const EdgeInsets.all(24),
              width: 0.75.sw,
              decoration: BoxDecoration(
                border: modalBorder(width: 0.2),
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFA8A8A8).withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            Container(
              height: 485,
              padding: const EdgeInsets.all(24),
              width: 0.8.sw,
              decoration: BoxDecoration(
                border: modalBorder(width: 0.2),
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFA8A8A8).withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Question ${widget.questionNumber}',
                    style: interFont(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB1124C),
                    ),
                  ),
                  30.verticalSpace,
                  Text(
                    widget.question,
                    style: interFont(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  60.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${widget.questionLength} answers',
                      style: interFont(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (controller.dirtyMindsQuestions[controller.dirtyMindCurrentIndex].response.toString().trim().toLowerCase() ==
                      controller.dirtyMindsQuestions[controller.dirtyMindCurrentIndex].answer.toString().trim().toLowerCase())
                    Column(
                      children: [
                        125.verticalSpace,
                        AppButton(
                          text: controller.dirtyMindsQuestions[controller.dirtyMindCurrentIndex].answer!,
                          horizontalMargin: 0,
                          verticalMargin: 0,
                          borderRadius: 10,
                          showIcon: true,
                          icon: SvgPicture.asset(
                            width: 25,
                            tick3Icon,
                          ),
                        ),
                      ],
                    )
                  else if (widget.showAnswer)
                    Column(
                      children: [
                        80.verticalSpace,
                        AppButton(
                          text: controller.dirtyMindsQuestions[controller.dirtyMindCurrentIndex].response!,
                          horizontalMargin: 0,
                          verticalMargin: 15,
                          borderRadius: 10,
                          isGradinet: false,
                          borderColor: Colors.red,
                          backgroundColor: Colors.transparent,
                          showIcon: true,
                          icon: SvgPicture.asset(
                            crossIcon,
                            width: 25,
                            color: Colors.red,
                          ),
                          textColor: Colors.red,
                        ),
                        16.verticalSpace,
                        AppButton(
                          text: controller.dirtyMindsQuestions[controller.dirtyMindCurrentIndex].answer!,
                          horizontalMargin: 0,
                          verticalMargin: 0,
                          borderRadius: 10,
                          showIcon: true,
                          icon: SvgPicture.asset(
                            width: 25,
                            tick3Icon,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        125.verticalSpace,
                        AppInput(
                          placeHolder: 'Answer',
                          horizontalMargin: 0,
                          verticalPadding: 0,
                          bottomMargin: 0,
                          controller: controller.dirtyMindInputController,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
