import 'package:b_o_s_notifications/flutter_flow/flutter_flow_util.dart';
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
    String path = join(databasesPath, 'myDB.db');

    // Check if the database exists
    // bool databaseExists = await databaseExists(path);

    if (!await databaseExists(path)) {
      // Create the database
      _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    } else {
      // If the database already exists, open it
      _db = await openDatabase(path);
    }
    List<Map<String, dynamic>> data = await fetchDataFromDatabase();
    FFAppState().deletedAccountList.add(data);
    return _db!;
  }

  void _onCreate(Database db, int version) async {
    // Create tables and define their columns
    await db.execute('''
      CREATE TABLE myDB (
        id INTEGER PRIMARY KEY,
        name TEXT,
        date TEXT
      )
    ''');
  }

  // Your methods to interact with the database go here
  Future<List<Map<String, dynamic>>> fetchDataFromDatabase() async {
    var dbClient = await db;
    return await dbClient.query('myDB');
  }

  Future<int> deleteRecordByName(String name) async {
    var dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM myDB WHERE name = ?', [name]);
  }
}
