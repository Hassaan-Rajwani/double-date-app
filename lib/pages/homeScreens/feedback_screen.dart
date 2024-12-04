import 'package:double_date/controllers/support_controller.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final sc = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Feedback'),
      body: GetBuilder<SupportController>(
        builder: (sc) {
          return SingleChildScrollView(
            child: Container(
              height: 0.8.sh,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: sc.feedbackFormKey,
                child: Column(
                  children: [
                    14.verticalSpace,
                    AppInput(
                      label: 'Feedback Description',
                      placeHolder: 'Write Description',
                      maxLines: 6,
                      maxLenght: 200,
                      horizontalMargin: 0,
                      backColor: Colors.transparent,
                      validator: (name) => feedbackDesValidator(name!),
                      controller: sc.feedBackController,
                    ),
                    22.verticalSpace,
                    AppButton(
                      text: 'SUBMIT FEEDBACK',
                      horizontalMargin: 0,
                      onPress: () async {
                        await sc.onSendFeedback(context: context);
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
