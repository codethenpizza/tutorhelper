import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/main.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:tutor_helper/screens/StudentEdit.dart';
import 'package:tutor_helper/widgets/ClassWidget.dart';
import 'package:tutor_helper/widgets/StudentSingleClassWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tutor_helper/widgets/CardLayout.dart';

class Student extends StatefulWidget {
  final StudentModel student;

  Student(this.student);

  @override
  State createState() => StudentState();
}

class StudentState extends State<Student> {
  LessonModel lesson;
  StudentModel student;

  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    student = widget.student;
    super.initState();
    scrollController.addListener(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Stack(children: <Widget>[
      new Container( //TODO Layout
        child: new Image.asset('assets/appbarfullbg.jpg', fit: BoxFit.cover, height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,),
        color: Colors.lightGreen,
      ),
      new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).backgroundColor,
              ),
              onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentEdit(student)))
                      .then((model) {
                    if (model != null)
                      setState(() {
                        student = model;
                      });
                    studentListKey.currentState.updateState();
                  }),
            )
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 0.0),
                child: Container(
                  //color: Theme.of(context).backgroundColor,
                  child: ListView(
                    controller: scrollController,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 40, bottom: 15),
                        child: Container(
                          child: Text(
                            student.name,
                            style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 33),
                          ),
                        ),
                      ),
                      CardLayout(
                          children: <Widget>[
                              //space inside block
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.phone),
                                    onPressed: () =>
                                        launch("tel:${student.phone}")),
                                Text(student.phone.toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.sms),
                                    onPressed: () =>
                                        launch("sms:${student.phone}")),
                                Text(student.phone.toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.email),
                                    onPressed: () =>
                                        launch("mailto:${student.email}")),
                                Text(student.email.toString()),
                              ],
                            ),
                          ],
                      ),

                       FutureBuilder(
                          future: student.nextLesson(),
                          builder: (context, snap){
                            if(snap.hasData){
                              if(snap.data != false){
                                return StudentSingleClassWidget(snap.data);
                              }else{
                                return CardLayout(
                                  children: <Widget>[
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 50),
                                        child: Text('Занятия отсутствуют', style: Theme.of(context).textTheme.body2,),
                                      )
                                    )

                                  ],
                                );
                              }
                            }else{
                              return Center(child: CircularProgressIndicator(),);
                            }
                          },
                        ),


                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      )
    ]));
  }
}
