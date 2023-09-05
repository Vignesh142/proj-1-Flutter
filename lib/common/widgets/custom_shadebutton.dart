import "package:flutter/material.dart";
import "package:proj1/constants/global_vars.dart";

class CustomShadeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomShadeButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
