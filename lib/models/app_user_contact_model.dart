import 'package:double_date/models/user_model.dart';

class AppUserContactModel {
  String? sId;
  String? email;
  String? profilePicture;
  String? dateofbirth;
  String? name;
  String? phone;
  Location? location;
  Partner? partner;

  AppUserContactModel({
    this.sId,
    this.email,
    this.profilePicture,
    this.dateofbirth,
    this.name,
    this.phone,
    this.location,
    this.partner,
  });

  AppUserContactModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    dateofbirth = json['dateofbirth'];
    name = json['name'];
    phone = json['phone'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    partner = json['partner'] != null ? Partner.fromJson(json['partner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['profilePicture'] = profilePicture;
    data['dateofbirth'] = dateofbirth;
    data['name'] = name;
    data['phone'] = phone;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (partner != null) {
      data['partner'] = partner!.toJson();
    }
    return data;
  }
}

class Partner {
  String? sId;
  String? email;
  String? profilePicture;
  String? dateofbirth;
  String? name;
  String? phone;
  Location? location;

  Partner({
    this.sId,
    this.email,
    this.profilePicture,
    this.dateofbirth,
    this.name,
    this.phone,
    this.location,
  });

  Partner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    dateofbirth = json['dateofbirth'];
    name = json['name'];
    phone = json['phone'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['profilePicture'] = profilePicture;
    data['dateofbirth'] = dateofbirth;
    data['name'] = name;
    data['phone'] = phone;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}
