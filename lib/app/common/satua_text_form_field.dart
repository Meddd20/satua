import 'package:flutter/material.dart';

class SatuaTextFormFieldWidget extends StatelessWidget {
  const SatuaTextFormFieldWidget({super.key, required this.title, required this.controller});

  final String title;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontSize: 12.0, color: Color(0xFF666666)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
            ),
          ),
        ),
      ],
    );
  }
}
