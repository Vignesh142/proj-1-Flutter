import 'package:flutter/material.dart';
import 'package:proj1/constants/global_vars.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;

  const CustomTextField({
    Key? key,
    required this.controller, 
    required this.labelText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: GlobalVariables.greyBackgroundCOlor,  
        contentPadding: const EdgeInsets.all(10),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black38,
          ),
        )
      ),
      validator: validator,
    );
  }
}