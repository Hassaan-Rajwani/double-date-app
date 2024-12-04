// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';
import 'dart:io';
import 'package:double_date/controllers/date_consultant_controller.dart';
import 'package:double_date/controllers/game_controller.dart';
import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/support_controller.dart';
import 'package:double_date/models/chat_room_model.dart';
import 'package:double_date/models/message_model.dart';
import 'package:double_date/models/ticket_model.dart';
import 'package:double_date/network/api_urls.dart';
import 'package:double_date/pages/messageScreens/ticTacTowGame/tic_tac_toe_start.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:mime/mime.dart';

class SocketController extends GetxController {
  final pc = Get.put(ProfileController());
  final mc = Get.put(MessageController());
  final gc = Get.put(GameController());
  final sc = Get.put(SupportController());
  final dcc = Get.put(DatingConsultantController());

  @override
  void onInit() {
    super.onInit();
    initSocket();
  }

  late io.Socket socket;
  initSocket() async {
    socket = io.io(
      '${AppUrls.socketUrl}?userId=${pc.user.value.sId}',
      <String, dynamic>{
        'transports': ['websocket'],
        "autoConnect": true,
        'force new connection': true,
      },
    );
    socket.onConnect((data) {
      log("Connection Established");
      connectAllListener();
    });
    socket.onReconnect((data) {
      log("Reconnection $data");
      connectAllListener();
    });
    socket.onConnectError((data) => log("Connection Error $data"));
    socket.onDisconnect((data) {
      log("Connection Disconnected $data");
    });
  }

  disposeSoceket() {
    socket.disconnect();
  }

  connectAllListener() {
    listenChatRooms();
    listenRoomMessages();
    listenRecieverMessage();
    listenTicTacToeInvite();
    listenTicTacToeStart();
    listenGameOver();
    listenBoardUpdate();
    listenTurnUpdate();
    listenConversationId();
    errorListener();
    listenSupportMsgList();
    listenConsultantMsgList();
  }

// CHAT SOCKETS
// ============
  listenChatRooms() {
    mc.changeRoomLoader(true);
    socket.on('conversations', (data) async {
      if (data.isNotEmpty) {
        mc.changeRoomLoader(false);
        mc.saveChatRoomList(
          data: List.from(
            data
                .map(
                  (item) => ChatRoomModel.fromJson(item),
                )
                .toList(),
          ),
        );
        update();
      } else {
        mc.saveChatRoomList(clear: true);
        mc.changeRoomLoader(false);
        update();
      }
    });
  }

  listenConversationId() {
    socket.on('newConversation', (data) async {
      if (data.isNotEmpty) {
        emitJoinNewConversation(conversationId: data['conversationId']);
      }
    });
  }

  emitOnRequestAccpet({required String conversationId}) {
    socket.emit('joinAll', {
      "conversationId": conversationId,
    });
  }

  listenRoomMessages() {
    mc.changeMsgLoader(true);
    socket.on('getConversationMessages', (data) async {
      if (data.isNotEmpty) {
        mc.changeMsgLoader(false);
        mc.saveRoomMessages(
          data: List.from(
            data
                .map(
                  (item) => MessageModel.fromJson(item),
                )
                .toList(),
          ),
        );
        update();
      } else {
        mc.saveRoomMessages(clear: true);
        mc.changeMsgLoader(false);
        update();
      }
      emitChatRoom(showLoader: false);
    });
  }

  listenRecieverMessage() {
    socket.on('message', (data) async {
      if (data.isNotEmpty) {
        if (!mc.inChatRoom) {
          if (data['sender']['_id'] == pc.user.value.sId) {
            emitMarkAsRead(messageId: data['_id']);
            update();
          }
        } else {
          if (data['sender']['_id'] != pc.user.value.sId) {
            emitMarkAsRead(messageId: data['_id']);
            update();
          }
        }
        bool exists = mc.roomMessages.any(
          // (message) => message.content == data['content'] || message.createdAt == data['createdAt'],
          (message) => message.content == data['content'] && message.createdAt == data['createdAt'],
        );
        mc.changeSendLoader(false);
        if (exists == false) {
          mc.addMessage(data: MessageModel.fromJson(data));
        }
        emitChatRoom(showLoader: false);
        update();
      }
    });
  }

  emitMarkAsRead({required String messageId}) {
    socket.emit('markAsRead', {
      "messageId": messageId,
      "userId": pc.user.value.sId,
    });
  }

  emitChatRoom({bool showLoader = true}) {
    mc.roomLoader = showLoader;
    socket.emit('conversations', {
      "userId": pc.user.value.sId,
    });
  }

  emitRoomMessages({required String conversationId}) {
    mc.msgLoader = true;
    socket.emit('getConversationMessages', {
      'conversationId': conversationId,
      'userId': pc.user.value.sId,
    });
  }

  emitSendMessage({
    required String conversationId,
    String? text = '',
    XFile? media,
    bool? isFromGame = false,
    String messageType = '',
    dynamic shareResponse,
  }) async {
    dynamic mediaData;
    if (media != null) {
      mc.changeSendLoader(true);
      update();
      var mimeType = lookupMimeType(media.path);
      mediaData = {
        "filename": media.path.split('/').last,
        "buffer": await media.readAsBytes(),
        'mimetype': mimeType!.split('/')[0],
      };
    }

    socket.emit('message', {
      'sender': pc.user.value.sId,
      'conversationId': conversationId,
      'content': isFromGame! ? shareResponse : text ?? '',
      'media': media != null ? mediaData : '',
      'messageType': messageType,
    });
    if (text != '') {
      mc.chatController.clear();
      emitChatRoom(showLoader: false);
      update();
    }
  }

  emitJoinNewConversation({required String conversationId}) {
    socket.emit('joinNewConversation', {
      'conversationId': conversationId,
    });
  }

// TICTACTOE SOCKETS
// =================
  listenTicTacToeStart() {
    socket.on('gameStart', (data) async {
      if (data.isNotEmpty) {
        gc.updateTurn(data['firstTurn']);
        update();
        Get.to(
          () => TicTacToeGameStartScreen(
            data: data,
          ),
        );
      }
    });
  }

  listenGameOver() {
    socket.on('gameOver', (data) async {
      if (data.isNotEmpty) {
        if (data['winner'] == null) {
          if (data['leftUser'] != null) {
            if (data['leftUser'] != pc.user.value.sId) {
              Get.close(1);
              Get.snackbar(
                'Finish',
                data['message'],
                backgroundColor: Colors.white,
              );
            }
          } else {
            Get.close(1);
            Get.snackbar(
              'Finish',
              data['message'],
              backgroundColor: Colors.white,
            );
          }
        } else {
          Get.snackbar(
            'Finish',
            data['message'],
            backgroundColor: Colors.white,
          );
          gc.updateWinnerId(data['winner']);
          update();
        }
      }
    });
  }

  errorListener() {
    socket.on('error', (data) async {
      if (data.isNotEmpty) {
        if (data["message"] == "Conversation deleted by member") {
          emitChatRoom();
          Get.close(1);
          Get.snackbar(
            'Success',
            data["message"],
            backgroundColor: Colors.white,
          );
        } else {
          Get.snackbar(
            'Success',
            data["message"],
            backgroundColor: Colors.white,
          );
        }
      }
    });
  }

  listenBoardUpdate() {
    socket.on('boardUpdate', (data) async {
      if (data.isNotEmpty) {
        gc.updateBoard(data);
        update();
      }
    });
  }

  listenTurnUpdate() {
    socket.on('turnUpdate', (data) async {
      if (data.isNotEmpty) {
        gc.updateTurn(data['nextTurn']);
        update();
      }
    });
  }

  listenTicTacToeInvite() {
    socket.on('gameInvite', (data) async {
      if (data.isNotEmpty) {
        Get.snackbar(
          'Invite',
          'asdasd',
          colorText: Colors.black,
          duration: const Duration(seconds: 10),
          backgroundColor: Colors.white,
          messageText: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['message'],
                style: interFont(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      emitAcceptRequestForTicTacToe(
                        conversationId: data['conversationId'],
                        hostId: data['hostId'],
                      );
                      Get.back();
                    },
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    });
  }

  emitInviteForTicTacToe({
    required String conversationId,
    required String guestId,
  }) {
    socket.emit('inviteForTicTacToe', {
      'hostId': pc.user.value.sId!,
      'conversationId': conversationId,
      'guestId': guestId,
    });
  }

  emitAcceptRequestForTicTacToe({
    required String conversationId,
    required String hostId,
  }) {
    socket.emit('acceptTicTacToeInvite', {
      'hostId': hostId,
      'conversationId': conversationId,
      'guestId': pc.user.value.sId!,
    });
  }

  emitLeaveTicTacToe({
    required String conversationId,
    required String guestId,
    required String hostId,
  }) {
    socket.emit('leaveGame', {
      'hostId': hostId,
      'guestId': guestId,
      'conversationId': conversationId,
      'userId': pc.user.value.sId!,
    });
    gc.resetGame();
    update();
  }

  emitMakeMove({
    required String conversationId,
    required int position,
    required String guestId,
    required String hostId,
  }) {
    socket.emit('makeMove', {
      'hostId': hostId,
      'guestId': guestId,
      'conversationId': conversationId,
      'playerId': pc.user.value.sId!,
      'position': position,
    });
  }

// SUPPORT SOCKETS
  emitGetSupportList() {
    sc.supportLoader = true;
    socket.emit('listTickets', {
      'userId': pc.user.value.sId,
    });
  }

  emitTicketMessageList({required String ticketId}) {
    sc.supportMsgLoader = true;
    socket.emit('getTicketMessages', {
      'userId': pc.user.value.sId,
      'ticketId': ticketId,
    });
  }

  listenSupportMsgList() {
    sc.setSupportMsgLoader(true);
    socket.on('getTicketMessages', (data) async {
      if (data.isNotEmpty) {
        sc.setSupportMsgLoader(false);
        sc.saveTicketMsgList(data: data['messages']);
        emitGetSupportList();
        update();
      } else {
        sc.saveTicketList(clear: true);
        sc.setSupportMsgLoader(false);
        update();
      }
    });
  }

  listenSupportList() {
    sc.setSupportLoader(true);
    socket.on('listTickets', (data) async {
      if (data.isNotEmpty) {
        sc.setSupportLoader(false);
        sc.saveTicketList(
          data: List.from(
            data['tickets']
                .map(
                  (item) => TicketsModel.fromJson(item),
                )
                .toList(),
          ),
        );
        update();
      } else {
        sc.saveTicketList(clear: true);
        sc.setSupportLoader(false);
        update();
      }
    });
  }

  emitCreateTicket({
    required String text,
    required String description,
    required File media,
  }) async {
    dynamic mediaData;
    var mimeType = lookupMimeType(media.path);
    mediaData = {
      "filename": media.path.split('/').last,
      "buffer": await media.readAsBytes(),
      'mimetype': mimeType!.split('/')[0],
    };
    socket.emit('createTicket', {
      'userId': pc.user.value.sId,
      'title': text,
      'description': description,
      'media': mediaData,
    });
  }

  emitTicketReply({
    required String ticketId,
  }) async {
    final content = {
      'type': 'message',
      'message': sc.chatController.text,
    };
    socket.emit('ticketReply', {
      'ticketId': ticketId,
      'userId': pc.user.value.sId,
      'userType': 'User',
      'content': content,
    });
    sc.chatController.clear();
    Future.delayed(const Duration(milliseconds: 500), () {
      emitTicketMessageList(ticketId: ticketId);
      update();
    });
  }

// DATING CONSULTANT SOCKETS
  emitConsultantMessageList() {
    dcc.msgLoader = true;
    socket.emit('list-consultant-messages', {
      'userId': pc.user.value.sId,
    });
  }

  listenConsultantMsgList() {
    dcc.setMsgLoader(true);
    socket.on('list-consultant-messages', (data) async {
      if (data.isNotEmpty) {
        dcc.setMsgLoader(false);
        dcc.saveConsultantMsg(data: data[0]['messages']);
        emitGetSupportList();
        update();
      } else {
        dcc.saveConsultantMsg(clear: true);
        dcc.setMsgLoader(false);
        update();
      }
    });
  }

  emitConsultantMessage() async {
    socket.emit('consultant-messaging', {
      'userId': pc.user.value.sId,
      'consultantId': '66d96748bc434927f50451c0',
      'userType': 'User',
      'content': dcc.chatController.text,
    });
    dcc.chatController.clear();
    Future.delayed(const Duration(milliseconds: 500), () {
      emitConsultantMessageList();
      update();
    });
  }

  emitCloseChat() {
    socket.emit('close-chat', {
      'userId': pc.user.value.sId,
      'consultantId': '66d96748bc434927f50451c0',
    });
  }
}
