import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  final bool isDark;

  CustomTheme(this.isDark);

  ThemeData theme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _getColorScheme,
      appBarTheme: AppBarTheme(
        titleTextStyle: context.textTheme.headlineSmall!.copyWith(
          color: blackWhite(!isDark),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color blackWhite(bool isBlack) {
    if (isBlack) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  ColorScheme get _getColorScheme {
    if (isDark) return const ColorScheme.dark();

    return const ColorScheme.light();
  }

  static List<Color> colors = [
    const Color(0xFFf9d16a),
    const Color(0xFFc29ff9),
    const Color(0xFF58bf9c),
    const Color(0xFF62a5f6),
    const Color(0xFFef566a),
    const Color(0xFFf0a787),
  ];
}
