import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/auth_controller.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/updated_profile_details_model.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/ui/screens/views/update_profile.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:task_manager_app/utils/urls.dart';

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
  UserModel userDetails = UserModel(
    firstName: AuthController.userData!.firstName,
    lastName: AuthController.userData!.lastName,
    email: AuthController.userData!.email,
    photo: AuthController.userData!.photo,
  );

  @override
  void initState() {
    super.initState();
    _getUpdatedProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = base64Decode(userDetails.photo ?? '');
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          if (widget.isProfileScreenOpen) {
            return;
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProfile(
                  getUpdatedProfileDetails: _getUpdatedProfileDetails,
                ),
              ));
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
                Text(userDetails.fullName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
                Text(userDetails.email ?? '',
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

  Future<void> _getUpdatedProfileDetails() async {
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.updateProfileDetails);
    if (response.isSuccess) {
      UpdateProfileDetailsModel updateProfileDetailsModel =
          UpdateProfileDetailsModel.fromJson(response.responseData);
      setState(() {
        userDetails = updateProfileDetailsModel.updatedProfileDetails?.first ??
            UserModel();
      });
      await AuthController.saveUserInfo(
          updateProfileDetailsModel.updatedProfileDetails!.first);
    } else {
      snackBarWidget(
          context: context, message: response.errorMessage, isError: true);
    }
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
