import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/controllers/reset_password_controller.dart';
import 'package:task_manager_app/ui/screens/auth/forget_pin_verification_screen.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:get/get.dart';

class ForgetPassEmailVerificationScreen extends StatefulWidget {
  const ForgetPassEmailVerificationScreen({super.key});

  static String route = '/email-verification';

  @override
  State<ForgetPassEmailVerificationScreen> createState() =>
      _ForgetPassEmailVerificationScreenState();
}

class _ForgetPassEmailVerificationScreenState
    extends State<ForgetPassEmailVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();

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
                'Your Email Address',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'A 6 digit verification pin will send to your email address',
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
    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter valid email';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<ResetPasswordController>(builder: (controller) {
          return ElevatedButton(
              onPressed: _onTapSubmitButton,
              child: controller.isEmailLoading == true
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 14,
                      ),
                    ));
        }),
      ],
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
      _getRecoverVerifyEmail();
    }
  }

  Future<void> _getRecoverVerifyEmail() async {
    final bool isSuccess = await resetPasswordController
        .getRecoverVerifyEmail(_emailTEController.text);
    if (isSuccess) {
      snackBarWidget(
          context: context,
          message: resetPasswordController.successEmailMessage!);
      _onTapNextPage();
    } else {
      snackBarWidget(
          context: context,
          message: resetPasswordController.errorEmailMessage!,
          isError: true);
    }
  }

  void _onTapNextPage() {
    Get.toNamed(ForgetPinVerificationScreen.route);
  }

  void _onTapSignInButton() {
    Get.toNamed(SignInScreen.route);
  }
}
