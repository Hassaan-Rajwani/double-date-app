class PostModel {
  String? sId;
  User? user;
  String? title;
  String? description;
  List<Media>? media;
  int? share;
  List<Likes>? likes;
  List<Comments>? comments;
  LikedByOwn? likedByOwn;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PostModel({
    this.sId,
    this.user,
    this.title,
    this.description,
    this.media,
    this.share,
    this.likes,
    this.comments,
    this.likedByOwn,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    title = json['title'];
    description = json['description'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    share = json['share'];
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    likedByOwn = json['likedByOwn'] != null ? LikedByOwn.fromJson(json['likedByOwn']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['title'] = title;
    data['description'] = description;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    data['share'] = share;
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (likedByOwn != null) {
      data['likedByOwn'] = likedByOwn!.toJson();
    }
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

class Likes {
  String? type;
  User? user;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Likes({this.type, this.user, this.sId, this.createdAt, this.updatedAt});

  Likes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class LikeUser {
  String? sId;
  String? name;

  LikeUser({this.sId, this.name});

  LikeUser.fromJson(Map<String, dynamic> json) {
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

class LikedByOwn {
  String? type;

  LikedByOwn({this.type});

  LikedByOwn.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    return data;
  }
}

class Comments {
  String? text;
  User? user;
  PictureModel? picture;
  List<Replies>? replies;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Comments({
    this.text,
    this.user,
    this.replies,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.picture,
  });

  Comments.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    picture = json['picture'] != null ? PictureModel.fromJson(json['picture']) : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (picture != null) {
      data['picture'] = picture!.toJson();
    }
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Replies {
  User? user;
  String? text;
  String? sId;
  String? createdAt;
  PictureModel? picture;
  String? updatedAt;

  Replies({
    this.user,
    this.text,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.picture,
  });

  Replies.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    picture = json['picture'] != null ? PictureModel.fromJson(json['picture']) : null;
    text = json['text'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (picture != null) {
      data['picture'] = picture!.toJson();
    }
    data['text'] = text;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class PictureModel {
  String? mediaUrl;
  String? mediaType;

  PictureModel({this.mediaUrl, this.mediaType});

  PictureModel.fromJson(Map<String, dynamic> json) {
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mediaUrl'] = mediaUrl;
    data['mediaType'] = mediaType;
    return data;
  }
}
