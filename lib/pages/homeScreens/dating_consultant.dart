import 'package:double_date/controllers/date_consultant_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/pages/homeScreens/dating_chat.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/accordion.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DatingConsultant extends StatefulWidget {
  const DatingConsultant({super.key});

  @override
  State<DatingConsultant> createState() => _DatingConsultantState();
}

class _DatingConsultantState extends State<DatingConsultant> {
  final dcc = Get.put(DatingConsultantController());
  final sc = Get.put(SocketController());

  @override
  void initState() {
    dcc.getQuestions(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatingConsultantController>(
      builder: (dcc) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: backButtonAppbar(title: 'Dating Consultant'),
          body: SingleChildScrollView(
            child: Container(
              height: 1.sh,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  20.verticalSpace,
                  SizedBox(
                    height: 0.75.sh,
                    child: dcc.loader
                        ? Container(
                            alignment: Alignment.center,
                            height: 0.75.sh,
                            child: spinkit,
                          )
                        : dcc.questionList.isEmpty
                            ? Container(
                                alignment: Alignment.center,
                                height: 0.75.sh,
                                child: Text(
                                  'No Questions Available',
                                  style: interFont(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: dcc.questionList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final data = dcc.questionList[index];
                                  return Accordion(
                                    text1: data.question!,
                                    text2: data.answer!,
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: AppButton(
              text: 'INITIATE THIS CHAT',
              horizontalMargin: 0,
              onPress: () {
                sc.emitConsultantMessageList();
                Get.to(() => const DatingChat());
              },
            ),
          ),
        );
      },
    );
  }
}
