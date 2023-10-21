import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';

final class LocalValues {
  static double picSize(BuildContext context) => 0.3.toDynamicWidth(context);

  static double noteSize(BuildContext context) => 0.44.toDynamicWidth(context);

  static String pathToImages({
    required String deviceDocPath,
    required String id,
    required String fileName,
  }) {
    return "$deviceDocPath/data/$id/images/$fileName";
  }

  static String pathToAudios({
    required String deviceDocPath,
    required String id,
    required String fileName,
  }) {
    return "$deviceDocPath/data/$id/audios/$fileName";
  }
}
