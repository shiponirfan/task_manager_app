import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:task_manager_app/utils/urls.dart';

class ForgetSetPasswordScreen extends StatefulWidget {
  const ForgetSetPasswordScreen(
      {super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<ForgetSetPasswordScreen> createState() =>
      _ForgetSetPasswordScreenState();
}

class _ForgetSetPasswordScreenState extends State<ForgetSetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  bool _isLoading = false;

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
          ElevatedButton(
              onPressed: _onTapSubmitButton,
              child: _isLoading == true
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    )),
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

  void _onTapSetPassword() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ));
  }

  void _onTapSignInButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ));
  }

  Future<void> _getRecoverResetPassword() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> body = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.recoverResetPassword, body: body);
    if (response.isSuccess) {
      setState(() {
        _isLoading = false;
      });
      snackBarWidget(context: context, message: response.responseData['data']);
      _onTapSetPassword();
    } else {
      snackBarWidget(
          context: context,
          message: response.responseData['data'],
          isError: true);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
