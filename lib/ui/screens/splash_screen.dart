import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/ui/utils/image_path.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToNextScreen();
  }

  Future<void> _goToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ImageBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagePath.logoPng,
              width: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Task Manager',
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
    ));
  }
}
