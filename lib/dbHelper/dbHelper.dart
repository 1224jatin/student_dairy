import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_dairy/dairy_model/dairy_Model.dart';

class Dbhelper {
  static Database? _db;

  Future<DatabaseExecutor> get db async{
    if (_db != null ){
      return _db! ;
    }
    _db = await initDB();
    return _db!;
    }
    initDB() async{
    String path = join(await getDatabasesPath() , 'todo.io');
    return await openDatabase(path,
        version: 1,
      onCreate: (db,version) async {
      await db.execute('''CREATE TABLE Categories(
      CatID INTEGER PRIMARY KEY  AUTOINCREMENT ,
      CategoryName TEXT NOT NULL,
      )''');
       await db.execute(
         '''CREATE TABLE Tasks(
         TaskID INTEGER PRIMARY KEY AUTOINCREMENT,
         TaskName TEXT NOT NULL ,
         CategoryID INTEGER,
         TaskDescription TEXT ,
         IsCompleted BOOL not null
         ) '''
       );
      },
    );
    }
//CURD for Categories Table
    Future<void> insertCategory(Categories categories ) async {
    final dbClient = await db;
    await dbClient.insert("Categories", categories.toMapCategories());
  }
  Future<List<Map<String,dynamic>>> selectategories() async {
    final dbClient = await db;
    return dbClient.query("Categories");
  }
  Future<void> deletCategory(Categories categories) async {
    final dbClient = await db;
    await dbClient.delete("Categories");
  }
  Future<void> updateCategory(Categories categories) async {
    final dbClient = await db;
    await dbClient.update("Categories", categories.toMapCategories());
  }

  // CRUD FOR TASKS

  Future<void> insertTask(Task task) async {
    final dbClient = await db;
    await dbClient.insert("Task", task.toMapTasks());
  }
  Future<List<Map<String,dynamic>>> selectTask() async {
    final dbClient = await db;
    return dbClient.query("Task");
  }
  Future <void> deletTask() async {
    final dbClient =  await db;
    await dbClient.delete("Task");
  }
  Future<void> update(Task task) async {
    final dbClient = await db;
    await dbClient.update("Task", task.toMapTasks());
  }

  }