import 'package:get/get.dart';
import 'package:task_manager_app/data/controllers/add_new_task_controller.dart';
import 'package:task_manager_app/data/controllers/canceled_task_controller.dart';
import 'package:task_manager_app/data/controllers/completed_task_controller.dart';
import 'package:task_manager_app/data/controllers/new_task_controller.dart';
import 'package:task_manager_app/data/controllers/new_task_count_controller.dart';
import 'package:task_manager_app/data/controllers/progress_task_controller.dart';
import 'package:task_manager_app/data/controllers/reset_password_controller.dart';
import 'package:task_manager_app/data/controllers/sign_in_controller.dart';
import 'package:task_manager_app/data/controllers/sign_up_controller.dart';
import 'package:task_manager_app/data/controllers/update_profile_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(AddNewTaskController());
    Get.put(CanceledTaskController());
    Get.put(CompletedTaskController());
    Get.put(NewTaskController());
    Get.put(NewTaskCountController());
    Get.put(ProgressTaskController());
    Get.put(UpdateProfileController());
    Get.put(ResetPasswordController());
  }
}
