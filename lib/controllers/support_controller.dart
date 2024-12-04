import 'dart:async';
import 'dart:io';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/models/ticket_model.dart';
import 'package:double_date/repositories/setting_repository.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SupportController extends GetxController {
  final ImagePicker picker = ImagePicker();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController chatController = TextEditingController();
  TextEditingController feedBackController = TextEditingController();
  final supportFormKey = GlobalKey<FormState>();
  final feedbackFormKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  File? supportImage;
  bool supportLoader = false;
  bool supportMsgLoader = false;
  List<TicketsModel> ticketList = [];
  List ticketMsgList = [];
  List<String> supportTicketButtonList = [
    "ALL TICKETS",
    "OPEN TICKETS",
    "RESOLVED TICKETS",
  ];

  String supportTicketSelectedButton = 'ALL TICKETS';

  List<TicketsModel> get filteredTicketList {
    if (supportTicketSelectedButton == 'ALL TICKETS') {
      return ticketList;
    } else if (supportTicketSelectedButton == 'OPEN TICKETS') {
      return ticketList.where((ticket) => ticket.status == 'Open').toList();
    } else if (supportTicketSelectedButton == 'RESOLVED TICKETS') {
      return ticketList.where((ticket) => ticket.status == 'Resolved').toList();
    }
    return [];
  }

  selectSupportButton(value) {
    supportTicketSelectedButton = value;
    update();
  }

  setSupportLoader(val) {
    supportLoader = val;
    update();
  }

  setSupportMsgLoader(val) {
    supportMsgLoader = val;
    update();
  }

  pickSupportImage({bool oepnCamera = false}) async {
    final XFile? file = await picker.pickImage(source: oepnCamera ? ImageSource.camera : ImageSource.gallery);
    if (file != null) {
      supportImage = File(file.path);
      update();
    }
  }

  clearData() {
    titleController.clear();
    descriptionController.clear();
    supportImage = null;
    update();
  }

  onCreateTicket({required BuildContext context}) {
    final socket = Get.put(SocketController());
    if (supportFormKey.currentState != null && supportFormKey.currentState!.validate()) {
      if (supportImage != null) {
        dialogSpinkit(context: context);
        socket.emitCreateTicket(
          text: titleController.text,
          description: descriptionController.text,
          media: supportImage!,
        );
        Future.delayed(const Duration(seconds: 1), () {
          Get.close(2);
          socket.emitGetSupportList();
        });
      } else {
        Get.snackbar(
          'Error',
          'Please select ticket image',
          backgroundColor: Colors.white,
        );
      }
    }
  }

  saveTicketList({List<TicketsModel>? data, bool clear = false}) {
    if (clear == true) {
      ticketList.clear();
      update();
    } else {
      ticketList.clear();
      ticketList = data!;
      update();
    }
  }

  saveTicketMsgList({List? data, bool clear = false}) {
    if (clear == true) {
      ticketMsgList.clear();
      update();
    } else {
      ticketMsgList.clear();
      ticketMsgList = data!;
      Future.delayed(const Duration(milliseconds: 400), () {
        scrollToBottom();
      });
      update();
    }
  }

  scrollToBottom() {
    Timer(
      const Duration(milliseconds: 100),
      () => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 100),
      ),
    );
  }

  onSendFeedback({required BuildContext context}) async {
    final body = {
      'description': feedBackController.text,
    };
    if (feedbackFormKey.currentState != null && feedbackFormKey.currentState!.validate()) {
      final res = await SettingRepository().sendFeedback(
        context: context,
        body: body,
      );
      if (res != null && res['data'] != null) {
        feedBackController.clear();
        update();
        Get.close(1);
      }
    }
  }
}
