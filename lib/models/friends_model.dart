class FriendsModel {
  String? sId;
  String? profilePicture;
  String? name;

  FriendsModel({this.sId, this.profilePicture, this.name});

  FriendsModel.fromJson(Map<String, dynamic> json) {
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
