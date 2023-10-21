import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';

class BFilled extends StatelessWidget {
  const BFilled({
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
      child: FilledButton(
        onPressed: onTap,
        child: _text(context),
      ),
    );
  }

  Text _text(BuildContext context) => Text(
        text.toUpperCase(),
        style: context.textTheme.labelLarge!.toBold,
      );
}
