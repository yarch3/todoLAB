import 'package:path/path.dart';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../model/task_model.dart';


abstract class DB {
  static Database? db;
  static int get _version => 1;

  static Future<void> init() async {
    try{
      String pathf = await getDatabasesPath();
      String DBpath = p.join(pathf, 'todolist.db');

      db = await openDatabase(DBpath, version: _version, onCreate: onCreate);
    }
    catch(ex){
      print(ex);
    }
  }

  static Future<void> onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE TodoList (
            id INTEGER PRIMARY KEY NOT NULL,
            task STRING,
            dateTime DATETIME)'''
    );
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      await db!.query(table);
  static Future<int> insert(String table, Task task)async =>
      await db!.insert(table, task.toMap());
  static Future<int> delete(String table, Task task)async =>
      await db!.delete(table, where: 'id = ?', whereArgs: [task.id]);
}