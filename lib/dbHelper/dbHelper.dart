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
      await db.execute('''CREATE TABLE workCatagory(
      Catagory TEXT NOT NULL
      )''');
      }
    );
    }
    Future<void> insertCatagory(Category catagory) async {
    final dbClient = await db;
  dbClient.insert("workCatagory",)}
}