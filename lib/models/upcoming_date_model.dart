import 'package:double_date/models/doube_date_offer_model.dart';

class UpcomingDateModel {
  String? sId;
  DoubleDateOfferModel? doubleDate;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<FriendsSubscribed>? friendsSubscribed;

  UpcomingDateModel({
    this.sId,
    this.doubleDate,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.friendsSubscribed,
  });

  UpcomingDateModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    doubleDate = json['doubleDate'] != null ? DoubleDateOfferModel.fromJson(json['doubleDate']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['friendsSubscribed'] != null) {
      friendsSubscribed = <FriendsSubscribed>[];
      json['friendsSubscribed'].forEach((v) {
        friendsSubscribed!.add(FriendsSubscribed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (doubleDate != null) {
      data['doubleDate'] = doubleDate!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (friendsSubscribed != null) {
      data['friendsSubscribed'] = friendsSubscribed!.map((v) => v.toJson()).toList();
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

class FriendsSubscribed {
  String? friendName;

  FriendsSubscribed({this.friendName});

  FriendsSubscribed.fromJson(Map<String, dynamic> json) {
    friendName = json['friendName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['friendName'] = friendName;
    return data;
  }
}
