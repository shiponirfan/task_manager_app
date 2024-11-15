import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/canceled_task_controller.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  static String route = '/canceled-task';

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  CanceledTaskController canceledTaskController =
      Get.find<CanceledTaskController>();

  @override
  void initState() {
    super.initState();
    _getCanceledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getCanceledTaskList();
        },
        child: ImageBackground(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                GetBuilder<CanceledTaskController>(builder: (controller) {
                  return Expanded(
                    child: Visibility(
                      visible: !controller.isLoading,
                      replacement: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: controller.canceledTaskList.isEmpty
                          ? const Center(
                              child: Text('No Task Found!'),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                List<TaskModel> reversedList = controller
                                    .canceledTaskList.reversed
                                    .toList();
                                TaskModel task = reversedList[index];
                                return TaskCardWidget(
                                  task: task,
                                  isRefreshed: _getCanceledTaskList,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: controller.canceledTaskList.length,
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

  Future<void> _getCanceledTaskList() async {
    final isSuccess = await canceledTaskController.getCanceledTaskList();
    if (isSuccess == false) {
      snackBarWidget(
          context: context,
          message: canceledTaskController.errorMessage!,
          isError: true);
    }
  }
}
