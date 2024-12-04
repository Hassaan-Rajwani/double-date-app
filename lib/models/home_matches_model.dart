import 'package:double_date/models/user_model.dart';

class HomeMatchesModel {
  UserModel? user;
  dynamic matchPercentage;

  HomeMatchesModel({this.user, this.matchPercentage});

  HomeMatchesModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
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
