import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/progress_task_controller.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  static String route = '/progress-task';

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  ProgressTaskController progressTaskController =
      Get.find<ProgressTaskController>();

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
                GetBuilder<ProgressTaskController>(builder: (controller) {
                  return Expanded(
                    child: Visibility(
                      visible: !controller.isLoading,
                      replacement: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: controller.progressTaskList.isEmpty
                          ? const Center(
                              child: Text('No Task Found!'),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                List<TaskModel> reversedList = controller
                                    .progressTaskList.reversed
                                    .toList();
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
                              itemCount: controller.progressTaskList.length,
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

  Future<void> _getProgressTaskList() async {
    final isSuccess = await progressTaskController.getProgressTaskList();
    if (isSuccess == false) {
      snackBarWidget(
          context: context,
          message: progressTaskController.errorMessage!,
          isError: true);
    }
  }
}
