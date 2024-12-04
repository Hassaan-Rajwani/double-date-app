class TicketsModel {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? attachment;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TicketsModel({
    this.sId,
    this.title,
    this.description,
    this.status,
    this.attachment,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  TicketsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    attachment = json['attachment'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['attachment'] = attachment;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
