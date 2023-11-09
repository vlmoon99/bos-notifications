import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'myDataBase.db');

    // Delete the database if it exists
    await deleteDatabase(path);

    // Create the database
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    // Create tables and define their columns
    await db.execute('''
      CREATE TABLE myDataBase (
        id INTEGER PRIMARY KEY,
        name TEXT,
        date DATETIME
      )
    ''');
  }

  // Your methods to interact with the database go here
}
