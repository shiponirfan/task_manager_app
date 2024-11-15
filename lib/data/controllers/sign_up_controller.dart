import 'package:get/get.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/utils/urls.dart';

class SignUpController extends GetxController {
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getSignUp(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    bool isSuccess = false;
    Map<String, dynamic> body = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'password': password
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registrationUrl,
      body: body,
    );
    if (response.isSuccess) {
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.responseData?['data'];
    }
    return isSuccess;
  }
}
