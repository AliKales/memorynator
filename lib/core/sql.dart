import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

enum SqlResult {
  success,
  error;
}

final class SqlWhere {
  final String key;
  final Object value;
  final String operator;
  final String logicalOperators;

  SqlWhere({
    required this.key,
    required this.value,
    required this.operator,
    required this.logicalOperators,
  });
}

final class _SqlFunctionResult<T> {
  final T? value;
  final SqlResult sqlResult;

  _SqlFunctionResult({required this.value, required this.sqlResult});
}

enum Tables {
  note(_Table.note),
  person(_Table.person);

  final String table;

  const Tables(this.table);
}

class Sql {
  static late Database _database;

  static Future<void> init() async {
    String path = "database.db";

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static FutureOr<void> _onCreate(Database db, int version) async {
    for (var table in Tables.values) {
      await db.execute(table.table);
    }
  }

  static FutureOr<_SqlFunctionResult<T>> _sqlFun<T>(FutureOr function) async {
    try {
      T? value = await function;
      return _SqlFunctionResult<T>(value: value, sqlResult: SqlResult.success);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return _SqlFunctionResult<T>(value: null, sqlResult: SqlResult.error);
    }
  }

  static Future<SqlResult> add(Map<String, dynamic> val, Tables table) async {
    return (await _sqlFun<dynamic>(_database.insert(table.name, val)))
        .sqlResult;
  }

  static Future<SqlResult> update(
    Map<String, dynamic> val,
    Tables table,
    List<SqlWhere>? whereValues,
  ) async {
    String? where;

    if (whereValues != null) {
      where = _where(whereValues);
    }

    return (await _sqlFun(
      _database.update(
        table.name,
        val,
        where: where,
        whereArgs: whereValues?.map((e) => e.value).toList(),
      ),
    ))
        .sqlResult;
  }

  static Future<List<Map<String, dynamic>>?> get(
    Tables table, {
    List<SqlWhere>? whereValues,
    String? orderBy,
    int? limit,
  }) async {
    String? where;

    if (whereValues != null) {
      where = _where(whereValues);
    }

    final funResult = await _sqlFun<List<Map<String, dynamic>>>(_database.query(
      table.name,
      where: where,
      whereArgs: whereValues?.map((e) => e.value).toList(),
      orderBy: orderBy,
      limit: limit,
    ));

    if (funResult.sqlResult == SqlResult.error || funResult.value == null) {
      return null;
    }

    final List<Map<String, dynamic>> maps = funResult.value!;

    return maps;
  }

  static Future<SqlResult> delete(
    Tables table, {
    List<SqlWhere>? whereValues,
  }) async {
    String? where;

    if (whereValues != null) {
      where = _where(whereValues);
    }

    return (await _sqlFun(_database.delete(
      table.name,
      where: where,
      whereArgs: whereValues?.map((e) => e.value).toList(),
    )))
        .sqlResult;
  }

  static String _where(List<SqlWhere> values) {
    String where = "";
    for (var i = 0; i < values.length; i++) {
      SqlWhere sqlWhere = values.elementAt(i);

      where = "$where${sqlWhere.key} ${sqlWhere.operator} ?";

      if (i != values.length - 1) {
        where = "$where ${sqlWhere.logicalOperators} ";
      }
    }

    return where;
  }
}

final class _Table {
  static const String note = '''
      CREATE TABLE note(
        sqlID INTEGER PRIMARY KEY AUTOINCREMENT,
        id TEXT,
        personId TEXT,
        title TEXT, 
        note TEXT, 
        createdAt INTEGER,
        images TEXT,
        audio TEXT,
        reminder INTEGER
      )
    ''';

  static const String person = '''
      CREATE TABLE person(
        sqlID INTEGER PRIMARY KEY AUTOINCREMENT,
        id TEXT,
        name TEXT,
        randomAvatarText TEXT,
        imagePath TEXT,
        createdAt INTEGER
      )
    ''';
}
