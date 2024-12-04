import 'package:double_date/models/user_model.dart';

class PairedUserModel {
  User? user;

  PairedUserModel({this.user});

  PairedUserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  Location? location;
  AboutYourself? aboutYourself;
  String? sId;
  String? email;
  String? profilePicture;
  List<Shorts>? shorts;
  List<String>? relationshipGoals;
  List<String>? interest;
  bool? isVerified;
  bool? isProfileCompleted;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? city;
  String? countryCode;
  String? dateofbirth;
  String? gender;
  String? name;
  String? otherInterest;
  String? otherSeekingFor;
  String? phone;
  String? seekingFor;
  String? state;
  Partner? partner;

  User({
    this.location,
    this.aboutYourself,
    this.sId,
    this.email,
    this.profilePicture,
    this.shorts,
    this.relationshipGoals,
    this.interest,
    this.isVerified,
    this.isProfileCompleted,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.city,
    this.countryCode,
    this.dateofbirth,
    this.gender,
    this.name,
    this.otherInterest,
    this.otherSeekingFor,
    this.phone,
    this.seekingFor,
    this.state,
    this.partner,
  });

  User.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    aboutYourself = json['aboutYourself'] != null ? AboutYourself.fromJson(json['aboutYourself']) : null;
    sId = json['_id'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    relationshipGoals = json['relationshipGoals'].cast<String>();
    interest = json['interest'].cast<String>();
    isVerified = json['isVerified'];
    isProfileCompleted = json['isProfileCompleted'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    city = json['city'];
    countryCode = json['countryCode'];
    dateofbirth = json['dateofbirth'];
    gender = json['gender'];
    name = json['name'];
    otherInterest = json['otherInterest'];
    otherSeekingFor = json['otherSeekingFor'];
    phone = json['phone'];
    seekingFor = json['seekingFor'];
    state = json['state'];
    partner = json['partner'] != null ? Partner.fromJson(json['partner']) : null;
    if (json['shorts'] != null) {
      shorts = <Shorts>[];
      json['shorts'].forEach((v) {
        shorts!.add(Shorts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (aboutYourself != null) {
      data['aboutYourself'] = aboutYourself!.toJson();
    }
    data['_id'] = sId;
    data['email'] = email;
    data['profilePicture'] = profilePicture;
    if (shorts != null) {
      data['shorts'] = shorts!.map((v) => v.toJson()).toList();
    }
    data['relationshipGoals'] = relationshipGoals;
    data['interest'] = interest;
    data['isVerified'] = isVerified;
    data['isProfileCompleted'] = isProfileCompleted;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['city'] = city;
    data['countryCode'] = countryCode;
    data['dateofbirth'] = dateofbirth;
    data['gender'] = gender;
    data['name'] = name;
    data['otherInterest'] = otherInterest;
    data['otherSeekingFor'] = otherSeekingFor;
    data['phone'] = phone;
    data['seekingFor'] = seekingFor;
    data['state'] = state;
    if (partner != null) {
      data['partner'] = partner!.toJson();
    }
    if (shorts != null) {
      data['shorts'] = shorts!.map((v) => v.toJson()).toList();
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

class AboutYourself {
  String? description;
  dynamic height;
  String? sexualOrientation;
  String? otherSexualOrientation;

  AboutYourself({this.description, this.height, this.sexualOrientation, this.otherSexualOrientation});

  AboutYourself.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    height = json['height'];
    sexualOrientation = json['sexualOrientation'];
    otherSexualOrientation = json['otherSexualOrientation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['height'] = height;
    data['sexualOrientation'] = sexualOrientation;
    data['otherSexualOrientation'] = otherSexualOrientation;
    return data;
  }
}

class Partner {
  User? user;
  dynamic matchPercentage;

  Partner({this.user, this.matchPercentage});

  Partner.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    matchPercentage = json['matchPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['matchPercentage'] = matchPercentage;
    return data;
  }
}

class RecievedRequests {
  String? user;
  String? status;
  String? sId;

  RecievedRequests({this.user, this.status, this.sId});

  RecievedRequests.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['status'] = status;
    data['_id'] = sId;
    return data;
  }
}
