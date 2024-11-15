import 'dart:convert';
import 'package:get/get.dart';
import 'package:task_manager_app/data/controllers/auth_controller.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/updated_profile_details_model.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/utils/urls.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  String? _errorMessage;
  String? _errorPostMessage;
  bool _isPending = false;
  UserModel? _userDetails;
  XFile? _selectedImage;

  String? get errorMessage => _errorMessage;

  String? get errorPostMessage => _errorPostMessage;

  bool get isPending => _isPending;

  UserModel? get userDetails => _userDetails;

  XFile? get selectedImage => _selectedImage;

  Future<bool> getUpdatedProfileDetails() async {
    bool isSuccess = false;
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.updateProfileDetails);
    if (response.isSuccess) {
      UpdateProfileDetailsModel updateProfileDetailsModel =
          UpdateProfileDetailsModel.fromJson(response.responseData);
      _userDetails =
          updateProfileDetailsModel.updatedProfileDetails?.first ?? UserModel();
      await AuthController.saveUserInfo(
          updateProfileDetailsModel.updatedProfileDetails!.first);
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }

  Future<bool> postUpdateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    bool isSuccess = false;
    _isPending = true;
    update();
    Map<String, dynamic> body = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
    };

    if (password.isNotEmpty) {
      body['password'] = password;
    }

    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      body['photo'] = convertedImage;
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: body,
    );
    if (response.isSuccess) {
      await getUpdatedProfileDetails();
      isSuccess = true;
      update();
    } else {
      _errorPostMessage = response.errorMessage;
    }
    _isPending = false;
    update();
    return isSuccess;
  }

  Future<void> imagePicker() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      update();
    }
  }
}
