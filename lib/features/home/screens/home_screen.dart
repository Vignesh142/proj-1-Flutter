import 'package:flutter/material.dart';
import 'package:proj1/common/widgets/custom_shadebutton.dart';
import 'package:proj1/features/auth/screens/signin_screen.dart';
import 'package:proj1/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          Center(
            child: Text(
              user.toJson(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: CustomShadeButton(
              text: 'Log Out',
              onPressed: () {
                removeToken();
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.routeName, (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
  
  void removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('x-auth-token');
  }
}
