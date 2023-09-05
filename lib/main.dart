import 'package:flutter/material.dart';
import 'package:proj1/constants/global_vars.dart';
import 'package:proj1/features/auth/screens/signin_screen.dart';
import 'package:proj1/features/auth/services/auth_service.dart';
import 'package:proj1/features/home/screens/home_screen.dart';
import 'package:proj1/providers/user_provider.dart';
import 'package:proj1/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserdata(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yaarit',
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                color: Colors.black,
              ),
              displayLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: GlobalVariables.textColor,
              ),
              displayMedium: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: GlobalVariables.ashColor,
              ),
              displaySmall: TextStyle(
                fontSize: 16,
                color: GlobalVariables.textColor,
              ))),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty ? const HomeScreen() : const SignInScreen(),
    );
  }
}
