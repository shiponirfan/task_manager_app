import 'package:get/get.dart';
import 'package:task_manager_app/data/controllers/auth_controller.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/profile_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/utils/urls.dart';

class SignInController extends GetxController {
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getLogin(
    String email,
    String password,
  ) async {
    bool isSuccess = false;
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.loginUrl,
      body: body,
    );
    if (response.isSuccess) {
      ProfileModel userData = ProfileModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(userData.token!);
      await AuthController.saveUserInfo(userData.profileData!);
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.responseData?['data'];
    }
    return isSuccess;
  }
}
