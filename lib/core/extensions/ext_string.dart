import 'dart:convert';

import 'package:caroby/caroby.dart';

extension ExtString on String? {
  Object? get decode {
    if (isEmptyOrNull) return null;
    return jsonDecode(this!);
  }

  List<T>? decodeList<T>() {
    if (isEmptyOrNull) return null;
    return (jsonDecode(this!) as List<dynamic>).cast<T>();
  }
}
