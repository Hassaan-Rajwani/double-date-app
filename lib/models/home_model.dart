class HomeModel {
  String? sId;
  String? profilePicture;
  String? name;
  Partner? partner;

  HomeModel({this.sId, this.profilePicture, this.name, this.partner});

  HomeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    name = json['name'];
    partner = json['partner'] != null ? Partner.fromJson(json['partner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['profilePicture'] = profilePicture;
    data['name'] = name;
    if (partner != null) {
      data['partner'] = partner!.toJson();
    }
    return data;
  }
}

class Partner {
  String? profilePicture;
  String? name;
  String? sId;

  Partner({this.profilePicture, this.name, this.sId});

  Partner.fromJson(Map<String, dynamic> json) {
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
