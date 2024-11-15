import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/reset_password_controller.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class ForgetSetPasswordScreen extends StatefulWidget {
  const ForgetSetPasswordScreen({super.key});

  static String route = '/set-password';

  @override
  State<ForgetSetPasswordScreen> createState() =>
      _ForgetSetPasswordScreenState();
}

class _ForgetSetPasswordScreenState extends State<ForgetSetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  ResetPasswordController resetPasswordController =
      Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ImageBackground(
          child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set Password',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Minimum length password 8 character with Latter and Number combination',
                style: textTheme.titleSmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 15,
              ),
              _buildSingUpFormField(),
              const SizedBox(
                height: 25,
              ),
              _buildSignInText()
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildSingUpFormField() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordTEController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter valid password';
              }
              if (value!.length < 6) {
                return 'Please enter minimum 6 characters password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _confirmPasswordTEController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Confirm Password',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (_passwordTEController.text !=
                  _confirmPasswordTEController.text) {
                return 'Password not matched';
              }
              if (value!.length < 6) {
                return 'Please enter minimum 6 characters password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<ResetPasswordController>(builder: (controller) {
            return ElevatedButton(
                onPressed: _onTapSubmitButton,
                child: controller.isLoading == true
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ));
          }),
        ],
      ),
    );
  }

  Center _buildSignInText() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  text: "Have account? ",
                  children: [
                TextSpan(
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600),
                  text: 'Sign in',
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTapSignInButton,
                )
              ])),
        ],
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _getRecoverResetPassword();
    }
  }

  Future<void> _getRecoverResetPassword() async {
    final bool isSuccess = await resetPasswordController
        .getResetPassword(_confirmPasswordTEController.text);

    if (isSuccess) {
      snackBarWidget(
          context: context, message: resetPasswordController.successMessage!);
      Get.offNamed(SignInScreen.route);
    } else {
      snackBarWidget(
          context: context,
          message: resetPasswordController.errorMessage!,
          isError: true);
    }
  }

  void _onTapSignInButton() {
    Get.toNamed(SignInScreen.route);
  }
}
