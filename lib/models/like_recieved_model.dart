class LikeRecievedModel {
  RecievedUser? user;
  String? status;
  String? sId;

  LikeRecievedModel({this.user, this.status, this.sId});

  LikeRecievedModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? RecievedUser.fromJson(json['user']) : null;
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

class RecievedUser {
  Location? location;
  String? sId;
  String? profilePicture;
  String? name;
  Partner? partner;

  RecievedUser({this.location, this.sId, this.profilePicture, this.name, this.partner});

  RecievedUser.fromJson(Map<String, dynamic> json) {
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
