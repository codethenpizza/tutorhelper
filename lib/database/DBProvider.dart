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
    String path = join(documentsDirectory.path, 'TutorHelper.db');
    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Students ("
              "id INTEGER PRIMARY KEY, "
              "name TEXT, "
              "phone TEXT, "
              "email TEXT"
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
              "color INTEGER"
              ")");

          await db.execute("CREATE TABLE S_Lessons ("
              "id INTEGER PRIMARY KEY, "
              "student_id INTEGER, "
              "lesson_id INTEGER, "
              "date TEXT, "
              "duration TEXT, "
              "total_cost INTEGER"
              ")");
        }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
          print(['onUpgrade', oldVersion, newVersion]);
          await db.execute("DROP TABLE Lessons");

          await db.execute("CREATE TABLE Lessons ("
              "id INTEGER PRIMARY KEY, "
              "name TEXT, "
              "desc TEXT, "
              "cost INTEGER, "
              "color INTEGER"
              ")");
        },
        onOpen: (Database db) async {
          print(['onOpen', await db.getVersion()]);
        }
    );
  }


}