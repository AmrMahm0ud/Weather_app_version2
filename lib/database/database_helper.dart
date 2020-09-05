import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app_verion2/model/weather_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance =  DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  final String tableName = "Weather";
  final String columnId = "id";
  final String columnState = "State";
  final String columnDateCreated = "dateCreated";
  final String columnTemp = "temp";

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "weather_db.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, $columnState TEXT, $columnDateCreated TEXT , $columnTemp TEXT)");
    print("Table is created");
  }

   //insertion
  Future<int> saveItem(Weather item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", item.toMap(item));
    print(res.toString());
    return res;
  }

  //Get
  Future<List> getItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ");
    return result.toList();
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
