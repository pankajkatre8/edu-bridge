import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.labelStyle,
    this.contentPadding,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: labelStyle,
        contentPadding: contentPadding,
        border: border,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}