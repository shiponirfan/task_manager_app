import 'package:task_manager_app/data/models/task_count_model.dart';

class AllTaskStatusCountModel {
  String? status;
  List<TaskCountModel>? taskCount;

  AllTaskStatusCountModel({this.status, this.taskCount});

  AllTaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCount = <TaskCountModel>[];
      json['data'].forEach((v) {
        taskCount!.add(new TaskCountModel.fromJson(v));
      });
    }
  }
}
