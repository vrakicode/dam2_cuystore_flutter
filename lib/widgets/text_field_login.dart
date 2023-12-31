import 'package:flutter/material.dart';
class TextFieldLogin extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  const TextFieldLogin({
    super.key, 
    required this.label, required this.hintText, 
    required this.obscureText, this.controller, 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
      ),
      controller: controller,
    );
  }
}