extension ExtDateTime on DateTime {
  int get toSql {
    return toUtc().millisecondsSinceEpoch;
  }
}
