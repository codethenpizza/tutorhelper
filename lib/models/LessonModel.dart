// To parse this JSON data, do
//
//     final lessonModel = lessonModelFromJson(jsonString);

import 'dart:convert';

import 'package:tutor_helper/database/DBProvider.dart';
import 'package:tutor_helper/models/StLessonModel.dart';

import 'Model.dart';

LessonModel lessonModelFromJson(String str) => LessonModel().fromMap(json.decode(str));

String lessonModelToJson(LessonModel data) => json.encode(data.toMap());

class LessonModel extends Model{
  final String tableName = 'Lessons';

  int id;
  String name;
  String desc;
  int cost;
  int color;
  int duration;
  int show;

  LessonModel({
    this.id,
    this.name,
    this.desc,
    this.cost,
    this.color,
    this.show,
    this.duration,
  });

  fromMap(Map<String, dynamic> json) => new LessonModel(
    id: json["id"],
    name: json["name"],
    desc: json["desc"],
    cost: json["cost"],
    color: json["color"],
    duration: json["duration"],
    show: json["show"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "desc": desc,
    "cost": cost,
    "color": color,
    "duration": duration,
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
    var check = await db.query(StLessonModel().tableName, where: 'lesson_id = ?', whereArgs: [this.id]);
    if(check.isNotEmpty)
      db.update(this.tableName, {'show': 0}, where: 'id = ?', whereArgs: [this.id]);
    else
      db.delete(this.tableName, where: 'id = ?', whereArgs: [this.id]);
  }

}
