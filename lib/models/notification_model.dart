class NotificationModel {
  String? sId;
  String? user;
  String? title;
  String? description;
  String? route;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationModel({
    this.sId,
    this.user,
    this.title,
    this.description,
    this.route,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    title = json['title'];
    description = json['description'];
    route = json['route'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['title'] = title;
    data['description'] = description;
    data['route'] = route;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
