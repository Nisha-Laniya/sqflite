
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static final _databasename = 'persons.db';
  static final _databaseversion = 1;

  static final table = 'my_table';

  static final columnID = 'id';
  static final columnName = 'name';
  static final columnAge = 'age';

  static Database? _database;

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,version: _databaseversion,onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version) async {
    await db.execute('CREATE TABLE $table($columnID INTEGER PRIMARY KEY, $columnName TEXT NOT NULL, $columnAge INTEGER NOT NULL)');

    // await db.execute(
    //   '''
    //   CREATE TABLE $table (
    //     $columnID INTEGER PRIMARY KEY,
    //     $columnName TEXT NOT NULL,
    //     $columnAge INTEGER NOT NULL,
    //   )
    //   '''
    // );
  }

  //insert
  Future<int> insert(Map<String,dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  //query all rows
  Future<List<Map<String,dynamic>>> queryall() async{
    Database db = await instance.database;
    return await db.query(table);
  }

  //specific query
 Future<List<Map<String,dynamic>>> queryspecific(int age) async {
    Database db = await instance.database;
    // var res = await db.query(table,where: "age < ?" ,whereArgs: [age]);
    var res = await db.rawQuery('SELECT * FROM my_table WHERE age > ?', [age]);
    return res;
  }

  //DELETE
  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    var res = await db.delete(table,where: "id = ?",whereArgs: [id]);
    return res;
  }
  
  //update
  Future<int> update(int id) async {
    Database db = await instance.database;
    var res = await db.update(table, {"name" : "Desi Programmer", "age" : 2}, where : "id = ?" , whereArgs: [id]);
    return res;
  }
}