import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/screens/auth/forget_pin_verification_screen.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:task_manager_app/utils/urls.dart';

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
        ElevatedButton(
            onPressed: _onTapSubmitButton,
            child: _isLoading == true
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
    if (_formKey.currentState!.validate()) {
      _getRecoverVerifyEmail();
    }
  }

  void _onTapNextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgetPinVerificationScreen(
            email: _emailTEController.text,
          ),
        ));
  }

  void _onTapSignInButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ));
  }

  Future<void> _getRecoverVerifyEmail() async {
    setState(() {
      _isLoading = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.recoverVerifyEmail(_emailTEController.text));
    if (response.isSuccess) {
      setState(() {
        _isLoading = false;
      });
      snackBarWidget(context: context, message: response.responseData['data']);
      _onTapNextPage();
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
