import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:tutor_helper/screens/Student.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/screens/ClassesArchive.dart';




class ArchiveStudentCard extends StatefulWidget {
  @override
  State createState() => ArchiveStudentCardState();
  final StudentModel student;
  final StLessonModel sLesson;

  ArchiveStudentCard(this.student, this.sLesson);
}

class ArchiveStudentCardState extends State<ArchiveStudentCard> {

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
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Student(widget.student))),
                    child: Text(
                      widget.student.name,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: widget.sLesson.lessonId != null
                        ? FutureBuilder(
                      future: LessonModel().find(widget.sLesson.lessonId),
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
                  ArchiveButton(widget.sLesson),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ArchiveButton extends StatefulWidget {
  @override
  State createState() => ArchiveButtonState();
  StLessonModel sLesson;
  ArchiveButton(this.sLesson);
}


class ArchiveButtonState extends State<ArchiveButton> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await widget.sLesson.payedChange();
        setState(() {
          key.currentState.resetAll();
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 140,
            color: widget.sLesson.payed == 0 ?  Theme.of(context).hintColor : Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            widget.sLesson.payed == 0 ?
                Center(
                  child: Text("Не Оплачено",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500), ),
                )
             : Center(
              child: Text("Оплачено", style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 17, fontWeight: FontWeight.w500),),
            )

          ),
        ),
      ),
    );
  }
}

