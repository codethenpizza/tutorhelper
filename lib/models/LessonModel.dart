// To parse this JSON data, do
//
//     final lessonModel = lessonModelFromJson(jsonString);

import 'dart:convert';

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

  LessonModel({
    this.id,
    this.name,
    this.desc,
    this.cost,
    this.color,
  });

  fromMap(Map<String, dynamic> json) => new LessonModel(
    id: json["id"],
    name: json["name"],
    desc: json["desc"],
    cost: json["cost"],
    color: json["color"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "desc": desc,
    "cost": cost,
    "color": color,
  };
}
