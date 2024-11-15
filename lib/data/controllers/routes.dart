import 'package:flutter/cupertino.dart';
import 'package:task_manager_app/ui/screens/auth/forget_pass_email_verification_screen.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';
import 'package:task_manager_app/ui/screens/views/add_new_task.dart';
import 'package:task_manager_app/ui/screens/views/canceled_task_screen.dart';
import 'package:task_manager_app/ui/screens/views/completed_task_screen.dart';
import 'package:task_manager_app/ui/screens/views/main_nav_screen.dart';
import 'package:task_manager_app/ui/screens/views/new_task_screen.dart';
import 'package:task_manager_app/ui/screens/views/progress_task_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> route = {
    SplashScreen.route: (context) => const SplashScreen(),
    SignInScreen.route: (context) => const SignInScreen(),
    SignUpScreen.route: (context) => const SignUpScreen(),
    // ForgetSetPasswordScreen.route : ForgetSetPasswordScreen(),
    // ForgetPinVerificationScreen.route : ForgetPinVerificationScreen(),
    ForgetPassEmailVerificationScreen.route: (context) =>
        const ForgetPassEmailVerificationScreen(),
    AddNewTask.route: (context) => const AddNewTask(),
    CanceledTaskScreen.route: (context) => const CanceledTaskScreen(),
    CompletedTaskScreen.route: (context) => const CompletedTaskScreen(),
    NewTaskScreen.route: (context) => const NewTaskScreen(),
    ProgressTaskScreen.route: (context) => const ProgressTaskScreen(),
    // UpdateProfile.route : UpdateProfile(),
    MainNavScreen.route: (context) => const MainNavScreen(),
  };
}
