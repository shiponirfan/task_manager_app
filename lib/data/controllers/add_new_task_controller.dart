import 'package:get/get.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/utils/urls.dart';

class AddNewTaskController extends GetxController {
  String? _errorMessage;
  bool _isPending = false;
  bool _isRefreshed = false;

  String? get errorMessage => _errorMessage;

  bool get isPending => _isPending;

  bool get isRefreshed => _isRefreshed;

  Future<bool> addNewTask(String title, String description) async {
    bool isSuccess = false;
    _isPending = true;
    update();
    Map<String, dynamic> bodyData = {
      'title': title,
      'description': description,
      "status": 'New',
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: bodyData);
    if (response.isSuccess) {
      isSuccess = true;
      _isRefreshed = true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    _isPending = false;
    update();
    return isSuccess;
  }
}
