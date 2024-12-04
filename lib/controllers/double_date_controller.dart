// ignore_for_file: use_build_context_synchronously
import 'package:double_date/models/doube_date_offer_model.dart';
import 'package:double_date/models/upcoming_date_model.dart';
import 'package:double_date/repositories/offers_repositort.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoubleDateController extends GetxController {
  bool dateSet = false;
  DateFormat myFormat = DateFormat('MM/dd/yyyy');
  DoubleDateOfferModel singleOfferData = DoubleDateOfferModel();
  TextEditingController dateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List<String> eventTypeList = [];
  List<UpcomingDateModel> upcomingOffersList = [];
  List<DoubleDateOfferModel> doubleDateOffers = [];
  String eventTypeValue = 'Birthday';
  bool showOtherdate = false;
  bool upcomingLoader = false;
  bool offersLoader = false;
  bool detailLoader = false;
  bool showFilterCross = false;

  getCategoryList({required BuildContext context}) async {
    final res = await OfferRepository().getCategory(context: context);
    if (res != null && res['data'] != null) {
      eventTypeList.clear();
      eventTypeList = List.from(
        res['data']
            .map(
              (item) => item['category'],
            )
            .toList(),
      );
      eventTypeValue = '';
    }
  }

  clearFilter(val, context, {bool clearData = false}) {
    showFilterCross = val;
    if (clearData) {
      locationController.clear();
      eventTypeValue = eventTypeList[0];
      dateSet = false;
      dateController.clear();
    }
    update();
  }

  changeOffersLoader(val) {
    offersLoader = val;
    update();
  }

  changeDetailLoader(val) {
    detailLoader = val;
  }

  saveOffersData(List<DoubleDateOfferModel> data) {
    doubleDateOffers.clear();
    doubleDateOffers = data;
    update();
  }

  saveSingleOffersData(DoubleDateOfferModel data) {
    singleOfferData = DoubleDateOfferModel();
    singleOfferData = data;
    update();
  }

  setUpcomingLoader(val) {
    upcomingLoader = val;
    update();
  }

  setUpcomingOffersList({required List<UpcomingDateModel> data}) {
    upcomingOffersList.clear();
    upcomingOffersList = data;
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateSet = true;
      dateController = TextEditingController(text: picked.toString().substring(0, 10));
      update();
    }
  }

  updateEventType(value) {
    eventTypeValue = value;
    update();
  }

  getOffersData({
    required BuildContext context,
    bool? allowFilter = false,
  }) async {
    changeOffersLoader(true);
    final res = allowFilter!
        ? await OfferRepository().doubleDateOffers(
            context: context,
            activity: eventTypeValue,
            address: locationController.text,
            date: dateController.text == '' ? '' : '${dateController.text}T00:00:00.000Z',
            name: '',
          )
        : await OfferRepository().doubleDateOffers(
            context: context,
            activity: '',
            address: '',
            date: '',
            name: searchController.text.trim(),
          );
    if (res != null && res['data'] != null) {
      changeOffersLoader(false);
      if (allowFilter) {
        clearFilter(true, context);
      }
      saveOffersData(
        List.from(
          res['data']
              .map(
                (item) => DoubleDateOfferModel.fromJson(item),
              )
              .toList(),
        ),
      );
      update();
    } else {
      changeOffersLoader(false);
      doubleDateOffers.clear();
      update();
    }
  }

  getSingleOffersData({required BuildContext context, required String offerId}) async {
    changeDetailLoader(true);
    final res = await OfferRepository().doubleDateOfferById(
      context: context,
      offerId: offerId,
    );
    if (res != null && res['data'] != null) {
      changeDetailLoader(false);
      saveSingleOffersData(DoubleDateOfferModel.fromJson(res['data']));
    } else {
      changeDetailLoader(false);
      doubleDateOffers.clear();
      update();
    }
  }

  getUpcomgOffers({required BuildContext context}) async {
    setUpcomingLoader(true);
    final res = await OfferRepository().upcomingOffers(
      context: context,
    );
    if (res != null && res['data'] != null) {
      setUpcomingLoader(false);
      setUpcomingOffersList(
        data: List.from(
          res['data']
              .map(
                (item) => UpcomingDateModel.fromJson(item),
              )
              .toList(),
        ),
      );
    } else {
      setUpcomingLoader(false);
      upcomingOffersList.clear();
      update();
    }
  }
}
