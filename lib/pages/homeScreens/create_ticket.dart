import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/controllers/support_controller.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final sc = Get.put(SupportController());
  final socket = Get.put(SocketController());

  @override
  void dispose() {
    sc.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Create Ticket'),
      body: GetBuilder<SupportController>(
        builder: (sc) {
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
              child: Form(
                key: sc.supportFormKey,
                child: Column(
                  children: [
                    14.verticalSpace,
                    AppInput(
                      label: 'Title',
                      placeHolder: 'Title of ticket',
                      horizontalMargin: 0,
                      controller: sc.titleController,
                      validator: (name) => supportTitleValidator(name!),
                    ),
                    AppInput(
                      label: 'Description',
                      placeHolder: 'Write Description',
                      horizontalMargin: 0,
                      maxLines: 6,
                      maxLenght: 200,
                      controller: sc.descriptionController,
                      validator: (name) => supportDesValidator(name!),
                    ),
                    10.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8, left: 10),
                          child: Text(
                            'Proof in image',
                            style: interFont(
                              color: const Color(0xFF93193A),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            sc.pickSupportImage();
                          },
                          child: Container(
                            width: 1.sw,
                            height: 104.h,
                            decoration: BoxDecoration(
                              border: modalBorder(width: 0.2),
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFA8A8A8).withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: sc.supportImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.file(
                                      sc.supportImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(uploadIcon),
                                      Text(
                                        'Upload Image',
                                        style: interFont(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                    32.verticalSpace,
                    AppButton(
                      text: 'SUBMIT TICKET',
                      horizontalMargin: 0,
                      onPress: () {
                        sc.onCreateTicket(context: context);
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
