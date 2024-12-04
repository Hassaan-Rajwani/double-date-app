class DatePlannerModel {
  String? sId;
  String? title;
  String? picture;
  String? description;
  String? createdAt;
  String? updatedAt;
  dynamic status;
  int? iV;

  DatePlannerModel({
    this.sId,
    this.title,
    this.picture,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.iV,
  });

  DatePlannerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    picture = json['picture'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['status'] != null) {
      status = json['status'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['picture'] = picture;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (status != null) {
      data['status'] = status;
    } else {
      data['status'] = '';
    }
    return data;
  }
}
