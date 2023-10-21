import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

final class LocalUtils {
  static Brightness? getBrightness(bool? isDark) {
    switch (isDark) {
      case null:
        return null;
      case true:
        return Brightness.dark;
      case false:
        return Brightness.light;
    }
  }

  static Future<void> changeFileLocation({
    required String from,
    required String to,
  }) async {
    List<String> values = to.split("/");
    values.removeLast();

    final directory = values.join("/");

    await Directory(directory).create(recursive: true);

    await File(from).rename(to);
  }

  static Future<void> createDirectory(String path) async {
    List<String> values = path.split("/");
    if (values.last.contains(".")) {
      values.removeLast();
    }

    final directory = values.join("/");

    await Directory(directory).create(recursive: true);
  }

  static String generateRandomId() {
    const String validCharacters =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
    final Random random = Random();
    String randomId = "";

    for (int i = 0; i < 12; i++) {
      final int randomIndex = random.nextInt(validCharacters.length);
      randomId += validCharacters[randomIndex];
    }

    return randomId;
  }

  static Map<String, dynamic> convertToMap(dynamic value) {
    return Map<String, dynamic>.from(value);
  }
}
