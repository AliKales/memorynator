import 'package:flutter/material.dart';

class BOutlined extends StatelessWidget {
  const BOutlined({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: OutlinedButton(
        onPressed: onTap,
        child: _text(),
      ),
    );
  }

  Text _text() => Text(text.toUpperCase());
}
