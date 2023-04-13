import 'package:flutter/material.dart';

class MyField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? keyboardType;
  const MyField({
    super.key,
    this.hint,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.grey,
        filled: true,
        border: InputBorder.none,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    );
  }
}
