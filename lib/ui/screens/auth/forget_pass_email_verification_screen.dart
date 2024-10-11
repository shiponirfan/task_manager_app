import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/auth/forget_pin_verification_screen.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/utils/app_colors.dart';

class ForgetPassEmailVerificationScreen extends StatefulWidget {
  const ForgetPassEmailVerificationScreen({super.key});

  @override
  State<ForgetPassEmailVerificationScreen> createState() => _ForgetPassEmailVerificationScreenState();
}

class _ForgetPassEmailVerificationScreenState extends State<ForgetPassEmailVerificationScreen> {
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
                    style: textTheme.titleSmall?.copyWith(
                      color: Colors.grey
                    ),
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
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Email',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: _onTapSubmitButton,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  shape: BoxShape.circle),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 14,
              ),
            )),
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
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgetPinVerificationScreen(),
        ));
  }

  void _onTapSignInButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ));
  }
}
