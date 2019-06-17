import 'package:flutter/material.dart';
import 'StudentCard.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';

class ClassWidget extends StatelessWidget{

  final StLessonModel lesson;
  final StudentModel student;

  ClassWidget(this.lesson):
  student = lesson.getStudent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(lesson.date, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          StudentCard(student)
        ],
      ),
    );
  }
}