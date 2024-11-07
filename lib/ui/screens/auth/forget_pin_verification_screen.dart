import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/screens/auth/forget_set_password_screen.dart';
import 'package:task_manager_app/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:task_manager_app/utils/urls.dart';

class ForgetPinVerificationScreen extends StatefulWidget {
  const ForgetPinVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<ForgetPinVerificationScreen> createState() =>
      _ForgetPinVerificationScreenState();
}

class _ForgetPinVerificationScreenState
    extends State<ForgetPinVerificationScreen> {
  bool _isLoading = false;
  final TextEditingController _otp = TextEditingController();

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
                'PIN Verification',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'A 6 digit verification pin send to your email address',
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
        PinCodeTextField(
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              selectedColor: Colors.green),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: false,
          appContext: context,
          controller: _otp,
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
                    'Verify',
                    style: TextStyle(color: Colors.white),
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
    _getRecoverVerifyOtp();
  }

  void _onTapNextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgetSetPasswordScreen(
            email: widget.email,
            otp: _otp.text,
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

  Future<void> _getRecoverVerifyOtp() async {
    setState(() {
      _isLoading = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.recoverVerifyOtp(widget.email, int.parse(_otp.text)));
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
