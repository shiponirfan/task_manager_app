import 'package:get/get.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/utils/urls.dart';

class ResetPasswordController extends GetxController {
  String? email;
  String? _otp;
  String? _password;
  String? _errorMessage;
  String? _successMessage;

  String? get errorMessage => _errorMessage;

  String? get successMessage => _successMessage;

  String? _errorOtpMessage;
  String? _successOtpMessage;

  String? get errorOtpMessage => _errorOtpMessage;

  String? get successOtpMessage => _successOtpMessage;

  String? _errorEmailMessage;
  String? _successEmailMessage;

  String? get errorEmailMessage => _errorEmailMessage;

  String? get successEmailMessage => _successEmailMessage;

  Future<bool> getResetPassword(String getPassword) async {
    _password = getPassword;
    update();
    bool isSuccess = false;
    Map<String, dynamic> body = {
      "email": email,
      "OTP": _otp,
      "password": _password,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.recoverResetPassword, body: body);
    if (response.isSuccess) {
      _successMessage = response.responseData['data'];
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.responseData['data'];
      update();
    }
    return isSuccess;
  }

  Future<bool> getRecoverVerifyOtp(String getOtp) async {
    _otp = getOtp;
    update();
    bool isSuccess = false;
    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.recoverVerifyOtp(email!, int.parse(_otp!)));
    if (response.isSuccess) {
      _successOtpMessage = response.responseData['data'];
      isSuccess = true;
      update();
    } else {
      _errorOtpMessage = response.responseData['data'];
      update();
    }
    return isSuccess;
  }

  Future<bool> getRecoverVerifyEmail(String getEmail) async {
    email = getEmail;
    update();
    bool isSuccess = false;
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.recoverVerifyEmail(email!));
    if (response.isSuccess) {
      _successEmailMessage = response.responseData['data'];
      isSuccess = true;
      update();
    } else {
      _errorEmailMessage = response.responseData['data'];
      update();
    }
    return isSuccess;
  }
}
