import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';

import 'package:tutor_helper/config/themeConfig.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;
  final int lessonId;

  StudentCard(this.student, {this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: DarkTheme.prm,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                student.name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: DarkTheme.txt),
              ),
//              Text('16 лет', style: TextStyle(color: Colors.white),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                lessonId != null
                    ? FutureBuilder(
                        future: LessonModel().find(lessonId),
                        builder:
                            (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    color: Color(snapshot.data.color),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    snapshot.data.name,
                                    style: TextStyle(
                                        color: DarkTheme.txt,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text('Загрузка', style: TextStyle(color: DarkTheme.txt),);
                          }
                        },
                      )
                    : Container(),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.phone,
                        color: DarkTheme.txt,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.alternate_email, color: DarkTheme.txt),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
