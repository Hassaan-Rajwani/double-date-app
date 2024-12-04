class OtherContactsModel {
  String? name;
  String? number;

  OtherContactsModel({this.name, this.number});

  OtherContactsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['number'] = number;
    return data;
  }
}
