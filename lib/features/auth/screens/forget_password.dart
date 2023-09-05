import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        'Forget Password Page',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    ));
  }
}
