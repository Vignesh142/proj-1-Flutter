import 'package:flutter/material.dart';
import 'package:proj1/features/auth/screens/auth_screen.dart';
import 'package:proj1/features/auth/screens/membership_screen.dart';
import 'package:proj1/features/auth/screens/signin_screen.dart';
import 'package:proj1/features/auth/screens/signup_screen.dart';
import 'package:proj1/features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch(routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen()
      );
    case SignInScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignInScreen()
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreen()
      );
    case MemberShipScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MemberShipScreen()
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen()
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${routeSettings.name}'),
          )
        )
      );
  }
}