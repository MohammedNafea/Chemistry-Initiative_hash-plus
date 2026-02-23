import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final IconData? prefixIcon;

  final String? Function(String?)? validator;

  const CustomTextfield({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.prefixIcon,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      style: TextStyle(color: isLight ? Colors.black87 : Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isLight ? Colors.grey[500] : Colors.grey[400],
        ),
        filled: true,
        fillColor: isLight
            ? Colors.white.withValues(alpha: 0.5)
            : Colors.black.withValues(alpha: 0.2),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: isLight ? Colors.deepPurple[400] : Colors.cyanAccent,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isLight
                ? Colors.deepPurple.withValues(alpha: 0.2)
                : Colors.cyanAccent.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isLight
                ? Colors.deepPurple.withValues(alpha: 0.2)
                : Colors.cyanAccent.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isLight ? Colors.deepPurpleAccent : Colors.cyanAccent,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }
}
