// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:double_date/controllers/auth_controller.dart';
import 'package:double_date/controllers/bottom_nav_controller.dart';
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/location_controller.dart';
import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/controllers/permission_controller.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/models/user_model.dart';
import 'package:double_date/pages/authScreens/about_yourself.dart';
import 'package:double_date/pages/authScreens/add_friends.dart';
import 'package:double_date/pages/authScreens/iam_a.dart';
import 'package:double_date/pages/authScreens/interest.dart';
import 'package:double_date/pages/authScreens/login.dart';
import 'package:double_date/pages/authScreens/relationship_goals.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/pages/homeScreens/edit_short_videos.dart';
import 'package:double_date/repositories/auth_repository.dart';
import 'package:double_date/repositories/profile_repository.dart';
import 'package:double_date/repositories/short_repository.dart';
import 'package:double_date/utils/enums.dart';
import 'package:double_date/utils/storage.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:double_date/widgets/double_button_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  TextEditingController stateController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController partnerPhoneController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController partnerCountryCodeController = TextEditingController();
  TextEditingController addFriendPhoneController = TextEditingController();
  TextEditingController addFriendEmailController = TextEditingController();
  TextEditingController addFriendCodeController = TextEditingController();
  TextEditingController aboutYourselfDescriptionController = TextEditingController();
  TextEditingController aboutYourselfHeightController = TextEditingController();
  TextEditingController aboutYourselfOtherController = TextEditingController();
  TextEditingController interestOtherController = TextEditingController();
  TextEditingController imAOtherController = TextEditingController();
  TextEditingController shortTitleController = TextEditingController();
  PhoneNumber initialPhoneNumber = PhoneNumber(isoCode: 'US');
  PhoneNumber initialPartnerPhoneNumber = PhoneNumber(isoCode: 'US');
  String fieldTypePartnerModal = FieldTypeInPartnerModal.Phone.name;
  DateTime? dateOfBirth;
  bool dateSet = false;
  DateFormat myFormat = DateFormat('MM/dd/yyyy');
  List<String> gender = ["Male", "Female"];
  String genderValue = "Select Gender";
  File? profileImage;
  File? shortVideo;
  final ImagePicker picker = ImagePicker();
  bool premiumPurchased = false;
  String? profilePhoneErrorMessage;
  String? addPartnerPhoneErrorMessage;
  final createProfileFormKey = GlobalKey<FormState>();
  final aboutYorselfFormKey = GlobalKey<FormState>();
  final iamFormKey = GlobalKey<FormState>();
  final interestFormKey = GlobalKey<FormState>();
  final addPartnerDialogFormKey = GlobalKey<FormState>();
  final addShortFormKey = GlobalKey<FormState>();
  late ScrollController shortsScrollController;

  List sexualOrientationList = [];
  List iAmAList = [];
  List relationshipGoalsList = [];
  List interestList = [];
  String selectedIamAText = '';
  List<String> selectedRelationshipGoalList = [];
  String selectedOrientationText = '';
  List<String> selectedInterestList = [];
  late Shorts currentIndexData;

  void updateCurrentVideo(Shorts newVideo) {
    currentIndexData = newVideo;
    update();
  }

  animateLeftOrRight({required bool isRight}) {
    shortsScrollController.animateTo(
      isRight ? shortsScrollController.offset + 100 : shortsScrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  saveUserDetails(UserModel data) {
    user.value = data;
    showDetailsInEditProfile();
    update();
  }

  showDetailsInEditProfile() {
    fullNameController.text = user.value.name!;
    dateController.text = user.value.dateofbirth!;
    genderValue = user.value.gender!;
    addressController.text = user.value.location!.address!;
    // stateController.text = user.value.state!;
    // cityController.text = user.value.city!;
    aboutYourselfDescriptionController.text = user.value.aboutYourself!.description!;
    aboutYourselfHeightController.text = '${user.value.aboutYourself!.height}';
    selectedOrientationText = user.value.aboutYourself!.sexualOrientation! == '' ? 'Other' : user.value.aboutYourself!.sexualOrientation!;
    aboutYourselfOtherController.text = user.value.aboutYourself!.otherSexualOrientation!;
    selectedIamAText = user.value.seekingFor == '' ? 'Other' : user.value.seekingFor!;
    imAOtherController.text = user.value.otherSeekingFor!;
    selectedRelationshipGoalList = user.value.relationshipGoals!;
    phoneController.text = user.value.phone!;
    initialPhoneNumber = PhoneNumber(isoCode: user.value.countryCode != null && user.value.countryCode != '' ? user.value.countryCode : 'US');
    interestOtherController.text = user.value.otherInterest!;
    selectedInterestList = user.value.interest!;
  }

  clearDetails() {
    profileImage = null;
    fullNameController.clear();
    dateController.clear();
    genderValue = 'Select Gender';
    phoneController.clear();
    countryCodeController.clear();
    addressController.clear();
    stateController.clear();
    cityController.clear();
    aboutYourselfDescriptionController.clear();
    aboutYourselfHeightController.clear();
    selectedOrientationText = '';
    aboutYourselfOtherController.clear();
    selectedIamAText = '';
    imAOtherController.clear();
    selectedRelationshipGoalList.clear();
    selectedInterestList.clear();
    interestOtherController.clear();
    user.value = UserModel();
    addressController.clear();
    update();
  }

  selectOrientation(value) {
    selectedOrientationText = value;
    update();
  }

  selectIamA(value) {
    selectedIamAText = value;
    update();
  }

  selectRelationshipGoals(value) {
    if (selectedRelationshipGoalList.contains(value)) {
      selectedRelationshipGoalList.remove(value);
    } else {
      selectedRelationshipGoalList.add(value);
    }
    update();
  }

  selectInterest(String value) {
    if (value == "Other") {
      selectedInterestList.clear();
      selectedInterestList.add(value);
    } else {
      if (selectedInterestList.contains("Other")) {
        selectedInterestList.remove("Other");
      }
      if (selectedInterestList.contains(value)) {
        selectedInterestList.remove(value);
      } else {
        selectedInterestList.add(value);
      }
    }
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth,
      firstDate: DateTime(1950, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dateOfBirth) {
      dateController.text = picked.toString().substring(0, 10);
      dateSet = true;
      dateOfBirth = picked;
      update();
    }
    update();
  }

  updateGender(value) {
    genderValue = value;
    update();
  }

  changePartnerModalFieldValue({required String value}) {
    fieldTypePartnerModal = value;
    update();
  }

  pickProfileImage({
    bool oepnCamera = false,
  }) async {
    final p = Get.put(PermissionController());
    final status = await p.requestMediaPermission(oepnCamera: oepnCamera);
    if (status) {
      final XFile? file = await picker.pickImage(
        source: oepnCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (file != null) {
        profileImage = File(file.path);
        update();
      }
    }
  }

  pickVideo({bool oepnCamera = false}) async {
    final XFile? file = await picker.pickVideo(
      source: oepnCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (file != null) {
      shortVideo = File(file.path);
      update();
      Get.to(
        () => const EditVideosScreen(isEdit: false),
      );
    }
  }

  enablePremium() {
    premiumPurchased = true;
    update();
  }

  onCreateProfile({
    required bool isFromEditProfile,
    required bool isFromRelationshipGoals,
  }) {
    if (createProfileFormKey.currentState != null && createProfileFormKey.currentState!.validate()) {
      if (isFromEditProfile) {
        Get.to(
          () => AboutYourSeleftScreen(
            isFromRelationshipGoals: isFromRelationshipGoals,
            isFromEditProfile: isFromEditProfile,
          ),
        );
      } else {
        if (profileImage != null) {
          Get.to(
            () => AboutYourSeleftScreen(
              isFromRelationshipGoals: isFromRelationshipGoals,
              isFromEditProfile: isFromEditProfile,
            ),
          );
        } else {
          Get.snackbar(
            'Required',
            'Please select profile image',
            backgroundColor: Colors.white,
          );
        }
      }
    }
  }

  onAboutYourself({
    required bool isFromRelationshipGoals,
    required bool isFromEditProfile,
  }) {
    if (aboutYorselfFormKey.currentState != null && aboutYorselfFormKey.currentState!.validate()) {
      if (selectedOrientationText == '') {
        Get.snackbar(
          'Required',
          'Please select sexual orientation',
          backgroundColor: Colors.white,
        );
      } else {
        Get.to(
          () => IamAScreen(
            isFromRelationshipGoals: isFromRelationshipGoals,
            isFromEditProfile: isFromEditProfile,
          ),
        );
      }
    }
  }

  onIamA({
    required bool isFromRelationshipGoals,
    required bool isFromEditProfile,
  }) {
    if (iamFormKey.currentState != null && iamFormKey.currentState!.validate()) {
      if (selectedIamAText == '') {
        Get.snackbar(
          'Required',
          'Please select iam seeking for',
          backgroundColor: Colors.white,
        );
      } else {
        Get.to(
          () => RelationshipGoalsScreen(
            isFromRelationshipGoals: isFromRelationshipGoals,
            isFromEditProfile: isFromEditProfile,
          ),
        );
      }
    }
  }

  onRelationshipGoals({
    required bool isFromRelationshipGoals,
    required bool isFromEditProfile,
  }) {
    if (selectedRelationshipGoalList.isEmpty) {
      Get.snackbar(
        'Required',
        'Please select relationship goals',
        backgroundColor: Colors.white,
      );
    } else {
      Get.to(
        () => SelectInterestScreen(
          isFromRelationshipGoals: isFromRelationshipGoals,
          isFromEditProfile: isFromEditProfile,
        ),
      );
    }
  }

  onCompleteProfile({
    required BuildContext context,
    required bool isFromRelationshipGoals,
    required bool isFromEditProfile,
  }) async {
    final fc = Get.put(FeedController());
    final lc = Get.put(LocationController());
    final body = {
      'name': fullNameController.value.text,
      'gender': genderValue,
      'dateofbirth': dateController.value.text,
      'phone': phoneController.value.text,
      'countryCode': countryCodeController.value.text == '' ? user.value.countryCode.toString() : countryCodeController.value.text,
      'location[address]': addressController.value.text,
      'city': cityController.value.text,
      'state': stateController.value.text,
      'seekingFor': selectedIamAText == 'Other' ? '' : selectedIamAText,
      'aboutYourself[description]': aboutYourselfDescriptionController.value.text,
      'aboutYourself[height]': aboutYourselfHeightController.value.text,
      'location[type]': 'Point',
      'location[coordinates][0]': '${lc.longitude.value}',
      'location[coordinates][1]': '${lc.latitude.value}',
      'aboutYourself[sexualOrientation]': selectedOrientationText == 'Other' ? '' : selectedOrientationText,
      'otherInterest': selectedInterestList.contains('Other') ? interestOtherController.value.text : '',
      'aboutYourself[otherSexualOrientation]': selectedOrientationText == 'Other' ? aboutYourselfOtherController.value.text : '',
      'otherSeekingFor': selectedIamAText == 'Other' ? imAOtherController.value.text : '',
    };

    for (var i = 0; i < selectedInterestList.length; i++) {
      body["interest[$i]"] = selectedInterestList[i];
      update();
    }

    for (var i = 0; i < selectedRelationshipGoalList.length; i++) {
      body["relationshipGoals[$i]"] = selectedRelationshipGoalList[i];
      update();
    }

    if (interestFormKey.currentState != null && interestFormKey.currentState!.validate()) {
      if (selectedInterestList.isNotEmpty) {
        final res = await ProfileRepository().createProfile(
          context: context,
          body: body,
          file: profileImage,
          isFromEditProfile: isFromEditProfile || isFromRelationshipGoals,
          fileKey: 'profilePicture',
        );
        if (res != null && res['data'] != null) {
          saveUserDetails(
            UserModel.fromJson(
              res['data']['user'],
            ),
          );
          fc.editfeedData = res['data']['user']['posts'];
          if (isFromRelationshipGoals) {
            Get.offAll(() => const Dashboard());
          } else if (isFromEditProfile) {
            Get.close(5);
          } else {
            await setDataToStorage(StorageKeys.isLogin, 'true');
            Get.to(
              () => const AddFriendsScreen(
                isFromHome: false,
              ),
            );
          }
        }
      } else {
        Get.snackbar(
          'Required',
          'Please select interest',
          backgroundColor: Colors.white,
        );
      }
    }
  }

  getItems({required BuildContext context}) async {
    final res = await ProfileRepository().getItems(context: context);
    if (res['data'] != null) {
      sexualOrientationList = res['data']['sexualOrientationList'];
      iAmAList = res['data']['iAmAList'];
      relationshipGoalsList = res['data']['relationshipGoalsList'];
      interestList = res['data']['interestList'];
      update();
    }
  }

  getInterestAgain({required BuildContext context}) async {
    interestList.clear();
    final res = await ProfileRepository().getItems(context: context);
    if (res['data'] != null) {
      interestList = res['data']['interestList'];
    }
    final res2 = await AuthRepository().autoLogin(context: context, showLoader: false);
    if (res2['data'] != null) {
      saveUserDetails(
        UserModel.fromJson(
          res2['data']['user'],
        ),
      );
      if (user.value.interest!.isNotEmpty) {
        selectedInterestList = user.value.interest!;
      }
    }
    update();
  }

  onRemovePartner({required BuildContext context}) async {
    final mc = Get.put(MatchedController());
    final pc = Get.put(ProfileController());
    mc.hideOtherOption();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DoubleButtonDialog(
          onNo: () {
            Get.close(1);
          },
          onYes: () async {
            final res = await ProfileRepository().removePartner(context: context);
            if (res != null) {
              Get.back();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return BasicDialog(
                    heading: 'Partner Removed',
                    bodyText: 'Your partner has been Removed.',
                    onTap: () async {
                      Get.close(2);
                      final res2 = await AuthRepository().autoLogin(
                        context: context,
                        showLoader: true,
                      );
                      pc.saveUserDetails(
                        UserModel.fromJson(
                          res2['data']['user'],
                        ),
                      );
                      await mc.getMatchesList(context: context);
                    },
                  );
                },
              );
            }
          },
          heading: 'Remove Partner',
          bodyText: 'are you sure you want to\nremove your partner?',
        );
      },
    );
  }

  pairPartner({required BuildContext context}) async {
    final body = {'code': addFriendCodeController.text};
    final res = await ProfileRepository().pairPartner(context: context, body: body);
    if (res != null && res['data'] != null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return BasicDialog(
            heading: 'Partner Added',
            bodyText: 'You have successfully added partner.',
            onTap: () async {
              Get.close(2);
              addFriendCodeController.clear();
              final res2 = await AuthRepository().autoLogin(
                context: context,
                showLoader: false,
              );
              saveUserDetails(
                UserModel.fromJson(
                  res2['data']['user'],
                ),
              );
            },
          );
        },
      );
    } else {
      addFriendCodeController.clear();
      update();
    }
  }

  onAddPartnerRequest({required BuildContext context}) async {
    final body = {'email': addFriendEmailController.value.text};
    if (addPartnerDialogFormKey.currentState != null && addPartnerDialogFormKey.currentState!.validate()) {
      final res = await ProfileRepository().addPartnerRequest(context: context, body: body);
      if (res != null && res['data'] != null) {
        update();
        Get.close(1);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return BasicDialog(
              heading: 'Invite Successful',
              bodyText: 'Your invite has been sent\nsuccessfully.',
              onTap: () {
                Get.close(1);
                fieldTypePartnerModal = FieldTypeInPartnerModal.Phone.name;
                addFriendEmailController.clear();
                partnerPhoneController.clear();
                partnerCountryCodeController.clear();
                addFriendCodeController.clear();
                initialPartnerPhoneNumber = PhoneNumber(isoCode: 'US');
                update();
              },
            );
          },
        );
      }
    }
  }

  onCreateShort({
    required BuildContext context,
    required bool isFromEdit,
    String? shortId,
  }) async {
    final body = {
      'title': shortTitleController.value.text,
    };
    if (addShortFormKey.currentState != null && addShortFormKey.currentState!.validate()) {
      final res = isFromEdit
          ? await ShortRepository().updateShort(
              context: context,
              body: body,
              shortId: shortId!,
            )
          : await ShortRepository().createShort(
              context: context,
              body: body,
              file: shortVideo,
            );
      if (res != null && res['data'] != null) {
        shortTitleController.clear();
        update();
        Get.close(isFromEdit ? 2 : 1);
        final res2 = await AuthRepository().autoLogin(
          context: context,
          showLoader: true,
        );
        if (res2 != null && res2['data'] != null) {
          saveUserDetails(
            UserModel.fromJson(
              res2['data']['user'],
            ),
          );
        }
      }
      Get.snackbar(
        'Success',
        res['message'],
        backgroundColor: Colors.white,
      );
    }
  }

  onDeleteShort({
    required BuildContext context,
    required String shortId,
  }) async {
    final body = {
      'shortId': shortId,
    };
    if (addShortFormKey.currentState != null && addShortFormKey.currentState!.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DoubleButtonDialog(
            onYes: () async {
              final res = await ShortRepository().deleteShort(context: context, body: body);
              if (res != null && res['data'] != null) {
                Get.back();
                final res2 = await AuthRepository().autoLogin(
                  context: context,
                  showLoader: true,
                );
                if (res2 != null && res2['data'] != null) {
                  shortTitleController.clear();
                  update();
                  saveUserDetails(
                    UserModel.fromJson(
                      res2['data']['user'],
                    ),
                  );
                  Get.close(2);
                }
              }
            },
            onNo: () {
              Get.close(1);
            },
            heading: 'Delete Short Video',
            bodyText: 'Are you sure you want to\ndelete short video?',
          );
        },
      );
    }
  }

  socialLogout() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      throw e.toString();
    }
  }

  onLogout({required BuildContext context}) async {
    final bc = Get.put(BottomNavController());
    final body = {'deviceToken': 'abc'};
    final ac = Get.put(AuthController());
    final sc = Get.put(SocketController());
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DoubleButtonDialog(
          onYes: () async {
            sc.disposeSoceket();
            await AuthRepository().logout(context: context, body: body);
            await Future.wait([
              deleteDataFromStorage(StorageKeys.token),
              deleteDataFromStorage(StorageKeys.isLogin),
            ]);
            ac.clearAuthInput(isChecked: ac.isChecked);
            clearDetails();
            await socialLogout();
            Get.snackbar(
              'Success',
              'Logout Successfully',
              backgroundColor: Colors.white,
            );
            bc.navBarChange(0);
            Get.offAll(() => const LoginScreen());
          },
          onNo: () {
            Get.back();
          },
          heading: 'Logout',
          bodyText: 'Are you sure you want\nto logout?',
        );
      },
    );
  }
}
