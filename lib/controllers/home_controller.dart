// ignore_for_file: use_build_context_synchronously
import 'package:double_date/models/app_user_contact_model.dart';
import 'package:double_date/models/home_model.dart';
import 'package:double_date/models/other_contacts_model.dart';
import 'package:double_date/repositories/home_repository.dart';
import 'package:double_date/utils/enums.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/Card%20Swiper/enums.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:double_date/widgets/permission_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  bool homeLoader = false;
  List<HomeModel> homeData = [];
  List<HomeModel> filterData = [];
  List<AppUserContactModel> appUserContacts = [];
  List<AppUserContactModel> appUserFilterContacts = [];
  List<OtherContactsModel> otherContacts = [];
  List<OtherContactsModel> otherFilterContacts = [];
  List<String> sexualOrientationListForFilter = ["Straight", "Bisexual", "Gay", "Lesbian", "Transgender", "Other"];
  List<String> relationShipStatusListForFilter = ['Single', 'Married'];
  String sexualOrientationValue = 'Sexual Orientation';
  String relationshipStatusValue = 'Relationship Status';
  TextEditingController locationController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  double sliderValue = 20;
  final cardWidth = Get.width * 0.75;
  bool showCross = false;
  bool contactLoader = false;
  bool showFilterCross = false;

  changeContactLoader(val) {
    contactLoader = val;
    update();
  }

  updateCross(val, context, {bool clearSearchBar = false}) {
    showCross = val;
    if (clearSearchBar) {
      searchController.clear();
      keyboardDismissle(context);
    }
    filterData.clear();
    update();
  }

  updateFilterCross(val, context, {bool clearData = false}) {
    showFilterCross = val;
    if (clearData) {
      locationController.clear();
      sliderValue = 20;
      sexualOrientationValue = 'Sexual Orientation';
      relationshipStatusValue = 'Relationship Status';
    }
    update();
  }

  saveHomeData(List<HomeModel> data) {
    homeData.clear();
    homeData = data;
    update();
  }

  saveContactData({
    required List<AppUserContactModel> appUserData,
    required List<OtherContactsModel> otherData,
  }) {
    appUserContacts.clear();
    otherContacts.clear();
    appUserContacts = appUserData;
    appUserFilterContacts = appUserData;
    otherContacts = otherData;
    otherFilterContacts = otherData;
    update();
  }

  saveFilterData(List<HomeModel> data) {
    filterData.clear();
    filterData = data;
    update();
  }

  updateSexualOrientation(value) {
    sexualOrientationValue = value;
    update();
  }

  updateRelationshipStatus(value) {
    relationshipStatusValue = value;
    update();
  }

  updateSliderValue(value) {
    sliderValue = value;
    update();
  }

  changeLoaderValue(value) {
    homeLoader = value;
    update();
  }

  getHomeMatches({required BuildContext context}) async {
    changeLoaderValue(true);
    final res = await HomeRepository().homeMatches(context: context);
    if (res['data'] != null) {
      changeLoaderValue(false);
      saveHomeData(
        List.from(res['data']
            .map(
              (item) => HomeModel.fromJson(item),
            )
            .toList()),
      );
    } else {
      homeData.clear();
      update();
      changeLoaderValue(false);
    }
  }

  onSearch({required BuildContext context}) async {
    if (searchController.text.trim().isNotEmpty) {
      changeLoaderValue(true);
      final res = await HomeRepository().homeSearch(
        context: context,
        name: searchController.text.trim(),
        address: '',
        relationshipStatus: '',
        sexualOrientation: '',
      );
      if (res != null && res['data'] != null) {
        changeLoaderValue(false);
        updateCross(true, context);
        keyboardDismissle(context);
        saveFilterData(
          List.from(res['data']
              .map(
                (item) => HomeModel.fromJson(item),
              )
              .toList()),
        );
      } else {
        filterData.clear();
        update();
        changeLoaderValue(false);
      }
    }
  }

  onFilter({required BuildContext context}) async {
    final res = await HomeRepository().homeSearch(
      context: context,
      name: '',
      address: locationController.text,
      relationshipStatus: relationshipStatusValue == 'Relationship Status' ? '' : relationshipStatusValue,
      sexualOrientation: sexualOrientationValue == 'Sexual Orientation' ? '' : sexualOrientationValue,
      showLoader: true,
    );
    if (res != null && res['data'] != null) {
      updateFilterCross(true, context);
      keyboardDismissle(context);
      saveFilterData(
        List.from(res['data']
            .map(
              (item) => HomeModel.fromJson(item),
            )
            .toList()),
      );
      Get.close(1);
      locationController.clear();
      sliderValue = 20;
      sexualOrientationValue = 'Sexual Orientation';
      relationshipStatusValue = 'Relationship Status';
      update();
    } else {
      filterData.clear();
      update();
    }
  }

  removeHomeDataAtIndex(int index, {bool? contactFriendData = false}) {
    if (contactFriendData == true) {
      appUserContacts.removeAt(appUserContacts.length == 1 ? 0 : index);
    }
    if (filterData.isNotEmpty) {
      filterData.removeAt(filterData.length == 1 ? 0 : index);
    } else {
      homeData.removeAt(homeData.length == 1 ? 0 : index);
    }
    update();
  }

  void handleSwipeLeft({required int index}) async {
    final other = filterData.isNotEmpty ? filterData[index] : homeData[index];
    final userId = other.sId!;
    Get.snackbar(
      'Success',
      'Like Request Send',
      backgroundColor: Colors.white,
      duration: const Duration(
        seconds: 1,
      ),
    );
    removeHomeDataAtIndex(index);
    await onSendLikeRequest(
      context: Get.context!,
      userId: userId,
      showSnackbar: false,
      isFrom: LikeRequestFrom.Home,
      showLoader: false,
    );
  }

  void handleSwipeRight({required int index}) async {
    Get.snackbar(
      'Success',
      'Like Request Skip',
      backgroundColor: Colors.white,
      duration: const Duration(
        seconds: 1,
      ),
    );
    removeHomeDataAtIndex(index);
  }

  bool onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.left) {
      handleSwipeRight(index: previousIndex);
    } else {
      handleSwipeLeft(index: previousIndex);
    }
    return true;
  }

  onSendLikeRequest({
    required BuildContext context,
    required String userId,
    required LikeRequestFrom isFrom,
    bool showSnackbar = true,
    bool showLoader = true,
    int? index,
  }) async {
    final body = {"userId": userId};
    final res = await HomeRepository().sendLikeRequest(
      context: context,
      body: body,
      showLoader: showLoader,
    );
    if (res['message'] == 'Request already sent or approved') {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return BasicDialog(
            heading: 'Already Requested',
            bodyText: 'Like request has been sent already',
            onTap: () {
              Get.back();
            },
          );
        },
      );
    }
    if (res['data'] != null) {
      if (index != null) {
        removeHomeDataAtIndex(index);
      }
      if (showSnackbar) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return BasicDialog(
              heading: 'Request Sent',
              bodyText: 'Like request has been sent',
              onTap: () async {
                Get.close(isFrom == LikeRequestFrom.OtherProfile ? 2 : 1);
                await getHomeMatches(context: context);
              },
            );
          },
        );
      }
    }
  }

  fetchContacts({required BuildContext context}) async {
    List contactList = [];
    var permissionStatus = await FlutterContacts.requestPermission();
    if (permissionStatus) {
      contactList.clear();

      List<Contact> contacts = await FlutterContacts.getContacts();
      contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      final contactsWithNumbers = contacts.where((contact) {
        return contact.phones.isNotEmpty;
      }).toList();

      for (var i = 0; i < contactsWithNumbers.length; i++) {
        var contact = contactsWithNumbers[i];
        var name = contact.displayName;
        var number = contact.phones[0].number.replaceAll(" ", "");
        contactList.add({
          'name': name,
          'number': number,
        });
      }

      changeContactLoader(true);
      final res = await HomeRepository().fetchContacts(
        context: context,
        body: contactList,
        // body: [
        //   {"name": "Miner Own", "number": "3123456789"},
        //   {"name": "Miner Partner", "number": "1212312"},
        //   {"name": "Dating", "number": "456454564564"},
        //   {"name": "Dating partner", "number": "458901"},
        //   {"name": "Other", "number": "121212122122"},
        //   {"name": "Not in app", "number": "88888888888"}
        // ],
      );
      if (res != null && res['data'] != null) {
        changeContactLoader(false);
        saveContactData(
          appUserData: List.from(
            res['data']['users']
                .map(
                  (item) => AppUserContactModel.fromJson(item),
                )
                .toList(),
          ),
          otherData: List.from(
            res['data']['otherUsers']
                .map(
                  (item) => OtherContactsModel.fromJson(item),
                )
                .toList(),
          ),
        );
      } else {
        changeContactLoader(false);
        appUserContacts.clear();
        otherContacts.clear();
        update();
      }
    } else {
      var status = await Permission.contacts.status;

      if (status.isDenied || status.isPermanentlyDenied) {
        Get.defaultDialog(
          backgroundColor: Colors.transparent,
          title: "",
          content: const PermissionDialog(
            bodyText: 'We need access to your contacts. Please tap the "Open Settings" button and enable contacts permission.',
            heading: 'Permission',
          ),
        );
      }
    }
  }

  void filterContacts({
    required String name,
    required bool isAppUsers,
  }) {
    if (isAppUsers) {
      if (name.isEmpty) {
        appUserFilterContacts = appUserContacts;
      } else {
        appUserFilterContacts = appUserContacts.where((filter) {
          return filter.name!.toLowerCase().contains(name.toLowerCase());
        }).toList();
      }
    } else {
      if (name.isEmpty) {
        otherFilterContacts = otherContacts;
      } else {
        otherFilterContacts = otherContacts.where((filter) {
          return filter.name!.toLowerCase().contains(name.toLowerCase());
        }).toList();
      }
    }
    update();
  }

  sendRequestToContactUser({
    required BuildContext context,
    required String userId,
    int? index,
  }) async {
    final body = {"userId": userId};
    final res = await HomeRepository().sendLikeRequest(
      context: context,
      body: body,
      showSnackbar: true,
      showLoader: true,
    );
    if (res['data'] != null) {
      if (index != null) {
        removeHomeDataAtIndex(index, contactFriendData: true);
      }
    }
  }
}
