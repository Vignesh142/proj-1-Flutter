import 'package:flutter/material.dart';

class MemberShipScreen extends StatelessWidget {
  static const String routeName = '/membership-screen';
  const MemberShipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
              "Membership Screen",
              style: Theme.of(context).textTheme.displayLarge,
            ),
      ),
    );
  }
}
