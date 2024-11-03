import 'package:task_manager_app/data/models/user_model.dart';

class ProfileModel {
  String? status;
  UserModel? profileData;
  String? token;

  ProfileModel({this.status, this.profileData, this.token});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    profileData =
        json['data'] != null ? UserModel.fromJson(json['data']) : null;
    token = json['token'];
  }
}
