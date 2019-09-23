import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/screens/UserLessonCreate.dart';
import 'package:tutor_helper/screens/UserLessonEdit.dart';
import 'package:tutor_helper/widgets/UserLessonCard.dart';

class UserLessonsList extends StatefulWidget {
  @override
  State createState() => UserLessonsListState();
}

class UserLessonsListState extends State<UserLessonsList> {
  Future lessons = LessonModel().all();

  void updateList() {
    setState(() {
      lessons = LessonModel().all();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,

      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserLessonCreate(
                            updateList: updateList,
                          )))),
          body:
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: ListView(
//            children: <Widget>[
//              Card(
//                child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Text(
//                          "Математика",
//                          style: Theme.of(context).textTheme.title.copyWith(fontSize: 20),
//                        ),
//                        ClipRRect(
//                          borderRadius: BorderRadius.circular(10),
//                          child: Container(
//                            height: 8,
//                            width: 400,
//                            // Lesson color here
//                            color: Colors.amber,
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.symmetric(vertical: 4.0),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Container(
//                              child: Row(
//                                children: <Widget>[
//                                  Icon(Icons.access_alarm),
//                                  Text('60 Минут', style: TextStyle(fontWeight: FontWeight.w400),),
//                                ],
//                              ),
//                              ),
//                              Container(
//                                child: Row(
//                                  children: <Widget>[
//                                    Icon(Icons.attach_money),
//                                    Text('1000', style: TextStyle(fontWeight: FontWeight.w400),),
//                                  ],
//                                ),
//                              )
//
//                            ],
//                          ),
//                        )
//                      ],
//                    )),
//              )
//            ],
//          ),
//        )


          FutureBuilder(
              future: lessons,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text('Вы не создали ни одного шаблона занятий'),
                    );
                  } else {
                    List lessons = snapshot.data;
                    return ListView(
                        children: lessons
                            .map((lesson) => UserLessonCard(lessonModel: lesson, updateList: updateList,))
                            .toList());
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
          ),
    );
  }
}
