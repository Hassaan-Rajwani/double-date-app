class ReportedUserModel {
  String? sId;
  ReportedBy? reportedBy;
  String? reason;
  ReportedBy? reportedTo;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ReportedUserModel({
    this.sId,
    this.reportedBy,
    this.reason,
    this.reportedTo,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ReportedUserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    reportedBy = json['reportedBy'] != null ? ReportedBy.fromJson(json['reportedBy']) : null;
    reason = json['reason'];
    reportedTo = json['reportedTo'] != null ? ReportedBy.fromJson(json['reportedTo']) : null;
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (reportedBy != null) {
      data['reportedBy'] = reportedBy!.toJson();
    }
    data['reason'] = reason;
    if (reportedTo != null) {
      data['reportedTo'] = reportedTo!.toJson();
    }
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ReportedBy {
  String? sId;
  String? profilePicture;
  String? dateofbirth;
  String? name;

  ReportedBy({this.sId, this.profilePicture, this.dateofbirth, this.name});

  ReportedBy.fromJson(Map<String, dynamic> json) {
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
