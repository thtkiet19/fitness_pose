import 'dart:async';

import 'package:fitness_pose/Structures/goal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../Structures/entry.dart';
import '../Structures/bmi.dart';

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
      );''');
    await db.execute('''
      CREATE TABLE bmi(
      id INTEGER PRIMARY KEY NOT NULL,
      date STRING,
      meter INTEGER,
      centi INTEGER,
      kg INTEGER);
      ''');
    await db.execute('''
      CREATE TABLE system_pref(
      mapJson STRING PRIMARY KEY NOT NULL);
      ''');
    await db.execute('''
      CREATE TABLE progress(
      date STRING PRIMARY KEY NOT NULL,
      jogging REAL,
      weigh REAL,
      hiit REAL
      );''');
    await db.execute('''
      CREATE TABLE goals(
      id INTEGER PRIMARY KEY NOT NULL,
      date STRING,
      jogging_goal REAL,
      weigh_goal REAL,
      hiit_goal REAL);''');
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      await _db!.query(table);
  static Future<int> insertRun(String table, Entry item) async =>
      await _db!.insert(table, item.toMap());
  static Future<int> insertBmi(String table, Bmi_val item) async =>
      await _db!.insert(table, item.toMap());
  static Future<int> insertGoal(String table, Goal_val item) async =>
      await _db!.insert(table, item.toMap());
  static Future<int> insertMapstyle(String table, String style) async =>
      await _db!.insert(table, {'Mapjson': style});
  static Future deleteAll(String table) async =>
      await _db!.rawDelete('DELETE FROM $table');
  static Future loadProgress(String date) async => await _db!.execute(
      '''UPDATE progress set jogging = (Select SUM (entries.distance) from entries where entries.date = '$date') where progress.date = '$date' ''');
  static Future innnitProgressDate(String Date) async => await _db!.execute(
      '''INSERT INTO progress(date, jogging, weigh, hiit) values ('$Date' , 0, 0, 0)''');
  static Future<List<Map<String, dynamic>>> selectWeek(
          String table, String orderby) async =>
      await _db!.query(table, orderBy: orderby, limit: 7);
}
