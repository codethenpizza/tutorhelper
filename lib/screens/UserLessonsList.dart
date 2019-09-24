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
          FutureBuilder(
              future: lessons,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text('Вы не создали ни одного шаблона занятий', style: TextStyle( color:  Theme.of(context).hintColor)),
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
