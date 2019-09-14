import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/screens/UserLessonEdit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserLessonCard extends StatefulWidget {

  final LessonModel lessonModel;
  final Function updateList;

  const UserLessonCard({Key key, this.lessonModel, this.updateList}) : super(key: key);


  @override
  State createState() => UserLessonCardState();
}

class UserLessonCardState extends State<UserLessonCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserLessonEdit(
        lesson: widget.lessonModel,
        updateList: widget.updateList,
        scaffoldContext: context,
      ))).then((_) {
      setState(() {

      });
      }),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.lessonModel.name,
                  style: Theme.of(context).textTheme.title.copyWith(fontSize: 20),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 8,
                    width: 400,
                    // Lesson color here
                    color: Color(widget.lessonModel.color),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.access_time),
                            Text(" " + widget.lessonModel.duration.toString() + " минут", style: TextStyle(fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.rubleSign, size: 16,),
                            Text(widget.lessonModel.cost.toString(), style: TextStyle(fontWeight: FontWeight.w400),),
                          ],
                        ),
                      )

                    ],
                  ),
                )
              ],
            )),
      ),
    );

  }

}


//class UserLessonCard extends StatelessWidget {
//  final LessonModel lessonModel;
//
//
//  const UserLessonCard({Key key, this.lessonModel}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserLessonEdit(
//            lesson: lessonModel,
//                                              updateList: () => {},
//                                              scaffoldContext: context,
//          ))),
//      child: Card(
//        child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text(
//                  lessonModel.name,
//                  style: Theme.of(context).textTheme.title.copyWith(fontSize: 20),
//                ),
//                ClipRRect(
//                  borderRadius: BorderRadius.circular(10),
//                  child: Container(
//                    height: 8,
//                    width: 400,
//                    // Lesson color here
//                    color: Color(lessonModel.color),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(vertical: 4.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Container(
//                        child: Row(
//                          children: <Widget>[
//                            Icon(Icons.access_alarm),
//                            Text(lessonModel.duration.toString(), style: TextStyle(fontWeight: FontWeight.w400),),
//                          ],
//                        ),
//                      ),
//                      Container(
//                        child: Row(
//                          children: <Widget>[
//                            Icon(Icons.attach_money),
//                            Text(lessonModel.cost.toString(), style: TextStyle(fontWeight: FontWeight.w400),),
//                          ],
//                        ),
//                      )
//
//                    ],
//                  ),
//                )
//              ],
//            )),
//      ),
//    );
//
//  }
//
//
//}