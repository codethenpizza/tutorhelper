import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Tutor_helper_1.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Students ("
          "id INTEGER PRIMARY KEY, "
          "name TEXT, "
          "phone TEXT, "
          "email TEXT, "
          "show INTEGER"
          ")");

      await db.execute("CREATE TABLE S_contact_faces ("
          "id INTEGER PRIMARY KEY, "
          "student_id INTEGER, "
          "name TEXT, "
          "phone TEXT, "
          "email TEXT"
          ")");

      await db.execute("CREATE TABLE Lessons ("
          "id INTEGER PRIMARY KEY, "
          "name TEXT, "
          "desc TEXT, "
          "cost INTEGER, "
          "color INTEGER, "
          "duration INTEGER, "
          "show INTEGER"
          ")");

      await db.execute("CREATE TABLE S_Lessons ("
          "id INTEGER PRIMARY KEY, "
          "student_id INTEGER, "
          "lesson_id INTEGER, "
          "date TEXT, "
          "duration INTEGER, "
          "total_cost INTEGER, "
          "homework TEXT"
          ")");
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      print(['onUpgrade', oldVersion, newVersion]);
    }, onOpen: (Database db) async {
      print(['onOpen', await db.getVersion()]);
    });
  }
}
