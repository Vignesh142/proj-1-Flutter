import 'package:flutter/material.dart';
import 'package:proj1/common/widgets/custom_shadebutton.dart';
import 'package:proj1/common/widgets/custom_textfield1.dart';
import 'package:proj1/constants/global_vars.dart';
import 'package:proj1/constants/utils.dart';
import 'package:proj1/features/auth/screens/signup_screen.dart';
import 'package:proj1/features/auth/services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signin-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();

  final AuthService authService = AuthService();

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _pswdController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pswdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(width: 10),
                    Image.asset(GlobalVariables.helloImg,
                        height: 35, width: 35, scale: 0.5),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Enter your details',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 40),
                formSignin(context),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showSnackBar(context, 'signin to signup');
                        Navigator.of(context)
                            .pushReplacementNamed(SignUpScreen.routeName);
                      },
                      child: shadeText('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form formSignin(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            labelText: 'Email',
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Enter your Email';
              } else if (!val.contains('@')) {
                return 'Enter a valid Email';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: _pswdController,
            labelText: 'Password',
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Enter your Password';
              } else if (val.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => {Navigator.of(context).pushNamed('home')},
                child: shadeText('Forget Password?'),
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomShadeButton(
            text: 'Login',
            onPressed: () {
              if (_signInFormKey.currentState!.validate()) {
                signInUser();
              }
            },
          ),
        ],
      ),
    );
  }
}
