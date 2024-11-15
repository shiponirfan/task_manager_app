import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/auth_controller.dart';
import 'package:task_manager_app/data/controllers/update_profile_controller.dart';
import 'package:task_manager_app/ui/widgets/appbar_widget.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  static String route = '/update-profile';

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UpdateProfileController updateProfileController =
      Get.find<UpdateProfileController>();

  void setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _mobileTEController.text = AuthController.userData?.mobile ?? '';
  }

  // XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    setUserData();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const AppBarWidget(
        isProfileScreenOpen: true,
      ),
      body: ImageBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 44,
                ),
                Text(
                  'Update Profile',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _buildUpdateProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _chooseYourPhoto(),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            enabled: false,
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _firstNameTEController,
            decoration: const InputDecoration(
              hintText: 'First Name',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter first name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _lastNameTEController,
            decoration: const InputDecoration(
              hintText: 'Last Name',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter last name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _mobileTEController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Mobile',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter mobile number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _passwordTEController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GetBuilder<UpdateProfileController>(builder: (controller) {
            return ElevatedButton(
                onPressed: _onTapSubmitButton,
                child: Container(
                    padding: const EdgeInsets.all(4),
                    child: controller.isPending
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Update',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )));
          }),
        ],
      ),
    );
  }

  Widget _chooseYourPhoto() {
    return GestureDetector(
      onTap: _imagePicker,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  )),
              alignment: Alignment.center,
              child: const Text(
                'Photos',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GetBuilder<UpdateProfileController>(builder: (controller) {
              return Text(_getSelectedImageTitle(controller));
            })
          ],
        ),
      ),
    );
  }

  String _getSelectedImageTitle(UpdateProfileController controller) {
    if (controller.selectedImage != null) {
      return controller.selectedImage!.name.substring(0, 20);
    }
    return 'Choose Your Photo';
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _onTapUpdateProfile();
    }
  }

  void _onTapUpdateProfile() async {
    final bool isSuccess = await updateProfileController.postUpdateProfile(
      email: _emailTEController.text.trim(),
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      mobile: _mobileTEController.text.trim(),
      password: _passwordTEController.text,
    );
    if (isSuccess) {
      snackBarWidget(context: context, message: 'Profile Updated Successful');
    } else {
      snackBarWidget(
          context: context,
          message: updateProfileController.errorPostMessage ??
              'Something went wrong!');
    }
  }

  Future<void> _imagePicker() async {
    await updateProfileController.imagePicker();
  }
}
