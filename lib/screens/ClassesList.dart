import 'package:flutter/material.dart';

import 'package:tutor_helper/main.dart';
import 'package:tutor_helper/widgets/ClassWidget.dart';
import 'package:tutor_helper/models/StLessonModel.dart';

import 'ClassCreate.dart';
import 'StudentCreate.dart';

class ClassesList extends StatefulWidget {
  @override
  State createState() => ClassesListState();
}

class ClassesListState extends State<ClassesList> {
  final Future future = StLessonModel().all();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: future,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0)
                  return Center(
                    child: Text('Занятия отсутствуют'),
                  );

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    StLessonModel item = snapshot.data[index];
                    return ClassWidget(item);
                  },
                );
              } else {
                return Center(
                  child: Text('Загрузка'),
                );
              }
            }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ClassCreate()));
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
