import 'package:get/get.dart';
import 'package:task_manager_app/data/controllers/sign_in_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => SignInController());
  }
}
