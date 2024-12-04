class MessageModel {
  String? sId;
  String? conversation;
  Sender? sender;
  String? messageType;
  String? content;
  List<IdeaPlanner>? ideaPlanner;
  String? createdAt;
  String? updatedAt;
  String? media;

  MessageModel({
    this.sId,
    this.conversation,
    this.sender,
    this.messageType,
    this.content,
    this.ideaPlanner,
    this.createdAt,
    this.updatedAt,
    media,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    conversation = json['conversation'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    messageType = json['messageType'];
    content = json['content'];
    if (json['ideaPlanner'] != null) {
      ideaPlanner = <IdeaPlanner>[];
      json['ideaPlanner'].forEach((v) {
        ideaPlanner!.add(IdeaPlanner.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['conversation'] = conversation;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    data['messageType'] = messageType;
    data['content'] = content;
    if (ideaPlanner != null) {
      data['ideaPlanner'] = ideaPlanner!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['media'] = media;
    return data;
  }
}

class Sender {
  String? sId;
  String? name;

  Sender({this.sId, this.name});

  Sender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class IdeaPlanner {
  User? user;
  String? status;
  String? sId;

  IdeaPlanner({this.user, this.status, this.sId});

  IdeaPlanner.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['status'] = status;
    data['_id'] = sId;
    return data;
  }
}

class User {
  String? sId;
  String? profilePicture;
  String? name;

  User({this.sId, this.profilePicture, this.name});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['profilePicture'] = profilePicture;
    data['name'] = name;
    return data;
  }
}
