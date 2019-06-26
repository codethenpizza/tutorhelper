import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StudentModel.dart';

import 'package:tutor_helper/config/themeConfig.dart';

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
            style: new TextStyle(
                color: DarkTheme.txt),
            decoration: InputDecoration(
                enabledBorder:
                UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: DarkTheme.txt)),
                focusedBorder:
                UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                        DarkTheme.acc)),
              labelText: 'Имя',
              labelStyle: TextStyle(color: DarkTheme.txt),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: DarkTheme.txt))
            ),
            onChanged: (str) {
              name = str;
            },
          ),
          TextField(
            style: new TextStyle(
                color: DarkTheme.txt),
            decoration: InputDecoration(
                enabledBorder:
                UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: DarkTheme.txt)),
                focusedBorder:
                UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                        DarkTheme.acc)),
                labelText: 'Телефон',
                labelStyle: TextStyle(color: DarkTheme.txt),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: DarkTheme.txt))
            ),
            onChanged: (str) {
              phone = str;
            },
          ),
          TextField(
            style: new TextStyle(
                color: DarkTheme.txt),
            decoration: InputDecoration(
                enabledBorder:
                UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: DarkTheme.txt)),
                focusedBorder:
                UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                        DarkTheme.acc)),
                labelText: 'Почта',
                labelStyle: TextStyle(color: DarkTheme.txt),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: DarkTheme.txt))
            ),
            onChanged: (str) {
              email = str;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              color: DarkTheme.btn,
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8),
                child: const Text('Создать',
                    style: TextStyle(
                        fontSize: 20,
                        color: DarkTheme.txt)),
              ),
            ),
          ),
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