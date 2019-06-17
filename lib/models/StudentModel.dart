// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';
import 'package:tutor_helper/database/DBProvider.dart';
import 'package:tutor_helper/models/Model.dart';

StudentModel studentModelFromJson(String str) => StudentModel().fromMap(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toMap());

class StudentModel extends Model{
  final String tableName = 'Students';

  int id;
  String name;
  String phone;
  String email;

  StudentModel({
    this.id,
    this.name,
    this.phone,
    this.email,
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
  };

}
