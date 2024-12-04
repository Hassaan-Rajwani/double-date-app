import 'package:double_date/controllers/location_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/authScreens/add_partner_dialog.dart';
import 'package:double_date/utils/enums.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/Phone%20Field/intl_phone_field.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_dropdown.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({
    super.key,
    required this.isFromEditProfile,
    required this.isFromRelationshipGoals,
  });

  final bool isFromEditProfile;
  final bool isFromRelationshipGoals;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final profileController = Get.put(ProfileController());
  final lc = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(),
      body: GetBuilder<LocationController>(
        builder: (lcController) {
          return GetBuilder<ProfileController>(
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
                  child: Form(
                    key: controller.createProfileFormKey,
                    child: Column(
                      children: [
                        Text(
                          widget.isFromEditProfile ? 'Edit Profile' : 'Create Profile',
                          style: interFont(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        24.verticalSpace,
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.pickProfileImage();
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Colors.pink,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.pink.withOpacity(0.4),
                                      spreadRadius: 20,
                                      blurRadius: 100,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: controller.profileImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(100.r),
                                        child: Image.file(
                                          controller.profileImage!,
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : controller.user.value.profilePicture != null
                                        ? LoaderImage(
                                            url: controller.user.value.profilePicture!,
                                            width: 150,
                                            height: 150,
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(100.r),
                                            child: Image.asset(
                                              avatar,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  controller.pickProfileImage(oepnCamera: true);
                                },
                                child: SvgPicture.asset(cameraIcon),
                              ),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        AppInput(
                          placeHolder: 'Enter your full name',
                          label: 'Full Name',
                          horizontalMargin: 0,
                          controller: controller.fullNameController,
                          validator: (name) => nameValidator(name!),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 2),
                                child: AppInput(
                                  controller: controller.dateController,
                                  label: 'Date of birth',
                                  inputWidth: 180,
                                  horizontalMargin: 0,
                                  placeHolder: 'DD/MM/YYYY',
                                  onInputTap: () {
                                    controller.selectDate(context);
                                  },
                                  validator: (date) => dateValidator(date),
                                  readOnly: true,
                                  postfixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: SvgPicture.asset(calenderIcon),
                                  ),
                                ),
                              ),
                            ),
                            8.horizontalSpace,
                            Expanded(
                              child: AppDropDown(
                                label: 'Gender',
                                placeholder: controller.genderValue,
                                list: controller.gender,
                                onChanged: (String? newValue) {
                                  controller.updateGender(newValue);
                                },
                                horizontalMargin: 0,
                                validator: (val) => genderValidator(controller.genderValue),
                              ),
                            ),
                          ],
                        ),
                        IntlPhoneField(
                          validator: (val) => phoneValidator(val!.number),
                          controller: controller.phoneController,
                          style: interFont(),
                          cursorColor: Colors.white,
                          showCountryFlag: false,
                          languageCode: "en",
                          initialCountryCode: controller.initialPhoneNumber.isoCode,
                          onChanged: (phone) {
                            controller.countryCodeController.text = phone.countryISOCode;
                          },
                        ),
                        AppInput(
                          placeHolder: 'Address',
                          label: 'Address',
                          controller: controller.addressController,
                          validator: (country) => countryValidator(country!),
                          horizontalMargin: 0,
                          postfixIcon: GestureDetector(
                            onTap: () async {
                              controller.addressController.text = await lcController.getAddressFromLatLng(
                                lcController.latitude.value,
                                lcController.longitude.value,
                              );
                            },
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (!widget.isFromEditProfile)
                          AppButton(
                            text: 'Add Partner',
                            horizontalMargin: 0,
                            backgroundColor: Colors.transparent,
                            isGradinet: false,
                            borderColor: const Color(0xFFFF1472),
                            onPress: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AddPartnerDialog(
                                    onTap: () async {
                                      if (controller.fieldTypePartnerModal == FieldTypeInPartnerModal.Code.name) {
                                        await controller.pairPartner(context: context);
                                      } else {
                                        await controller.onAddPartnerRequest(context: context);
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        30.verticalSpace,
                        AppButton(
                          text: 'NEXT',
                          horizontalMargin: 0,
                          onPress: () {
                            controller.onCreateProfile(
                              isFromEditProfile: widget.isFromEditProfile,
                              isFromRelationshipGoals: widget.isFromRelationshipGoals,
                            );
                          },
                        ),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
