import 'package:flutter/material.dart';
import 'package:proj1/common/widgets/custom_shadebutton.dart';
import 'package:proj1/common/widgets/custom_textfield1.dart';
import 'package:proj1/constants/global_vars.dart';
import 'package:proj1/constants/utils.dart';
import 'package:proj1/features/auth/screens/membership_screen.dart';
import 'package:proj1/features/auth/screens/signin_screen.dart';
import 'package:proj1/features/auth/services/auth_service.dart';
// import 'package:proj1/constants/global_vars.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  MemberShipPlan? selectedPlan;

  List<MemberShipPlan> planOptions = [
    MemberShipPlan(6, '6 months'),
    MemberShipPlan(12, '12 months'),
    MemberShipPlan(18, '18 months'),
  ];

  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    selectedPlan = planOptions[0];
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _pswdController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _pswdController.text,
      name: _nameController.text,
      membership: selectedPlan!.label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 25),
              Text(
                'Enter your details',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              formSingUp(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      showSnackBar(context, 'signup to signin');
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName);
                    },
                    child: shadeText('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  Form formSingUp() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          CustomTextField(
              controller: _nameController,
              labelText: 'Name',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter your Name';
                }
                return null;
              }),
          const SizedBox(
            height: 30,
          ),
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
              }),
          const SizedBox(
            height: 30,
          ),
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
              }),
          const SizedBox(
            height: 30,
          ),
          CustomTextField(
              controller: _confirmPasswordController,
              labelText: 'Confirm Password',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter your Password';
                } else if (val.length < 6) {
                  return 'Password must be at least 6characters';
                }
                return null;
              }),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select your Plan',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Row(
                children: [
                  shadeText('view details'),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      showSnackBar(context, 'signup to signin');
                      Navigator.pushNamed(
                          context, MemberShipScreen.routeName);
                    },
                    child: 
                    Image.asset(GlobalVariables.question),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: choosePlan(),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomShadeButton(
              text: 'Register',
              onPressed: () {
                if (_signUpFormKey.currentState!.validate()) {
                  var x =
                      _pswdController.text == _confirmPasswordController.text;
                  if (!x) {
                    showSnackBar(
                        context, 'Password and Confirm Password do not match');
                  } else {
                    signUpUser();
                  }
                }
              }),
        ],
      ),
    );
  }

  Column choosePlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: planOptions.map((plan) {
        return RadioListTile(
          title: Text(plan.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
          value: plan,
          groupValue: selectedPlan,
          onChanged: (value) {
            setState(() {
              selectedPlan = value as MemberShipPlan;
            });
          },
          contentPadding: const EdgeInsets.all(0),
          activeColor: GlobalVariables.secondaryColor,
          dense: true,
        );
      }).toList(),
    );
  }
}

class MemberShipPlan {
  final int months;
  final String label;
  MemberShipPlan(this.months, this.label);
}
