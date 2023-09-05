import 'package:flutter/material.dart';
import 'package:proj1/constants/global_vars.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
ShaderMask shadeText(text) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return GlobalVariables.appBarGradient.createShader(bounds);
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white, // Text color
        ),
      ),
    );
  }
