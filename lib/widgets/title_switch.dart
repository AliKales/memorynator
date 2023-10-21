import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';

class TitleSwitch extends StatelessWidget {
  const TitleSwitch({
    super.key,
    required this.switchVal,
    required this.onSwitch,
    required this.title,
  });

  final String title;
  final bool switchVal;
  final ValueChanged<bool> onSwitch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium,
        ),
        context.sizedBox(width: Values.paddingWidthSmallX),
        Switch.adaptive(
          value: switchVal,
          onChanged: onSwitch,
        ),
      ],
    );
  }
}
