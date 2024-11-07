import 'package:task_manager_app/data/models/user_model.dart';

class UpdateProfileDetailsModel {
  String? status;
  List<UserModel>? updatedProfileDetails;

  UpdateProfileDetailsModel({this.status, this.updatedProfileDetails});

  UpdateProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      updatedProfileDetails = <UserModel>[];
      json['data'].forEach((v) {
        updatedProfileDetails!.add(UserModel.fromJson(v));
      });
    }
  }
}
