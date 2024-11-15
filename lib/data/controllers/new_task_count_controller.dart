import 'package:get/get.dart';
import 'package:task_manager_app/data/models/all_task_status_count_model.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_count_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/utils/urls.dart';

class NewTaskCountController extends GetxController {
  String? _errorMessage;
  bool _isLoading = false;
  List<TaskCountModel> _newTaskCountList = [];

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  List<TaskCountModel> get newTaskCountList => _newTaskCountList;

  Future<bool> getNewTaskCountList() async {
    bool isSuccess = false;
    _newTaskCountList.clear();
    _isLoading = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getTaskStatusCount);

    if (response.isSuccess) {
      AllTaskStatusCountModel allTaskStatusCountModel =
          AllTaskStatusCountModel.fromJson(response.responseData);
      _newTaskCountList = allTaskStatusCountModel.taskCount ?? [];
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
