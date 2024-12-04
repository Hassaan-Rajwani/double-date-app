import 'package:device_calendar/device_calendar.dart';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/models/doube_date_offer_model.dart';
import 'package:double_date/pages/scheduleDoubleDate/calendar_schedule.dart';
import 'package:double_date/repositories/offers_repositort.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:timezone/timezone.dart' as tz;

class ScheduleDoubleDateCalendarController extends GetxController {
  DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  Rx<DateTime> initialDisplayDate = DateTime.now().obs;
  RxString selectedScheduleDate = ''.obs;
  RxBool loader = false.obs;
  RxBool showOtherdate = false.obs;
  RxString selectedEventId = ''.obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  final formKey = GlobalKey<FormState>();
  Rx<DateRangePickerController> scheduleController = DateRangePickerController().obs;
  Rx<TextEditingController> scheduleInputController = TextEditingController().obs;
  Rx<DoubleDateOfferModel> selectedOffer = DoubleDateOfferModel().obs;
  Rx<DateTime> scheduleDoubleDateTime = DateTime.now().obs;
  RxList<Calendar> calendars = <Calendar>[].obs;
  RxList<Calendar> get writableCalendars => calendars.where((c) => c.isReadOnly == false && c.isDefault == true).toList().obs;
  RxList<Event> calendarEvents = <Event>[].obs;
  RxList<SpecialDate> specialDates = <SpecialDate>[].obs;
  RxList<DateTime> get specialDatesOnly {
    return specialDates.map((specialDate) => specialDate.date).toList().obs;
  }

  selectOffer({required DoubleDateOfferModel data}) {
    selectedOffer.value = data;
  }

  clearDate() {
    selectedScheduleDate.value = '';
    scheduleController.value = DateRangePickerController();
    showOtherdate.value = false;
  }

  clearTime() {
    scheduleDoubleDateTime.value = DateTime.now();
  }

  updateDoubleDateTime(value) {
    scheduleDoubleDateTime.value = value;
  }

  updateOtherDate() {
    final date = scheduleInputController.value.text;
    DateTime dateTime = DateTime.parse(date);
    final eventId = specialDates.where((element) => dateTime == element.date);
    if (eventId.isNotEmpty) {
      selectedEventId.value = eventId.first.eventId;
    }
    if (specialDatesOnly.contains(dateTime)) {
      showOtherdate.value = true;
    } else {
      showOtherdate.value = false;
    }
    update();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    selectedScheduleDate.value = args.value.toString().substring(0, 10);
    scheduleInputController.value.text = selectedScheduleDate.toString().substring(0, 10);
    updateOtherDate();
    update();
  }

  // CALENDER FLOW
  // =============
  // Permission & get ids of connect gmails in device.
  // ================================================
  retrieveCalendars() async {
    loader.value = true;
    try {
      var permissionsGranted = await deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && (permissionsGranted.data == null || permissionsGranted.data == false)) {
        permissionsGranted = await deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || permissionsGranted.data == null || permissionsGranted.data == false) {
          return;
        }
      }
      final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
      calendars.value = calendarsResult.data?.whereType<Calendar>().toList() ?? [];
      await getCalendarEvents(calendarId: writableCalendars.first.id!);
      loader.value = false;
    } on PlatformException catch (e) {
      Get.snackbar('Error', '$e');
      loader.value = false;
    }
  }

  // get calender events.
  // ===================
  getCalendarEvents({required String calendarId}) async {
    final startDate = DateTime.now();
    final endDate = DateTime.now().add(const Duration(days: 365));
    final res = await deviceCalendarPlugin.retrieveEvents(
      calendarId,
      RetrieveEventsParams(
        startDate: startDate,
        endDate: endDate,
      ),
    );
    calendarEvents.value = res.data as List<Event>;
    specialDates.clear;
    for (var event in calendarEvents) {
      DateTime startDate = event.start!;
      String formattedDate = DateFormat('yyyy-MM-dd').format(startDate);
      DateTime specialDate = DateTime.parse(formattedDate);
      specialDates.add(
        SpecialDate(date: specialDate, eventId: event.eventId!),
      );
    }
  }

  // create event
  // ============
  onAddEvent({required BuildContext context}) async {
    final sc = Get.put(SocketController());
    sc.emitChatRoom();
    final startTime = formatEndTime(selectedOffer.value.startTime!);
    final endTime = formatEndTime(selectedOffer.value.endTime!);
    final startDate = DateTime.parse('${selectedOffer.value.startTime.toString().substring(0, 10)} $startTime');
    final endDate = DateTime.parse('${selectedOffer.value.endTime.toString().substring(0, 10)} $endTime');

    final tzStartDateTime = tz.TZDateTime.from(startDate, tz.local).add(const Duration(hours: 5));
    final tzEndDateTime = tz.TZDateTime.from(endDate, tz.local).add(const Duration(hours: 5));

    final event = Event(
      writableCalendars.first.id,
      title: selectedOffer.value.name,
      description: selectedOffer.value.terms,
      start: tzStartDateTime,
      end: tzEndDateTime,
      status: EventStatus.Confirmed,
      location: selectedOffer.value.location!.address,
    );

    // Api Call
    final res = await syncOfferWithApi(
      context: context,
      offerId: selectedOffer.value.sId!,
    );

    if (res) {
      // Calender Sync
      var createEventResult = await deviceCalendarPlugin.createOrUpdateEvent(event);
      if (createEventResult?.isSuccess == true) {
        final eventStartDate = DateTime.now().add(const Duration(days: -30));
        final eventEndDate = DateTime.now().add(const Duration(days: 30));
        await deviceCalendarPlugin.retrieveEvents(
          writableCalendars.first.id,
          RetrieveEventsParams(
            startDate: eventStartDate,
            endDate: eventEndDate,
          ),
        );
        await retrieveCalendars();
        Get.close(1);
        selectedScheduleDate.value = startDate.toString().substring(0, 10);
        initialDisplayDate.value = DateTime.parse(selectedOffer.value.startTime.toString().substring(0, 10));
        // scheduleDoubleDateTime.value = startDate;
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.to(() => const CalendarSchedule());
        });
      } else {
        Get.snackbar(
          'Error',
          createEventResult?.errors.map((err) => '[${err.errorCode}] ${err.errorMessage}').join(' | ') as String,
          backgroundColor: Colors.white,
        );
      }
    }
  }

// delete event.
// ============
  deleteEvent({
    required String calendarId,
    required String eventId,
  }) async {
    final res = await deviceCalendarPlugin.deleteEvent(calendarId, eventId);
    if (res.isSuccess && res.data != null) {
      specialDates.removeWhere((specialDate) => specialDate.eventId == eventId);
      await retrieveCalendars();
      Get.close(2);
      Get.snackbar(
        'Success',
        'Event Unsync Successfully',
        backgroundColor: Colors.white,
      );
    }
  }

  syncOfferWithApi({required BuildContext context, required String offerId}) async {
    final body = {
      "offerId": offerId,
    };
    final res = await OfferRepository().syncOffer(context: context, body: body);
    if (res['success']) {
      return true;
    } else {
      return false;
    }
  }

  unSyncOfferWithApi({required BuildContext context, required String offerId}) async {
    final body = {
      "offerId": offerId,
    };
    final res = await OfferRepository().unSyncOffer(context: context, body: body);
    if (res['success']) {
      final eventId = specialDates.where((element) => DateTime.parse(selectedOffer.value.startTime.toString().substring(0, 10)) == element.date);
      if (eventId.isNotEmpty) {
        selectedEventId.value = eventId.first.eventId;
      }
      if (selectedEventId.value != '') {
        final res = await deviceCalendarPlugin.deleteEvent(writableCalendars.first.id!, selectedEventId.value);
        if (res.isSuccess && res.data != null) {
          specialDates.removeWhere((specialDate) => specialDate.eventId == selectedEventId.value);
          await retrieveCalendars();
          Get.close(2);
        }
      } else {
        await retrieveCalendars();
        Get.close(2);
      }
    }
  }
}

// special date model.
// ==================
class SpecialDate {
  final DateTime date;
  final String eventId;

  SpecialDate({required this.date, required this.eventId});
}
