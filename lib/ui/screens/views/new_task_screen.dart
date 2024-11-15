import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/new_task_controller.dart';
import 'package:task_manager_app/data/controllers/new_task_count_controller.dart';
import 'package:task_manager_app/data/models/task_count_model.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/ui/screens/views/add_new_task.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/ui/widgets/task_summary_card_widget.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  static String route = '/new-task';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  NewTaskController newTaskController = Get.find<NewTaskController>();
  NewTaskCountController newTaskCountController =
      Get.find<NewTaskCountController>();

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
                  GetBuilder<NewTaskController>(builder: (controller) {
                    return Expanded(
                      child: Visibility(
                        visible: !controller.isLoading,
                        replacement: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        child: controller.newTaskList.isEmpty
                            ? const Center(
                                child: Text('No Task Found!'),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  List<TaskModel> reversedList =
                                      controller.newTaskList.reversed.toList();
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
                                itemCount: controller.newTaskList.length,
                              ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildTaskCount() {
    return GetBuilder<NewTaskCountController>(
      builder: (controller) {
        Map<String, int> taskCounts = {
          'New': 0,
          'Progress': 0,
          'Completed': 0,
          'Canceled': 0,
        };
        for (TaskCountModel task in controller.newTaskCountList) {
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
      },
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
    final bool isRefreshed = await Get.toNamed(AddNewTask.route);
    if (isRefreshed) {
      _getNewTaskList();
      _getTaskStatusCount();
    }
  }

  Future<void> _getNewTaskList() async {
    final isSuccess = await newTaskController.getNewTaskList();
    if (isSuccess == false) {
      snackBarWidget(
          context: context,
          message: newTaskController.errorMessage!,
          isError: true);
    }
  }

  Future<void> _getTaskStatusCount() async {
    final isSuccess = await newTaskCountController.getNewTaskCountList();
    if (isSuccess == false) {
      snackBarWidget(
          context: context,
          message: newTaskCountController.errorMessage!,
          isError: true);
    }
  }
}
