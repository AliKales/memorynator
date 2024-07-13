import 'dart:convert';

import 'package:caroby/caroby.dart';

extension ExtList<E> on List<E>? {
  // bool get isEmptyOrNull {
  //   if (this == null || this!.isEmpty) return true;
  //   return false;
  // }

  // bool get isNotEmptyAndNull {
  //   if (this != null && this!.isNotEmpty) return true;
  //   return false;
  // }

  String? get encode {
    if (this.isEmptyOrNull) return null;
    return jsonEncode(this);
  }
}
