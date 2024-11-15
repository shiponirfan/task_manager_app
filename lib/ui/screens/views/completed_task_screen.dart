import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/completed_task_controller.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  static String route = '/completed-task';

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  CompletedTaskController completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTaskList();
        },
        child: ImageBackground(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                GetBuilder<CompletedTaskController>(builder: (controller) {
                  return Expanded(
                    child: Visibility(
                      visible: !controller.isLoading,
                      replacement: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: controller.completedTaskList.isEmpty
                          ? const Center(
                              child: Text('No Task Found!'),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                List<TaskModel> reversedList = controller
                                    .completedTaskList.reversed
                                    .toList();
                                TaskModel task = reversedList[index];
                                return TaskCardWidget(
                                  task: task,
                                  isRefreshed: _getCompletedTaskList,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: controller.completedTaskList.length,
                            ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    final isSuccess = await completedTaskController.getCompletedTaskList();
    if (isSuccess == false) {
      snackBarWidget(
          context: context,
          message: completedTaskController.errorMessage!,
          isError: true);
    }
  }
}
