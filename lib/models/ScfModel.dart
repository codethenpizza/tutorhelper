// To parse this JSON data, do
//
//     final scfModel = scfModelFromJson(jsonString);

import 'dart:convert';

ScfModel scfModelFromJson(String str) => ScfModel.fromMap(json.decode(str));

String scfModelToJson(ScfModel data) => json.encode(data.toMap());

class ScfModel {
  int id;
  int studentId;
  String name;
  String phone;
  String email;

  ScfModel({
    this.id,
    this.studentId,
    this.name,
    this.phone,
    this.email,
  });

  factory ScfModel.fromMap(Map<String, dynamic> json) => new ScfModel(
    id: json["id"],
    studentId: json["student_id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "student_id": studentId,
    "name": name,
    "phone": phone,
    "email": email,
  };
}
