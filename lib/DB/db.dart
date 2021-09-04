import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../Pages/Excercises/Running/entry.dart';
import '../Data Input/bmi.dart';

abstract class DB {
  static Database? _db;
  static int get _version => 1;

  static Future<void> init() async {
    try {
      String _path = await getDatabasesPath();
      String _dbpath = p.join(_path, 'database.db');
      _db = await openDatabase(_dbpath, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE entries (
        id INTEGER PRIMARY KEY NOT NULL,
        date STRING, 
        duration STRING, 
        speed REAL, 
        distance REAL
      );
      CREATE TABLE bmi(
      id INTEGER PRIMARY KEY NOT NULL,
      date STRING,
      meter INTEGER,
      centi INTEGER,
      kg INTEGER);
      CREATE TABLE system_pref(
      mapJson STRING PRIMARY KEY NOT NULL);
      CREATE TABLE progress(
      id INTEGER PRIMARY KEY NOT NULL,
      date STRING,
      jogging REAL,
      weigh REAL,
      hiit REAL);
      CREATE TABLE progress(
      id INTEGER PRIMARY KEY NOT NULL,
      date STRING,
      jogging_goal REAL,
      weigh_goal REAL,
      hiit_goal REAL)
    ''');
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      await _db!.query(table);
  static Future<int> insertRun(String table, Entry item) async =>
      await _db!.insert(table, item.toMap());
  static Future<int> insertBmi(String table, Bmi_val item) async =>
      await _db!.insert(table, item.toMap());
  static Future<int> insertMapstyle(String table, String style) async =>
      await _db!.insert(table, {'Mapjson': style});
  static Future deleteAll(String table) async =>
      await _db!.rawDelete('DELETE FROM ${table}');
  static Future Cttb() async => await _db!.execute('''
      CREATE TABLE progress(
      id INTEGER PRIMARY KEY NOT NULL,
      date STRING,
      jogging_goal REAL,
      weigh_goal REAL,
      hiit_goal REAL)''');
}
