import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:tutor_helper/screens/Student.dart';
import 'package:tutor_helper/models/StudentModel.dart';

class StudentContact extends StatelessWidget {
  final StudentModel student;

  const StudentContact({Key key, this.student, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Student(student))),
        child: Card(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.person_outline, color: Theme.of(context).accentColor,size: 40,
              ),
              Text(
                student.name,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),

            ],
          ),
        ),
    ),
      );
  }


}