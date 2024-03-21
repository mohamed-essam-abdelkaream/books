import 'package:books/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: secondryColor,
            width: 2.0,
          ),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: secondryColor,fontWeight: FontWeight.bold),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        fillColor: Colors.white,
        filled: true,
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
