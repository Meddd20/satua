import 'package:flutter/material.dart';
import 'package:satua/app/core/theme_manager/text_style_manager.dart';

class BulletList extends StatelessWidget {
  final String bulletListText;
  const BulletList({super.key, required this.bulletListText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 14)),
        Expanded(
          child: Text(
            bulletListText,
            style: TextStyleManager.regular12(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
