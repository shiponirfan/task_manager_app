import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/all_task_status_count_model.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_count_model.dart';
import 'package:task_manager_app/data/models/task_list_model.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/screens/views/add_new_task.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/ui/widgets/task_summary_card_widget.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:task_manager_app/utils/urls.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  static String route = '/new-task';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _isLoading = false;
  List<TaskModel> _newTaskList = [];
  List<TaskCountModel> _taskCount = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _buildFloatingActionButton(context),
        body: ImageBackground(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: () async {
                _getNewTaskList();
                _getTaskStatusCount();
              },
              child: Column(
                children: [
                  _buildTaskCount(),
                  const SizedBox(
                    height: 8,
                  ),
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
                                  isRefreshed: () {
                                    _getNewTaskList();
                                    _getTaskStatusCount();
                                  },
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
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildTaskCount() {
    Map<String, int> taskCounts = {
      'New': 0,
      'Progress': 0,
      'Completed': 0,
      'Canceled': 0,
    };

    for (TaskCountModel task in _taskCount) {
      if (taskCounts.containsKey(task.sId)) {
        taskCounts[task.sId!] = task.sum ?? 0;
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['New', 'Progress', 'Completed', 'Canceled'].map((task) {
          return TaskSummaryCardWidget(
            count: taskCounts[task]!,
            taskName: task,
          );
        }).toList(),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onTapFAB,
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }

  void _onTapFAB() async {
    final bool isRefreshed = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddNewTask(),
        ));
    if (isRefreshed) {
      _getNewTaskList();
      _getTaskStatusCount();
    }
  }

  Future<void> _getNewTaskList() async {
    setState(() {
      _newTaskList.clear();
      _isLoading = true;
    });
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getNewTaskList);
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

  Future<void> _getTaskStatusCount() async {
    setState(() {
      _taskCount.clear();
      _isLoading = true;
    });
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      AllTaskStatusCountModel allTaskStatusCountModel =
          AllTaskStatusCountModel.fromJson(response.responseData);
      _taskCount = allTaskStatusCountModel.taskCount ?? [];
    } else {
      snackBarWidget(
          context: context, message: response.errorMessage, isError: true);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
