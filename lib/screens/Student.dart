import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/main.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:tutor_helper/screens/StudentEdit.dart';
import 'package:tutor_helper/widgets/ClassWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class Student extends StatefulWidget {
  final StudentModel student;

  Student(this.student);

  @override
  State createState() => StudentState();
}

class StudentState extends State<Student> {
  LessonModel lesson;
  StudentModel student;

  @override
  void initState() {
    student = widget.student;
    super.initState();
  }

  void removeStudent(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(isInitialRoute: true),
          builder: (context) => AlertDialog(
                title: Text('Вы уверенны, что хотите удалить ученика?'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Отмена'),
                      onPressed: () => Navigator.pop(context)),
                  RaisedButton(
                      textColor: Colors.white,
                      child: Text('Удалить'),
                      onPressed: () async {
                        await student.delete();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        studentListKey.currentState.updateState();
                        Flushbar(
                          message: 'Ученик удален',
                          duration: Duration(seconds: 2),
                        )..show(context);
                      }),
                ],
              ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeStudent(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentEdit(student))).then((model) {
              if (model != null)
                setState(() {
                  student = model;
                });
              studentListKey.currentState.updateState();
            }),
        child: Icon(Icons.edit),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.phone), onPressed: () => launch("tel:${student.phone}")),
                  Text(student.phone.toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.sms), onPressed: () => launch("sms:${student.phone}")),
                  Text(student.phone.toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.email), onPressed: () => launch("sms:${student.phone}")),
                  Text(student.email.toString()),
                ],
              ),
            ],
          ),

          FutureBuilder(
            future: student.nextLesson(),
            builder: (context, snap){
              if(snap.hasData){
                if(snap.data != null){
                  return ClassWidget(snap.data);
                }else{
                  return Text('Занятия отсутствуют');
                }
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          )
        ],
      ),
    );
  }
}
