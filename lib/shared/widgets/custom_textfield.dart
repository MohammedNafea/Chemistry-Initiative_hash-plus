import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextfield({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
