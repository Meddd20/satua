import 'package:flutter/material.dart';

class SatuaTextFormFieldRandomizerWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Widget childWidget;
  final Widget? suffixIcon;

  const SatuaTextFormFieldRandomizerWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.childWidget,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
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
                  suffixIcon: suffixIcon,
                ),
                readOnly: true,
              ),
            ),
            const SizedBox(width: 8.0),
            childWidget,
          ],
        ),
      ],
    );
  }
}
