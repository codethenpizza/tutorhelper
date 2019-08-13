import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StudentModel.dart';

class StudentCreate extends StatefulWidget {
  @override
  State createState() => StudentCreateState();
}

class StudentCreateState extends State<StudentCreate> {
  String name;
  String phone;
  String email;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Создание ученика'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Имя',
                ),
                onChanged: (str) {
                  name = str;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Телефон',
                ),
                onChanged: (str) {
                  phone = str;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Почта',
                ),
                onChanged: (str) {
                  email = str;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  textColor: Colors.white,
                  onPressed: () => createStudent(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: const Text('Создать'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  createStudent(BuildContext context) async {
    StudentModel student =
        new StudentModel(name: name, phone: phone, email: email);
    await student.save();
    Navigator.pop(context);
    Flushbar(
      message: 'Ученик создан',
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
