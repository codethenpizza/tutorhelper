// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';
import 'package:tutor_helper/database/DBProvider.dart';
import 'package:tutor_helper/models/Model.dart';
import 'package:tutor_helper/models/StLessonModel.dart';

StudentModel studentModelFromJson(String str) => StudentModel().fromMap(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toMap());

class StudentModel extends Model{
  final String tableName = 'Students';

  int id;
  String name;
  String phone;
  String email;
  int show;

  StudentModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.show,
  });

  fromMap(Map<String, dynamic> json) => new StudentModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "show": show,
  };

  @override
  all() async {
    final db = await DBProvider.db.database;

    var res = await db.query(this.tableName, where: 'show IS NOT 0', orderBy: "id DESC");

    List<dynamic> list =
    res.isNotEmpty ? res.map((c) => this.fromMap(c)).toList() : [];
    return list;
  }

  @override
  delete() async {
    final db = await DBProvider.db.database;
    var check = await db.query(StLessonModel().tableName, where: 'student_id = ?', whereArgs: [this.id]);
    if(check.isNotEmpty)
      db.update(this.tableName, {'show': 0}, where: 'id = ?', whereArgs: [this.id]);
    else
      db.delete(this.tableName, where: 'id = ?', whereArgs: [this.id]);
  }


  Future nextLesson() async {
    final db = await DBProvider.db.database;

    var res = await db.query(StLessonModel().tableName, orderBy: "date", where: "date > ? AND student_id = ?", whereArgs: [DateTime.now().toIso8601String(), this.id]);

    List<dynamic> list =
    res.isNotEmpty ? res.map((c) => StLessonModel().fromMap(c)).toList() : null;

    return list.first;
  }



}
