import 'package:get/get.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_list_model.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/utils/urls.dart';

class CanceledTaskController extends GetxController {
  String? _errorMessage;
  bool _isLoading = false;
  List<TaskModel> _canceledTaskList = [];

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  List<TaskModel> get canceledTaskList => _canceledTaskList;

  Future<bool> getCanceledTaskList() async {
    bool isSuccess = false;
    _canceledTaskList.clear();
    _isLoading = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getCanceledTaskList);
    if (response.isSuccess) {
      TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _canceledTaskList = taskListModel.taskList ?? [];
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
