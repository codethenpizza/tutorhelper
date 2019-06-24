import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'StudentCard.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';

class ClassWidget extends StatelessWidget {
  final StLessonModel sLesson;


  ClassWidget(this.sLesson);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  sLesson.totalCost.toString() + 'P',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  DateFormat('HH:mm').format(DateTime.parse(sLesson.date)),
//                  sLesson.date,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: StudentModel().find(sLesson.studentId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return StudentCard(
                  snapshot.data,
                  lessonId: sLesson.lessonId,
                );
              } else {
                return Text('Загрузка');
              }
            },
          )
        ],
      ),
    );
  }
}
