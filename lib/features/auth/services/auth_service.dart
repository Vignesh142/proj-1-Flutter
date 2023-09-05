import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proj1/constants/error_handling.dart';
import 'package:proj1/constants/global_vars.dart';
import 'package:proj1/constants/utils.dart';
import 'package:proj1/features/home/screens/home_screen.dart';
import 'package:proj1/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:proj1/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //signup user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String membership,
  }) async {
    try {
      User user = User(
          id: '',
          email: email,
          password: password,
          name: name,
          membership: membership);
      print("sending request");
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("got response succes");
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created successfully');
        },
      );
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
  }

  //login user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      print("sending request");
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("got request success");
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // showSnackBar(context, 'Signed in successfully');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
  }

  //get user data
  void getUserdata(
    BuildContext context,
  ) async {
    try {
      print("auto signin request");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userResp = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        print("got auto signin success");
        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResp.body);
      }
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
  }
}
