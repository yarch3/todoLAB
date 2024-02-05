import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'db_file.dart';
import 'package:todolist/model/task_model.dart';


class BDService{
  void addTasktoDB(String table, Task task) async =>
      await DB.insert(table, task);



//Обновление локального списка через запрос от БД


  void deleteTaskfromDB(String table, Task task) async =>
      await DB.delete(table, task);


  Future<List<Map<String, dynamic>>> getTablefromDB(String table) async =>
      await DB.query(table);

}
//сохранение задачи в БД
