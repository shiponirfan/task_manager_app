import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/auth_controller.dart';
import 'package:task_manager_app/data/controllers/update_profile_controller.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/ui/screens/views/update_profile.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    super.initState();
    _getUpdatedProfileDetails();
  }

  UpdateProfileController updateProfileController =
      Get.find<UpdateProfileController>();

  UserModel userDetails = UserModel(
    firstName: AuthController.userData!.firstName,
    lastName: AuthController.userData!.lastName,
    email: AuthController.userData!.email,
    photo: AuthController.userData!.photo,
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      title: GetBuilder<UpdateProfileController>(builder: (controller) {
        Uint8List imageBytes =
            base64Decode(controller.userDetails?.photo ?? userDetails.photo ?? '');
        return GestureDetector(
          onTap: () {
            if (widget.isProfileScreenOpen) {
              return;
            }
            Get.toNamed(UpdateProfile.route);
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: imageBytes.isNotEmpty
                    ? Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      )
                    : Image.asset(
                        'assets/images/blank-profile-picture.png',
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.userDetails?.fullName ?? userDetails.fullName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                  Text(controller.userDetails?.email ?? userDetails.email  ?? '',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 14)),
                ],
              )
            ],
          ),
        );
      }),
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
    Get.offAllNamed(SignInScreen.route);
  }

  Future<void> _getUpdatedProfileDetails() async {
    final bool isSuccess =
        await updateProfileController.getUpdatedProfileDetails();
    if (isSuccess == false) {
      snackBarWidget(
          context: context,
          message:
              updateProfileController.errorMessage ?? 'Something went wrong!',
          isError: true);
    }
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
