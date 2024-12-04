import 'package:double_date/models/group_detail_model.dart';

class ChatRoomModel {
  String? sId;
  String? messageType;
  String? lastMessage;
  List<Participants>? participants;
  String? name;
  String? picture;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? unreadMessagesCount;
  bool? isDisabled;
  bool? isChecked;

  ChatRoomModel({
    this.sId,
    this.participants,
    this.name,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.unreadMessagesCount,
    this.isDisabled,
    this.isChecked,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lastMessage = json['lastMessage'];
    messageType = json['messageType'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
    isChecked = false;
    name = json['name'];
    isDisabled = json['isDisabled'];
    picture = json['picture'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    unreadMessagesCount = json['unreadMessagesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['isDisabled'] = isDisabled;
    data['messageType'] = messageType;
    data['messageType'] = lastMessage;
    data['picture'] = picture;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['unreadMessagesCount'] = unreadMessagesCount;
    return data;
  }
}
