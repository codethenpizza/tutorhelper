import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:tutor_helper/screens/Student.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;
  final int lessonId;

  StudentCard(this.student, {this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Student(student))),
                    child: Text(
                      student.name,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                )
//              Text('16 лет', style: TextStyle(color: Colors.white),)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: lessonId != null
                        ? FutureBuilder(
                            future: LessonModel().find(lessonId),
                            builder:
                                (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        color: Color(snapshot.data.color),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          snapshot.data.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.body2),
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                );
                              } else {
                                return Text('Загрузка');
                              }
                            },
                          )
                        : Container(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.phone), onPressed: () => launch("tel:${student.phone}")),
                        IconButton(icon: Icon(Icons.sms), onPressed: () => launch("sms:${student.phone}")),
                        IconButton(icon: Icon(Icons.email), onPressed: () => launch("mailto:${student.email}")),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
