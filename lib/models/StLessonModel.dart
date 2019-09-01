// To parse this JSON data, do
//
//     final stLessonModel = stLessonModelFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tutor_helper/database/DBProvider.dart';

import 'Model.dart';

StLessonModel stLessonModelFromJson(String str) =>
    StLessonModel().fromMap(json.decode(str));

String stLessonModelToJson(StLessonModel data) => json.encode(data.toMap());

class StLessonModel extends Model {
  final String tableName = 'S_Lessons';

  int id;
  int studentId;
  int lessonId;
  String date;
  int duration;
  int totalCost;
  String homework;

  StLessonModel({
    this.id,
    this.studentId,
    this.lessonId,
    this.date,
    this.duration,
    this.totalCost,
    this.homework
  });

  fromMap(Map<String, dynamic> json) => new StLessonModel(
        id: json["id"],
        studentId: json["student_id"],
        lessonId: json["lesson_id"],
        date: json["date"],
        duration: json["duration"],
        totalCost: json["total_cost"],
        homework: json["homework"],
  );

  Map<String, dynamic> toMap() => {
        "id": id,
        "student_id": studentId,
        "lesson_id": lessonId,
        "date": date,
        "duration": duration,
        "total_cost": totalCost,
        "homework": homework,
      };

  Future allComing() async {
    final db = await DBProvider.db.database;

    var res = await db.query(
        this.tableName,
        orderBy: "date",
        where: "date > ?",
        whereArgs: [DateTime.now().toIso8601String()],
    );
    List<dynamic> list =
    res.isNotEmpty ? res.map((c) => this.fromMap(c)).toList() : [];
    return list;
  }

  Future allPast() async {
    final db = await DBProvider.db.database;

    var res = await db.query(
      this.tableName,
      orderBy: "date",
      where: "date < ?",
      whereArgs: [DateTime.now().toIso8601String()],
    );
    List<dynamic> list =
    res.isNotEmpty ? res.map((c) => this.fromMap(c)).toList() : [];
    return list;
  }

  Future nextWeek() async {
    final db = await DBProvider.db.database;

    var res = await db.query(
      this.tableName,
      orderBy: "date",
      where: "date > ? AND date < ?",
      whereArgs: [DateTime.now().toIso8601String(), DateTime.now().add(Duration(days: 7)).toIso8601String()],
    );
    List<dynamic> list =
    res.isNotEmpty ? res.map((c) => this.fromMap(c)).toList() : [];
    return list;
  }

//  String timeFromTo(){
//    String from = DateFormat('HH:mm').format(DateTime.tryParse(this.date));
//    String to = DateFormat('HH:mm').format(DateTime.tryParse(this.date).add(new Duration(minutes: this.duration != null ? this.duration : 0)));
//    return '$from - $to';
//  }

  String timeFrom(){
    String from = DateFormat('HH:mm').format(DateTime.tryParse(this.date));
    return '$from';
  }

  String timeTo(){
    String to = DateFormat('HH:mm').format(DateTime.tryParse(this.date).add(new Duration(minutes: this.duration != null ? this.duration : 0)));
    return '$to';
  }

}
