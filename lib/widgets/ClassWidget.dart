import 'package:flutter/material.dart';
import 'package:tutor_helper/screens/ClassEdit.dart';
import 'StudentCard.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';

class ClassWidget extends StatelessWidget {
  final StLessonModel sLesson;

  ClassWidget(this.sLesson);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 10, bottom: 20),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        sLesson.timeFrom(),
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        sLesson.timeTo(),
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Text(
                        sLesson.totalCost.toString() + 'Р',
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClassEdit(sLesson))),
              child: FutureBuilder(
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
