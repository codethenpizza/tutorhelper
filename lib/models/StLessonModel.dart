// To parse this JSON data, do
//
//     final stLessonModel = stLessonModelFromJson(jsonString);

import 'dart:convert';
import 'package:tutor_helper/models/StudentModel.dart';
import 'Model.dart';

StLessonModel stLessonModelFromJson(String str) => StLessonModel().fromMap(json.decode(str));

String stLessonModelToJson(StLessonModel data) => json.encode(data.toMap());

class StLessonModel extends Model {
  final String tableName = 'S_Lessons';

  int id;
  int studentId;
  int lessonId;
  String date;
  String duration;
  int totalCost;

  StLessonModel({
    this.id,
    this.studentId,
    this.lessonId,
    this.date,
    this.duration,
    this.totalCost,
  });

  fromMap(Map<String, dynamic> json) => new StLessonModel(
    id: json["id"],
    studentId: json["student_id"],
    lessonId: json["lesson_id"],
    date: json["date"],
    duration: json["duration"],
    totalCost: json["total_cost"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "student_id": studentId,
    "lesson_id": lessonId,
    "date": date,
    "duration": duration,
    "total_cost": totalCost,
  };

  StudentModel getStudent() {
    return StudentModel().find(this.studentId);
  }
}
