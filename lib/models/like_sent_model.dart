class LikeSentModel {
  LikeUser? user;
  String? status;
  String? sId;

  LikeSentModel({this.user, this.status, this.sId});

  LikeSentModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? LikeUser.fromJson(json['user']) : null;
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

class LikeUser {
  Location? location;
  String? sId;
  String? profilePicture;
  String? name;
  Partner? partner;

  LikeUser({this.location, this.sId, this.profilePicture, this.name, this.partner});

  LikeUser.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    name = json['name'];
    partner = json['partner'] != null ? Partner.fromJson(json['partner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['profilePicture'] = profilePicture;
    data['name'] = name;
    if (partner != null) {
      data['partner'] = partner!.toJson();
    }
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;
  String? address;

  Location({this.type, this.coordinates, this.address});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    data['address'] = address;
    return data;
  }
}

class Partner {
  String? sId;
  String? name;

  Partner({this.sId, this.name});

  Partner.fromJson(Map<String, dynamic> json) {
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
