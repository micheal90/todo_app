import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? database;
  static init() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)');
        print('Database Created');
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    return await database!.rawQuery('SELECT * FROM tasks');
  }

  static addTask(
    String title,
    DateTime date,
    TimeOfDay time,
  ) async {
    await database!.rawInsert(
        'INSERT INTO tasks(title, date, time) VALUES("$title" , "$date","$time")');
  }

  static updateTask(int id, String title, DateTime date, TimeOfDay time) async {
    await database!.rawUpdate(
      'UPDATE tasks SET title = "$title", date = "$date",time="$time" WHERE id = $id',
    );
  }

  static changeStatus(int id, String status) async {
    await database!.rawUpdate(
      'UPDATE tasks SET status="$status" WHERE id = $id',
    );
  }

  static deleteTask(int id) async {
    await database!.rawDelete('DELETE FROM tasks WHERE id = "$id"');
  }
}
