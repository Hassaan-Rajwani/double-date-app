class BlockedUserModel {
  String? sId;
  String? profilePicture;
  String? dateofbirth;
  String? name;

  BlockedUserModel({
    this.sId,
    this.profilePicture,
    this.dateofbirth,
    this.name,
  });

  BlockedUserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    dateofbirth = json['dateofbirth'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['profilePicture'] = profilePicture;
    data['dateofbirth'] = dateofbirth;
    data['name'] = name;
    return data;
  }
}
