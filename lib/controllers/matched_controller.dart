// ignore_for_file: use_build_context_synchronously
import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/models/friends_model.dart';
import 'package:double_date/models/like_recieved_model.dart';
import 'package:double_date/models/like_sent_model.dart';
import 'package:double_date/models/paired_user_model.dart';
import 'package:double_date/models/partner_like_model.dart';
import 'package:double_date/pages/matchedScreens/matched_like_received_list.dart';
import 'package:double_date/pages/matchedScreens/matched_like_sent_list.dart';
import 'package:double_date/pages/matchedScreens/matched_partner_like_list.dart';
import 'package:double_date/pages/messageScreens/chat_room.dart';
import 'package:double_date/repositories/converstaion_repository.dart';
import 'package:double_date/repositories/match_repository.dart';
import 'package:double_date/utils/enums.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchedController extends GetxController {
  int selectedIndex = 0;
  bool showOtherOption = false;
  bool changePartner = false;
  bool matchedLoader = false;
  bool pairedLoader = false;
  List<LikeSentModel> likeSentData = [];
  List<LikeRecievedModel> likeReceivedData = [];
  List<PartnersLikedModel> partnerLikeData = [];
  List<FriendsModel> likeFriendsData = [];
  PairedUserModel pairedUserData = PairedUserModel();

  saveMatchesData({
    required List<LikeSentModel> likeData,
    required List<LikeRecievedModel> receivedData,
    required List<PartnersLikedModel> partnerData,
    required List<FriendsModel> friendsData,
  }) {
    likeSentData = likeData;
    likeReceivedData = receivedData;
    partnerLikeData = partnerData;
    likeFriendsData = friendsData;
    update();
  }

  savePairUserData({required PairedUserModel pairData}) {
    pairedUserData = pairData;
    update();
  }

  List<String> matchedButtonList = [
    'Like received',
    'Like Sent',
    'Partner’s Like',
  ];

  updateIndex(value, context) async {
    selectedIndex = value;
    await getMatchesList(context: context);
    update();
  }

  enableOtherOption() {
    showOtherOption = true;
    update();
  }

  hideOtherOption() {
    showOtherOption = false;
    update();
  }

  updateChangePartner() {
    changePartner = !changePartner;
    update();
  }

  Widget matchedList() {
    switch (selectedIndex) {
      case 0:
        return const MatchedLikeReceivedList();
      case 1:
        return const MatchedLikeSentList();
      case 2:
        return const MatchedPartnerLikeList();
      default:
        return const MatchedLikeReceivedList();
    }
  }

  changeLoaderValue(value) {
    matchedLoader = value;
    update();
  }

  changePairedLoaderValue(value) {
    pairedLoader = value;
    update();
  }

  getMatchesList({required BuildContext context}) async {
    changeLoaderValue(true);
    final res = await MatchedRepository().getRequests(context: context);
    if (res['data'] != null) {
      changeLoaderValue(false);
      saveMatchesData(
        receivedData: List.from(
          res['data']['recievedRequests']
              .map((item) => LikeRecievedModel(
                    user: RecievedUser.fromJson(item['user']),
                    sId: item['_id'],
                    status: item['status'],
                  ))
              .toList(),
        ),
        partnerData: List.from(
          res['data']['partnersLiked']
              .map(
                (item) => PartnersLikedModel(
                  recievedFrom: RecievedFrom.fromJson(item['recievedFrom']),
                  sId: item['_id'],
                  status: item['status'],
                ),
              )
              .toList(),
        ),
        likeData: List.from(
          res['data']['sendrequests']
              .map(
                (item) => LikeSentModel(
                  user: LikeUser.fromJson(item['user']),
                  sId: item['_id'],
                  status: item['status'],
                ),
              )
              .toList(),
        ),
        friendsData: List.from(
          res['data']['friends']
              .map(
                (item) => FriendsModel.fromJson(item),
              )
              .toList(),
        ),
      );
    } else {
      changeLoaderValue(false);
    }
  }

  getPartnersData({
    required BuildContext context,
    required String id,
  }) async {
    changePairedLoaderValue(true);
    final res = await MatchedRepository().getPairedData(context: context, id: id);
    if (res['data'] != null) {
      changePairedLoaderValue(false);
      savePairUserData(
        pairData: PairedUserModel(
          user: User.fromJson(
            res['data']['user'],
          ),
        ),
      );
    } else {
      changePairedLoaderValue(false);
    }
  }

  onRespondRequest({
    required BuildContext context,
    required bool isAccept,
    required int index,
  }) async {
    final sc = Get.put(SocketController());
    final body = {
      "userId": likeReceivedData[index].user!.sId!,
      "requestId": likeReceivedData[index].sId,
      "type": isAccept ? RequestStatus.Approved.name : RequestStatus.Rejected.name,
    };
    final res = await MatchedRepository().respondRequest(context: context, body: body);
    if (res['data'] != null) {
      if (res['data']['conversation'] != null) {
        sc.emitOnRequestAccpet(conversationId: res['data']['conversation']['_id']);
      }
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return BasicDialog(
            heading: 'Invite ${isAccept ? 'Accepted' : 'Denied'}',
            bodyText: 'You have ${isAccept ? 'accepted' : 'denied'} Like request.',
            onTap: () async {
              Get.close(1);
              await getMatchesList(context: context);
            },
          );
        },
      );
    }
  }

  onPartnerRespond({
    required BuildContext context,
    required bool isAccept,
    required int index,
  }) async {
    final body = {
      "recievedFrom": partnerLikeData[index].recievedFrom!.sId!,
      "response": isAccept ? RequestStatus.Approved.name : RequestStatus.Rejected.name,
      "requestId": partnerLikeData[index].sId!,
    };
    final res = await MatchedRepository().onPartnerRespond(context: context, body: body);
    if (res['data'] != null) {
      partnerLikeData[index].status = isAccept ? RequestStatus.Approved.name : RequestStatus.Rejected.name;
      update();
    }
  }

  getConversationId({required BuildContext context, required String id}) async {
    final body = {
      'userId': id,
    };
    final res = await ConverstaionRepository().getConversationId(context: context, body: body);
    if (res != null && res['data'] != null) {
      Get.to(
        () => ChatRoomScreen(conversationId: res['data'][0]['_id']),
      );
    }
  }
}
