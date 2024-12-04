import 'package:double_date/models/user_model.dart';

class DoubleDateOfferModel {
  Location? location;
  String? sId;
  String? name;
  int? price;
  int? discount;
  String? terms;
  List<String>? challenges;
  String? activity;
  String? startTime;
  String? endTime;
  String? detail;
  String? description;
  String? createdAt;
  String? updatedAt;
  bool? isSynced;
  int? iV;

  DoubleDateOfferModel({
    this.location,
    this.sId,
    this.name,
    this.price,
    this.discount,
    this.terms,
    this.challenges,
    this.activity,
    this.startTime,
    this.endTime,
    this.detail,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.isSynced,
    this.iV,
  });

  DoubleDateOfferModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    terms = json['terms'];
    challenges = json['challenges'].cast<String>();
    activity = json['activity'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    detail = json['detail'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isSynced = json['isSynced'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    data['discount'] = discount;
    data['terms'] = terms;
    data['challenges'] = challenges;
    data['activity'] = activity;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['detail'] = detail;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isSynced'] = isSynced;
    data['__v'] = iV;
    return data;
  }
}
