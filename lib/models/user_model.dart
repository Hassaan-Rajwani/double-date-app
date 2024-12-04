import 'package:double_date/models/home_matches_model.dart';
import 'package:double_date/models/post_model.dart';

class UserModel {
  Location? location;
  AboutYourself? aboutYourself;
  HomeMatchesModel? partner;
  String? type;
  String? sId;
  String? email;
  String? profilePicture;
  List<String>? interest;
  bool? isVerified;
  bool? isNotificationEnabled;
  bool? isProfileCompleted;
  List<String>? friendRequestsReceived;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? dateofbirth;
  String? gender;
  String? name;
  String? phone;
  String? countryCode;
  List<String>? relationshipGoals;
  String? seekingFor;
  String? otherInterest;
  String? otherSeekingFor;
  String? provider;
  List<PostModel>? posts;
  List<Shorts>? shorts;

  UserModel({
    this.location,
    this.aboutYourself,
    this.partner,
    this.type,
    this.sId,
    this.email,
    this.profilePicture,
    this.interest,
    this.isVerified,
    this.isProfileCompleted,
    this.friendRequestsReceived,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.dateofbirth,
    this.gender,
    this.name,
    this.phone,
    this.countryCode,
    this.relationshipGoals,
    this.seekingFor,
    this.otherInterest,
    this.otherSeekingFor,
    this.provider,
    this.posts,
    this.shorts,
    this.isNotificationEnabled,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    provider = json['provider'];
    aboutYourself = json['aboutYourself'] != null ? AboutYourself.fromJson(json['aboutYourself']) : null;
    type = json['type'];
    sId = json['_id'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    interest = json['interest']?.cast<String>();
    isVerified = json['isVerified'];
    isProfileCompleted = json['isProfileCompleted'];
    friendRequestsReceived = json['friendRequestsReceived']?.cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    dateofbirth = json['dateofbirth'];
    gender = json['gender'];
    isNotificationEnabled = json['isNotificationEnabled'];
    name = json['name'];
    phone = json['phone'];
    if (json['countryCode'] != null) {
      countryCode = json['countryCode'];
    }
    relationshipGoals = json['relationshipGoals']?.cast<String>();
    seekingFor = json['seekingFor'];
    otherInterest = json['otherInterest'];
    otherSeekingFor = json['otherSeekingFor'];

    if (json['partner'] is String) {
      partner = HomeMatchesModel.fromJson({'userId': json['partner']});
    } else if (json['partner'] is Map) {
      partner = HomeMatchesModel.fromJson(json['partner']);
    }

    if (json['posts'] != null) {
      posts = <PostModel>[];
      json['posts'].forEach((v) {
        posts!.add(PostModel.fromJson(v));
      });
    }
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
    data['type'] = type;
    data['isNotificationEnabled'] = isNotificationEnabled;
    data['_id'] = sId;
    data['provider'] = provider;
    data['email'] = email;
    data['profilePicture'] = profilePicture;
    data['interest'] = interest;
    data['isVerified'] = isVerified;
    data['isProfileCompleted'] = isProfileCompleted;
    data['friendRequestsReceived'] = friendRequestsReceived;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['dateofbirth'] = dateofbirth;
    data['gender'] = gender;
    data['name'] = name;
    data['phone'] = phone;
    data['relationshipGoals'] = relationshipGoals;
    data['seekingFor'] = seekingFor;
    data['otherInterest'] = otherInterest;
    data['otherSeekingFor'] = otherSeekingFor;
    data['countryCode'] = countryCode;
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    if (shorts != null) {
      data['shorts'] = shorts!.map((v) => v.toJson()).toList();
    }
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

class Shorts {
  ShortMedia? media;
  String? sId;
  String? user;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Shorts({this.media, this.sId, this.user, this.title, this.createdAt, this.updatedAt, this.iV});

  Shorts.fromJson(Map<String, dynamic> json) {
    media = json['media'] != null ? ShortMedia.fromJson(json['media']) : null;
    sId = json['_id'];
    user = json['user'];
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (media != null) {
      data['media'] = media!.toJson();
    }
    data['_id'] = sId;
    data['user'] = user;
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ShortMedia {
  String? mediaType;
  String? thumbnail;
  String? url;

  ShortMedia({this.mediaType, this.thumbnail, this.url});

  ShortMedia.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    thumbnail = json['thumbnail'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mediaType'] = mediaType;
    data['thumbnail'] = thumbnail;
    data['url'] = url;
    return data;
  }
}
