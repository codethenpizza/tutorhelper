//import 'package:flutter/material.dart';
//import 'package:tutor_helper/models/LessonModel.dart';
//import 'package:tutor_helper/models/StLessonModel.dart';
//import 'package:tutor_helper/models/StudentModel.dart';
//import 'package:tutor_helper/screens/StudentCreate.dart';
//import 'package:intl/intl.dart';
//import 'package:tutor_helper/screens/UserLessonCreate.dart';
//
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//
//class ClassCreate extends StatefulWidget {
//  @override
//  State createState() => ClassCreateState();
//}
//
//class ClassCreateState extends State<ClassCreate> {
//  int studentId;
//  int lessonId;
//  String homework;
//
//  TextEditingController durationController = new TextEditingController();
//  TextEditingController costController = new TextEditingController();
//
//  Future<List> students = StudentModel().all();
//  Future<List> lessons = LessonModel().all();
//
//  DateTime selectedDate = DateTime.now();
//
////  Future<Null> _selectDate(BuildContext context) async {
////    final DateTime picked = await showDatePicker(
////      context: context,
////      initialDate: selectedDate,
////      firstDate: DateTime(2015, 8),
////      lastDate: DateTime(2101),
////      locale: Locale('ru'),
////    );
////
////    if (picked != null) {
////      selectedDate = picked;
////      _selectTime(context);
////    }
////  }
////
////  Future<Null> _selectTime(BuildContext context) async {
////    final TimeOfDay picked = await showTimePicker(
////      context: context,
////      initialTime: TimeOfDay.now(),
////    );
////
////    if (picked != null)
////      setState(() {
////        selectedDate = new DateTime(selectedDate.year, selectedDate.month,
////            selectedDate.day, picked.hour, picked.minute);
////      });
////  }
//
//  @override
//  Widget build(BuildContext context) => Scaffold(
//        appBar: AppBar(
//          title: Text('TutorHelper'),
//        ),
//        body: Padding(
//          padding: EdgeInsets.all(8.0),
//          child: ListView(
//            children: <Widget>[
//              FutureBuilder(
//                future: students,
//                builder: (context, AsyncSnapshot<List> snapshot) {
//                  if (snapshot.hasData) {
//                    List<DropdownMenuItem> list = snapshot.data
//                        .map((x) => DropdownMenuItem(
//                              value: x.id,
//                              child: Text(x.name),
//                            ))
//                        .toList();
//                    return Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Expanded(
//                          child: DropdownButton(
//                            isExpanded: true,
//                            onChanged: (val) {
//                              setState(() {
//                                studentId = val;
//                              });
//                            },
//                            items: list,
//                            value: studentId,
//                            hint: Text('Ученик'),
//                          ),
//                        ),
//                        SizedBox(
//                          width: 20,
//                        ),
//                        InkWell(
//                          child: Icon(
//                            Icons.add_circle,
//                            color: Theme.of(context).accentColor,
//                          ),
//                          onTap: () => Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) =>
//                                          StudentCreate())).then((_) {
//                                setState(() {
//                                  students = StudentModel().all();
//                                });
//                              }),
//                        )
//                      ],
//                    );
//                  } else {
//                    return Text('Загрузка');
//                  }
//                },
//              ),
//              FutureBuilder(
//                future: lessons,
//                builder: (context, AsyncSnapshot<List> snapshot) {
//                  if (snapshot.hasData) {
//                    List<DropdownMenuItem> list = snapshot.data
//                        .map((x) => DropdownMenuItem(
//                              value: x.id,
//                              child: Text(x.name),
//                            ))
//                        .toList();
//                    return Row(
//                      children: <Widget>[
//                        Expanded(
//                          child: DropdownButton(
//                            isExpanded: true,
//                            onChanged: (val) {
//                              setState(() {
//                                lessonId = val;
//                                LessonModel _lesson = snapshot.data
//                                    .where((item) => item.id == val)
//                                    .first;
//                                costController.text = _lesson.cost.toString();
//                                durationController.text =
//                                    _lesson.duration.toString();
//                              });
//                            },
//                            items: list,
//                            value: lessonId,
//                            hint: Text('Урок'),
//                          ),
//                        ),
//                        SizedBox(
//                          width: 20,
//                        ),
//                        InkWell(
//                          child: Icon(
//                            Icons.add_circle,
//                            color: Theme.of(context).accentColor,
//                          ),
//                          onTap: () => Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) =>
//                                          UserLessonCreate())).then((_) {
//                                setState(() {
//                                  lessons = LessonModel().all();
//                                });
//                          }),
//                        )
//                      ],
//                    );
//                  } else {
//                    return Text('Загрузка');
//                  }
//                },
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    DateFormat('HH:mm - d MMMM yyyy', 'ru')
//                        .format(selectedDate),
//                    style: Theme.of(context).textTheme.body2,
//                  ),
////                  RaisedButton(
////                    onPressed: () => _selectDate(context),
////                    child: Text('Выбрать дату'),
////                  ),
//                  FlatButton(
//                      onPressed: () {
//                        DatePicker.showDateTimePicker(context,
//                            showTitleActions: true, onConfirm: (date) {
//                          print('confirm $date');
//                          setState(() {
//                            selectedDate = date;
//                          });
//                        }, currentTime: DateTime.now(), locale: LocaleType.ru);
//                      },
//                      child: Text(
//                        'Выбрать время',
//                        style: TextStyle(color: Colors.blue),
//                      )),
//                ],
//              ),
//              TextField(
//                controller: durationController,
//                keyboardType: TextInputType.number,
//                decoration: InputDecoration(
//                  labelText: 'Длительность в минутах',
//                ),
//              ),
//              TextField(
//                controller: costController,
//                keyboardType: TextInputType.number,
//                decoration: InputDecoration(
//                  labelText: 'Конечная стоимость',
//                ),
//              ),
//              TextField(
//                maxLines: 6,
//                minLines: 6,
//                decoration: InputDecoration(
//                  labelText: 'Домашнее задание',
//                ),
//                onChanged: (str) {
//                  homework = str;
//                },
//              ),
//              Padding(
//                padding: const EdgeInsets.symmetric(vertical: 10.0),
//                child: Container(
//                  child: Center(
////                    width: 50,
////                  child: RaisedButton(
////                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
////                    color: Theme.of(context).buttonColor,
////                    textColor: Colors.white,
////                    onPressed: () => createClass(context),
////                    child: Padding(
////                      padding: const EdgeInsets.only(left: 8.0, right: 8),
////                      child: Text('Создать'),
////                    ),
////                  ),
//                      child: RaisedButton(
//                    onPressed: () {},
//                    child: Padding(
//                      padding: const EdgeInsets.all(12.0),
//                      child: Text(
//                        'Создать',
//                        style: TextStyle(
//                            color: Theme.of(context).backgroundColor,
//                            fontSize: 17),
//                      ),
//                    ),
//                  )),
//                ),
//              ),
//            ],
//          ),
//        ),
//      );
//
//  createClass(BuildContext context) async {
//    StLessonModel stLesson = new StLessonModel(
//        studentId: studentId,
//        lessonId: lessonId,
//        date: selectedDate.toIso8601String(),
//        duration: int.parse(durationController.text),
//        totalCost: int.parse(costController.text),
//        homework: homework);
//    await stLesson.save();
////    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Студент создан!'),duration: Duration(seconds: 1),));
//    Navigator.pop(context);
//  }
//}

import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:tutor_helper/screens/StudentCreate.dart';
import 'package:intl/intl.dart';
import 'package:tutor_helper/screens/UserLessonCreate.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ClassCreate extends StatefulWidget {
  @override
  State createState() => ClassCreateState();
}

class ClassCreateState extends State<ClassCreate> {
  int studentId;
  int lessonId;
  String homework;

  TextEditingController durationController = new TextEditingController();
  TextEditingController costController = new TextEditingController();

  Future<List> students = StudentModel().all();
  Future<List> lessons = LessonModel().all();

  DateTime selectedDate = DateTime.now();

//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//      context: context,
//      initialDate: selectedDate,
//      firstDate: DateTime(2015, 8),
//      lastDate: DateTime(2101),
//      locale: Locale('ru'),
//    );
//
//    if (picked != null) {
//      selectedDate = picked;
//      _selectTime(context);
//    }
//  }
//
//  Future<Null> _selectTime(BuildContext context) async {
//    final TimeOfDay picked = await showTimePicker(
//      context: context,
//      initialTime: TimeOfDay.now(),
//    );
//
//    if (picked != null)
//      setState(() {
//        selectedDate = new DateTime(selectedDate.year, selectedDate.month,
//            selectedDate.day, picked.hour, picked.minute);
//      });
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new Image.asset('assets/appbarfullbg.jpg', fit: BoxFit.cover, height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,),
            color: Colors.lightGreen,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('TutorHelper'),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              FutureBuilder(
                                future: students,
                                builder:
                                    (context, AsyncSnapshot<List> snapshot) {
                                  if (snapshot.hasData) {
                                    List<DropdownMenuItem> list = snapshot.data
                                        .map((x) => DropdownMenuItem(
                                              value: x.id,
                                              child: Text(x.name),
                                            ))
                                        .toList();
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            onChanged: (val) {
                                              setState(() {
                                                studentId = val;
                                              });
                                            },
                                            items: list,
                                            value: studentId,
                                            hint: Text('Ученик'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          child: Icon(
                                            Icons.add_circle,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StudentCreate()))
                                                  .then((_) {
                                                setState(() {
                                                  students =
                                                      StudentModel().all();
                                                });
                                              }),
                                        )
                                      ],
                                    );
                                  } else {
                                    return Text('Загрузка');
                                  }
                                },
                              ),
                              FutureBuilder(
                                future: lessons,
                                builder:
                                    (context, AsyncSnapshot<List> snapshot) {
                                  if (snapshot.hasData) {
                                    List<DropdownMenuItem> list = snapshot.data
                                        .map((x) => DropdownMenuItem(
                                              value: x.id,
                                              child: Text(x.name),
                                            ))
                                        .toList();
                                    return Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            onChanged: (val) {
                                              setState(() {
                                                lessonId = val;
                                                LessonModel _lesson = snapshot
                                                    .data
                                                    .where((item) =>
                                                        item.id == val)
                                                    .first;
                                                costController.text =
                                                    _lesson.cost.toString();
                                                durationController.text =
                                                    _lesson.duration.toString();
                                              });
                                            },
                                            items: list,
                                            value: lessonId,
                                            hint: Text('Урок'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          child: Icon(
                                            Icons.add_circle,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserLessonCreate()))
                                                  .then((_) {
                                                setState(() {
                                                  lessons = LessonModel().all();
                                                });
                                              }),
                                        )
                                      ],
                                    );
                                  } else {
                                    return Text('Загрузка');
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    DateFormat('HH:mm - d MMMM yyyy', 'ru')
                                        .format(selectedDate),
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                  //                  RaisedButton(
                                  //                    onPressed: () => _selectDate(context),
                                  //                    child: Text('Выбрать дату'),
                                  //                  ),
                                  FlatButton(
                                      onPressed: () {
                                        DatePicker.showDateTimePicker(context,
                                            showTitleActions: true,
                                            onConfirm: (date) {
                                          print('confirm $date');
                                          setState(() {
                                            selectedDate = date;
                                          });
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.ru);
                                      },
                                      child: Text(
                                        'Выбрать время',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: durationController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Длительность в минутах',
                                ),
                              ),
                              TextField(
                                controller: costController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Конечная стоимость',
                                ),
                              ),
                              TextField(
                                maxLines: 6,
                                minLines: 6,
                                decoration: InputDecoration(
                                  labelText: 'Домашнее задание',
                                ),
                                onChanged: (str) {
                                  homework = str;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: RaisedButton(
                                  onPressed: () => createClass(context),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Создать',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).backgroundColor,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  createClass(BuildContext context) async {
    StLessonModel stLesson = new StLessonModel(
        studentId: studentId,
        lessonId: lessonId,
        date: selectedDate.toIso8601String(),
        duration: int.parse(durationController.text),
        totalCost: int.parse(costController.text),
        homework: homework);
    await stLesson.save();
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Студент создан!'),duration: Duration(seconds: 1),));
    Navigator.pop(context);
  }
}
