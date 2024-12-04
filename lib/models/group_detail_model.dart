class GroupDetailModel {
  String? sId;
  List<Participants>? participants;
  String? name;
  String? picture;

  GroupDetailModel({
    this.sId,
    this.participants,
    this.name,
    this.picture,
  });

  GroupDetailModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
    name = json['name'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['picture'] = picture;
    return data;
  }
}

class Participants {
  String? sId;
  String? profilePicture;
  String? name;
  String? gender;
  bool? isChecked;

  Participants({
    this.sId,
    this.profilePicture,
    this.name,
    this.gender,
    this.isChecked,
  });

  Participants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    name = json['name'];
    gender = json['gender'];
    isChecked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['profilePicture'] = profilePicture;
    data['name'] = name;
    data['gender'] = gender;
    return data;
  }
}
