import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/ui/screens/views/update_profile.dart';
import 'package:task_manager_app/utils/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          if (isProfileScreenOpen) {
            return;
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UpdateProfile(),
              ));
        },
        child: Row(
          children: [
            CircleAvatar(
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AuthController.userName.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
                Text(AuthController.userEmail.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 14)),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () => _onTapLogOutBtn(context),
            icon: const Icon(
              Icons.login_rounded,
              color: Colors.white,
            ))
      ],
    );
  }

  void _onTapLogOutBtn(BuildContext context) async {
    await AuthController.clearAccessToken();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (predicate) => false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
