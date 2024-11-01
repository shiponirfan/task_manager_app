import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_list_model.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:task_manager_app/utils/urls.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _isLoading = false;
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor.withOpacity(0.08),
      body: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTaskList();
        },
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
                            TaskModel task = _newTaskList[index];
                            return TaskCardWidget(
                              task: task,
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
    );
  }

  Future<void> _getCompletedTaskList() async {
    setState(() {
      _newTaskList.clear();
      _isLoading = true;
    });
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getCompletedTaskList);
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
