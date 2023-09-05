import 'package:flutter/material.dart';

String uri = 'http://192.168.0.8:3000';

class GlobalVariables {
  // COLORS
  // static const appBarGradient = LinearGradient(
  //   colors: [
  //     Color.fromARGB(255, 29, 201, 192),
  //     Color.fromARGB(255, 125, 221, 216),
  //   ],
  //   stops: [0.5, 1.0],
  // );
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(123, 191, 255, 1),
      Color.fromRGBO(96, 118, 255, 1),
      Color.fromRGBO(123, 110, 255, 1)
    ],
    stops: [0, 0.51, 1],
  );

  // static const secondaryColor = Color.fromRGBO(189, 142, 73, 1);

  static const secondaryColor = Color.fromRGBO(98, 95, 235, 1);

  static const textColor = Color.fromRGBO(21, 20, 75, 1);

  static const ashColor = Color.fromRGBO(119, 131, 145, 1);

  static const textBoxColor = Color.fromRGBO(245, 245, 245, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // Images
  static const helloImg = 'assets/icons/hello_img.png';

  static const question = 'assets/icons/question_mark.png';
}
