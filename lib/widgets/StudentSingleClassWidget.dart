import 'package:flutter/material.dart';
import 'package:tutor_helper/widgets/CardLayout.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/screens/ClassEdit.dart';

//import 'StudentCard.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentSingleClassWidget extends StatelessWidget {
  final StLessonModel sLesson;

  StudentSingleClassWidget(this.sLesson);

//  DateTime date;

//  StudentSingleClassWidget({Key key, this.sLesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lDate = DateTime.parse(sLesson.date);
    String formattedDate = DateFormat('E, d, MMM', 'ru_RU').format(lDate);

    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ClassEdit(sLesson))),
      child: Container(
        child: FutureBuilder(
          future: LessonModel().find(sLesson.lessonId),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return CardLayout(
                children: <Widget>[
                  //space inside block
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            snapshot.data.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.rubleSign,
                              size: 15,
                            ),
                            Text(
                              snapshot.data.cost.toString(),
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 10,
                      width: 500,
                      color: Color(snapshot.data.color),
//lesson color
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              sLesson.timeFrom().toString(),
                              style: TextStyle(fontSize: 25),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).accentColor,
                              size: 25,
                            ),
                            Text(
                              sLesson.timeTo().toString(),
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Домашнее задание"),
                        //TODO: add homework display or text that student don't have homework
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae tempus lorem. Curabitur ipsum quam, interdum eget quam mollis, fermentum volutpat augueLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae tempus lorem. Curabitur ipsum quam, interdum eget quam mollis, fermentum volutpat augueLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae tempus lorem. Curabitur ipsum quam, interdum eget quam mollis, fermentum volutpat augue.",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Text('Загрузка');
            }
          },
        ),
      ),
    );
  }
}
