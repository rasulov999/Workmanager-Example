import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:workmanager_tutorial/data/models/data_model.dart';

class LocalDatabase {
  static String tableName = "usersTable";
  static LocalDatabase getInstance = LocalDatabase._init();
  Database? _database;

  LocalDatabase._init();

  Future<Database> getDb() async {
    if (_database == null) {
      _database = await _initDb("data.db");
      return _database!;
    }
    return _database!;
  }

  Future<Database> _initDb(String fileName) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, fileName);
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
        String textType = "TEXT";
        String latLong = "TEXT";

        await db.execute('''
               Create Table $tableName(
                           ${DataFields.id} $idType,
                           ${DataFields.lat} $latLong,
                           ${DataFields.lon} $latLong,
                           ${DataFields.dateTime} $textType
                           )
                           ''');
      },
    );
    return database;
  }

  static Future<DataModel> insertToDatabase(DataModel dataModel) async {
    var dataBase = await getInstance.getDb();
    int id = await dataBase.insert(tableName, dataModel.toJson());
    debugPrint("===============Added to DATABASE===============");
    return dataModel.copyWith(id: id);
  }

  static Future<List<DataModel>> getList() async {
    var dataBase = await getInstance.getDb();
    var listOfUsers = await dataBase.query(tableName, columns: [
      DataFields.id,
      DataFields.lat,
      DataFields.lon,
      DataFields.dateTime
    ]);
    var list = listOfUsers.map((e) => DataModel.fromJson(e)).toList();
    return list;
  }
}
