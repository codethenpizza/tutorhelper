import 'package:flutter/material.dart';
import 'package:tutor_helper/screens/ClassEdit.dart';
import 'ArchiveStudentCard.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';



class ArchiveClassWidget extends StatefulWidget {
  @override
  State createState() => ArchiveClassWidgetState();

  final StLessonModel sLesson;

  ArchiveClassWidget(this.sLesson);
}

class ArchiveClassWidgetState extends State<ArchiveClassWidget> {

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
                        widget.sLesson.timeFrom(),
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        widget.sLesson.timeTo(),
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Text(
                        widget.sLesson.totalCost.toString() + 'Р',
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
                  MaterialPageRoute(builder: (context) => ClassEdit(widget.sLesson))),
              child: FutureBuilder(
                future: StudentModel().find(widget.sLesson.studentId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ArchiveStudentCard(
                      snapshot.data,
                      widget.sLesson,
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



//class ArchiveClassWidget extends StatelessWidget {
//  final StLessonModel sLesson;
//
//  ArchiveClassWidget(this.sLesson);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 10, bottom: 20),
//      child: Row(
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 8.0),
//            child: Container(
//              child: Column(
//                children: <Widget>[
//                  Column(
//                    children: <Widget>[
//                      Text(
//                        sLesson.timeFrom(),
//                        style: Theme.of(context).textTheme.body1,
//                      ),
//                      Icon(
//                        Icons.keyboard_arrow_down,
//                        color: Theme.of(context).accentColor,
//                      ),
//                      Text(
//                        sLesson.timeTo(),
//                        style: Theme.of(context).textTheme.body1,
//                      ),
//                      Text(
//                        sLesson.totalCost.toString() + 'Р',
//                        style: Theme.of(context).textTheme.body2,
//                      ),
//                    ],
//                  )
//                ],
//              ),
//            ),
//          ),
//          Expanded(
//            child: InkWell(
//              onTap: () => Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => ClassEdit(sLesson))),
//              child: FutureBuilder(
//                future: StudentModel().find(sLesson.studentId),
//                builder: (context, AsyncSnapshot snapshot) {
//                  if (snapshot.hasData) {
//                    return ArchiveStudentCard(
//                      snapshot.data,
//                      sLesson,
//                    );
//                  } else {
//                    return Text('Загрузка');
//                  }
//                },
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
