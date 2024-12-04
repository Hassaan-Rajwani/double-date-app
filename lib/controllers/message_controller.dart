// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:io';
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/models/chat_room_model.dart';
import 'package:double_date/models/date_planner_model.dart';
import 'package:double_date/models/group_detail_model.dart';
import 'package:double_date/models/message_model.dart';
import 'package:double_date/pages/messageScreens/group_detail_dialog.dart';
import 'package:double_date/repositories/converstaion_repository.dart';
import 'package:double_date/widgets/double_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MessageController extends GetxController {
  TextEditingController chatController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();
  TextEditingController reportReasonController = TextEditingController();
  final reportReasonFormKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  bool isSwitched = false;
  List selectedBlockUser = [];
  List selectedReportUser = [];
  List selectedPlayers = [];
  List selectedGroup = [];
  File? groupImage;
  File? media;
  final ImagePicker picker = ImagePicker();
  // bool request = false;
  bool roomLoader = false;
  bool msgLoader = false;
  bool sendLoader = false;
  bool emojiShowing = true;
  bool inChatRoom = false;
  List<ChatRoomModel> chatRooms = [];
  List<MessageModel> roomMessages = [];
  GroupDetailModel groupDetail = GroupDetailModel();

  changeEmojiValue(val) {
    emojiShowing = val;
    update();
  }

  changeInChatRoomVal(val) {
    inChatRoom = val;
  }

  saveGroupDetails({required GroupDetailModel data}) {
    groupDetail = data;
    saveGoupName(data.name!);
    update();
  }

  saveGoupName(name) {
    groupNameController.text = name;
    update();
  }

  changeSendLoader(val) {
    sendLoader = val;
    update();
  }

  changeRoomLoader(val) {
    roomLoader = val;
    update();
  }

  changeMsgLoader(val) {
    msgLoader = val;
    update();
  }

  saveChatRoomList({List<ChatRoomModel>? data, bool clear = false}) {
    if (clear == true) {
      chatRooms.clear();
      update();
    } else {
      chatRooms.clear();
      chatRooms = data!;
      update();
    }
  }

  incrementUnreadMessagesCount({required String conversationId, required dynamic messageData}) {
    final chatRoom = chatRooms.firstWhere((room) => room.sId == conversationId);
    chatRoom.unreadMessagesCount = chatRoom.unreadMessagesCount! + 1;
    chatRoom.lastMessage = messageData['content'] == "" ? messageData['messageType'] : messageData['content'];
    chatRoom.updatedAt = messageData['updatedAt'];
    final chatRoomIndex = chatRooms.indexWhere((room) => room.sId == conversationId);
    if (chatRoomIndex != -1) {
      final chatRoom = chatRooms.removeAt(chatRoomIndex);
      chatRooms.insert(0, chatRoom);
      update();
    }
    update();
  }

  saveRoomMessages({List<MessageModel>? data, bool clear = false}) {
    if (clear == true) {
      roomMessages.clear();
      update();
    } else {
      roomMessages.clear();
      roomMessages = data!;
      Future.delayed(const Duration(milliseconds: 400), () {
        scrollToBottom();
      });
      update();
    }
  }

  addMessage({required MessageModel data}) {
    roomMessages.add(data);
    Future.delayed(const Duration(milliseconds: 400), () {
      scrollToBottom();
    });
    update();
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

  updateSwitch(value) {
    isSwitched = value;
    update();
  }

  void toggleChoosePlayerCheckbox(int index, bool value, String conversationId) {
    if (value) {
      for (var player in selectedPlayers) {
        player.isChecked = false;
      }
      selectedPlayers.clear();
    }
    final data = groupDetail.participants![index];
    data.isChecked = value;
    if (value) {
      selectedPlayers.add(data);
    } else {
      selectedPlayers.removeWhere((user) => user.name == data.name);
    }
    update();
  }

  void toggleChooseGroupCheckbox(int index, bool value) {
    if (value) {
      for (var player in selectedGroup) {
        player.isChecked = false;
      }
      selectedGroup.clear();
    }
    final data = chatRooms[index];
    data.isChecked = value;
    if (value) {
      selectedGroup.add(data);
    } else {
      selectedGroup.removeWhere((user) => user.name == data.name);
    }
    update();
  }

  closeChoosePlayer() {
    for (var participant in groupDetail.participants!) {
      participant.isChecked = false;
    }
    selectedPlayers.clear();
  }

  closeChooseGroup() {
    for (var participant in chatRooms) {
      participant.isChecked = false;
    }
    selectedGroup.clear();
  }

  Participants getRoomParticipants({required String conversationId, required int index}) {
    final chatRoom = chatRooms.firstWhere((room) => room.sId == conversationId);
    return chatRoom.participants![index];
  }

  pickGroupImage({bool oepnCamera = false}) async {
    final XFile? file = await picker.pickImage(source: oepnCamera ? ImageSource.camera : ImageSource.gallery);
    if (file != null) {
      groupImage = File(file.path);
      update();
    }
  }

  pickMedia({required String id}) async {
    final sc = Get.put(SocketController());
    final XFile? file = await picker.pickMedia();
    if (file != null) {
      media = File(file.path);
      sc.emitSendMessage(conversationId: id, media: file);
    }
  }

  // requestAccpeted() {
  //   request = true;
  //   update();
  // }

  getRoomDetails({
    required BuildContext context,
    required String conversationId,
    bool? showLoader = true,
  }) async {
    final res = await ConverstaionRepository().getRoomDetails(
      context: context,
      conversationId: conversationId,
      showLoader: showLoader!,
    );
    if (res != null && res['data'] != null) {
      saveGroupDetails(
        data: GroupDetailModel.fromJson(res['data']),
      );
      if (showLoader) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const GroupDetailDialog();
          },
        );
      }
    }
  }

  inviteForKnowMe({
    required BuildContext context,
    required String conversationId,
  }) async {
    final mc = Get.put(MessageController());
    final body = {
      "userId": mc.selectedPlayers[0].sId,
      "conversationId": conversationId,
    };
    Get.close(1);
    await ConverstaionRepository().inviteForKnowMe(
      context: context,
      body: body,
    );
  }

  updateDateIdeaPlannerStatus({
    required BuildContext context,
    required String msgId,
    required String conversationId,
    required bool status,
    required DatePlannerModel msgData,
  }) async {
    final sc = Get.put(SocketController());
    final body = {
      "messageId": msgId,
      "status": status ? 'Accepted' : 'Rejected',
    };
    final res = await ConverstaionRepository().changeIdeaPlannerMsgStatus(
      context: context,
      conversationId: conversationId,
      body: body,
    );
    if (res != null) {
      sc.emitRoomMessages(conversationId: conversationId);
    }
  }

  updateRoomDetails({
    required BuildContext context,
    required String conversationId,
  }) async {
    final body = {
      'name': groupNameController.text,
    };
    final res = await ConverstaionRepository().updateRoomDetails(
      context: context,
      conversationId: conversationId,
      body: body,
      file: groupImage,
    );
    if (res != null && res['data'] != null) {
      Get.close(3);
      final sc = Get.put(SocketController());
      sc.emitChatRoom();
      update();
    }
  }

  onReportGroupMember({
    required BuildContext context,
  }) async {
    final sc = Get.put(SocketController());
    final body = {
      'userIds': [selectedPlayers[0].sId],
      'reason': 'Other',
      'description': reportReasonController.text,
    };
    if (reportReasonFormKey.currentState != null && reportReasonFormKey.currentState!.validate()) {
      reportReasonController.clear();
      update();
      Get.close(1);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DoubleButtonDialog(
            onNo: () {
              Get.back();
            },
            onYes: () async {
              final res = await ConverstaionRepository().reportGroupMember(
                context: context,
                body: body,
              );
              if (res != null && res['data'] != null) {
                sc.emitChatRoom();
                Get.close(3);
              }
            },
            heading: 'Report User',
            bodyText: 'Are you sure you want to\nreport this User?',
          );
        },
      );
    }
  }

  onBlockGroupMember({
    required BuildContext context,
    required String conversationId,
  }) async {
    final sc = Get.put(SocketController());
    final body = {
      "conversationId": conversationId,
    };
    Get.close(1);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DoubleButtonDialog(
          onNo: () {
            Get.back();
          },
          onYes: () async {
            final res = await ConverstaionRepository().blockGroupMember(
              context: context,
              body: body,
            );
            if (res != null && res['data'] != null) {
              sc.emitChatRoom();
              Get.close(3);
            }
          },
          heading: 'Block User',
          bodyText: 'Are you sure you want to\nblock this User?',
        );
      },
    );
  }

  onLeaveGroup({
    required BuildContext context,
    required String conversationId,
  }) async {
    final sc = Get.put(SocketController());
    final body = {
      "conversationId": conversationId,
    };
    Get.close(1);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DoubleButtonDialog(
          onYes: () async {
            final res = await ConverstaionRepository().leaveGroup(
              context: context,
              body: body,
            );
            if (res != null && res['data'] != null) {
              sc.emitChatRoom();
              Get.close(2);
            }
          },
          onNo: () {
            Get.close(1);
          },
          heading: 'Leave Group',
          bodyText: 'Are you sure you want to\nleave this group?',
        );
      },
    );
  }
}
