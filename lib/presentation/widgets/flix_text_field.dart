import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class FlixTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const FlixTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.hintText = '...',
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700)),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: blue))),
    );
  }
}
