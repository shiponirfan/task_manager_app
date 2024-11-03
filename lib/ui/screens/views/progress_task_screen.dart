import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_list_model.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:task_manager_app/utils/urls.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _isLoading = false;
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getProgressTaskList();
        },
        child: ImageBackground(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: Visibility(
                    visible: !_isLoading,
                    replacement: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    child: _newTaskList.isEmpty
                        ? const Center(
                            child: Text('No Task Found!'),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              List<TaskModel> reversedList =
                                  _newTaskList.reversed.toList();
                              TaskModel task = reversedList[index];
                              return TaskCardWidget(
                                task: task,
                                isRefreshed: _getProgressTaskList,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 8,
                              );
                            },
                            itemCount: _newTaskList.length,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    setState(() {
      _newTaskList.clear();
      _isLoading = true;
    });
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProgressTaskList);
    if (response.isSuccess) {
      TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
    } else {
      snackBarWidget(
          context: context, message: response.errorMessage, isError: true);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
