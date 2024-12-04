class ReportedPostModel {
  String? sId;
  String? reason;
  Post? post;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ReportedPostModel({
    this.sId,
    this.reason,
    this.post,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ReportedPostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    reason = json['reason'];
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['reason'] = reason;
    if (post != null) {
      data['post'] = post!.toJson();
    }
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class User {
  String? sId;
  String? profilePicture;
  String? dateofbirth;
  String? name;

  User({this.sId, this.profilePicture, this.dateofbirth, this.name});

  User.fromJson(Map<String, dynamic> json) {
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

class Post {
  String? sId;
  String? title;
  User? user;
  String? description;
  List<Media>? media;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Post({
    this.sId,
    this.user,
    this.title,
    this.description,
    this.media,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    description = json['description'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Media {
  String? mediaType;
  String? url;
  String? sId;

  Media({this.mediaType, this.url, this.sId});

  Media.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mediaType'] = mediaType;
    data['url'] = url;
    data['_id'] = sId;
    return data;
  }
}
