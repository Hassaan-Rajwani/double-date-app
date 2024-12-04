import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/utils/enums.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/Phone%20Field/intl_phone_field.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddPartnerDialog extends StatefulWidget {
  const AddPartnerDialog({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<AddPartnerDialog> createState() => _AddPartnerDialogState();
}

class _AddPartnerDialogState extends State<AddPartnerDialog> {
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.addPartnerDialogFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Add Partner',
                              style: interFont(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            8.verticalSpace,
                            Text(
                              'Enter details to add Partner',
                              style: interFont(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            14.verticalSpace,
                            if (controller.fieldTypePartnerModal == FieldTypeInPartnerModal.Email.name)
                              AppInput(
                                label: 'Email',
                                placeHolder: 'Enter your partner email address',
                                horizontalMargin: 0,
                                controller: controller.addFriendEmailController,
                                validator: (email) => emailValidator(email!),
                              )
                            else if (controller.fieldTypePartnerModal == FieldTypeInPartnerModal.Phone.name)
                              IntlPhoneField(
                                validator: (val) => phoneValidator(val!.number),
                                controller: controller.partnerPhoneController,
                                style: interFont(),
                                cursorColor: Colors.white,
                                showCountryFlag: false,
                                languageCode: "en",
                                initialCountryCode: controller.initialPartnerPhoneNumber.isoCode,
                                onChanged: (phone) {
                                  controller.partnerCountryCodeController.text = phone.countryISOCode;
                                },
                              )
                            else
                              AppInput(
                                label: 'Code',
                                placeHolder: 'Enter your code',
                                horizontalMargin: 0,
                                controller: controller.addFriendCodeController,
                                validator: (code) => codeValidator(code!),
                                maxLenght: 4,
                                keyboardType: TextInputType.number,
                              ),
                            10.verticalSpace,
                            SizedBox(
                              width: 1.sw,
                              height: 50,
                              child: AppButton(
                                text: 'ADD',
                                horizontalMargin: 0,
                                onPress: widget.onTap,
                              ),
                            ),
                            24.verticalSpace,
                            SizedBox(
                              width: 1.sw,
                              height: 50,
                              child: AppButton(
                                text: controller.fieldTypePartnerModal == FieldTypeInPartnerModal.Email.name ? 'USE NUMBER' : 'USE EMAIL',
                                horizontalMargin: 0,
                                onPress: () {
                                  controller.changePartnerModalFieldValue(
                                    value: controller.fieldTypePartnerModal == FieldTypeInPartnerModal.Email.name
                                        ? FieldTypeInPartnerModal.Phone.name
                                        : FieldTypeInPartnerModal.Email.name,
                                  );
                                },
                                backgroundColor: Colors.transparent,
                                isGradinet: false,
                                borderColor: const Color(0xFFFF1472),
                                textColor: Colors.white,
                              ),
                            ),
                            24.verticalSpace,
                            SizedBox(
                              width: 1.sw,
                              height: 50,
                              child: AppButton(
                                text: 'ADD VIA CODE',
                                horizontalMargin: 0,
                                onPress: () {
                                  controller.changePartnerModalFieldValue(
                                    value: FieldTypeInPartnerModal.Code.name,
                                  );
                                },
                                backgroundColor: Colors.transparent,
                                isGradinet: false,
                                borderColor: const Color(0xFFFF1472),
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.close(1);
                            controller.changePartnerModalFieldValue(value: FieldTypeInPartnerModal.Phone.name);
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
        );
      },
    );
  }
}
