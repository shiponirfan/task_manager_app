import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/utils/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      title: Row(
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shipon Irfan',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
              Text('shiponirfan.dev@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                  (predicate) => false);
            },
            icon: const Icon(
              Icons.login_rounded,
              color: Colors.white,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
