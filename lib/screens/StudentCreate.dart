import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StudentModel.dart';

class StudentCreate extends StatelessWidget {
  String name;
  String phone;
  String email;


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('TutorHelper'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Имя'
            ),
            onChanged: (str) {
              name = str;
            },
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Телефон'
            ),
            onChanged: (str) {
              phone = str;
            },
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Почта'
            ),
            onChanged: (str) {
              email = str;
            },
          ),
          RaisedButton(
            onPressed: () => createStudent(context),
            child: Text('Создать'),
          )
        ],
      ),
    ),
  );

  createStudent(BuildContext context) async {
    StudentModel student = new StudentModel(name: name, phone: phone, email: email);
    await student.save();
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Студент создан!'),duration: Duration(seconds: 1),));
    Navigator.pop(context);
  }
}