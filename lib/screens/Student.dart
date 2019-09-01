import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
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
    return Container(
        child: new Stack(children: <Widget>[
      new Container(
        child: new Image.asset('assets/appbarfullbg.jpg', fit: BoxFit.cover, height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,),
        color: Colors.lightGreen,
      ),
      new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
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
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 40, bottom: 15),
                child: Container(
                  child: Text(
                    student.name,
                    style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 40),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Container(
                  //color: Theme.of(context).backgroundColor,
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
                                              launch("sms:${student.phone}")),
                                      Text(student.email.toString()),
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
                                  //space inside block
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Programming"),
                                        Text("1000Р"),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 10,
                                      width: 500,
                                      color: Colors.amber,
                                      //lesson color
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '12.03, ВТ',
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              '23:11',
                                              style: TextStyle(fontSize: 30),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color:
                                                  Theme.of(context).accentColor,
                                              size: 25,
                                            ),
                                            Text(
                                              '23:11',
                                              style: TextStyle(fontSize: 30),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("lorem ipsum dolor"),
                                        Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae tempus lorem. Curabitur ipsum quam, interdum eget quam mollis, fermentum volutpat augueLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae tempus lorem. Curabitur ipsum quam, interdum eget quam mollis, fermentum volutpat augueLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae tempus lorem. Curabitur ipsum quam, interdum eget quam mollis, fermentum volutpat augue.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

//                                Column(
//                                  children: <Widget>[
//                                    Row(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      children: <Widget>[
//                                        IconButton(icon: Icon(Icons.phone),
//                                            onPressed: () =>
//                                                launch("tel:${student.phone}")),
//                                        Text(student.phone.toString()),
//                                      ],
//                                    ),
//                                    Row(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      children: <Widget>[
//                                        IconButton(icon: Icon(Icons.sms),
//                                            onPressed: () =>
//                                                launch("sms:${student.phone}")),
//                                        Text(student.phone.toString()),
//                                      ],
//                                    ),
//                                    Row(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      children: <Widget>[
//                                        IconButton(icon: Icon(Icons.email),
//                                            onPressed: () =>
//                                                launch("sms:${student.phone}")),
//                                        Text(student.email.toString()),
//                                      ],
//                                    ),
//                                  ],
//                                ),
//                                FutureBuilder(
//                                  future: student.nextLesson(),
//                                  builder: (context, snap) {
//                                    if (snap.hasData) {
//                                      if (snap.data != null) {
//                                        return ClassWidget(snap.data);
//                                      } else {
//                                        return Text('Занятия отсутствуют');
//                                      }
//                                    } else {
//                                      return Center(child: CircularProgressIndicator(),);
//                                    }
//                                  },
//                                ),
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

//
//@override
//Widget build(BuildContext context) {
//  return Container(
//    child: new Stack(
//      children: <Widget>[
//        new Container(
//          child: new Image.asset('assets/appbarfullbg.jpg'),
//          color: Colors.lightGreen,
//        ),
//        Scaffold(
//          backgroundColor: Colors.transparent,
//          appBar: AppBar(
//            title: Text('TutorHelper'),
//            backgroundColor: Colors.transparent,
//            elevation: 0.0,
//          ),
//          body: Padding(
//            padding: EdgeInsets.all(8.0),
//            child: ListView(
//              children: <Widget>[
//                //block
//                Padding(
//                  padding: EdgeInsets.only(bottom: 8.0),
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.circular(10.0),
//                    child: Container(
//                      color: Theme.of(context).backgroundColor,
//                      child: Padding(
//                        padding: const EdgeInsets.all(15.0),
//                        child: Column(
//                          children: <Widget>[
//                            //space inside block
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                MaterialColorPicker(
//                                  onMainColorChange: (ColorSwatch color) {
//                                    _color = color.value;
//                                  },
//                                  selectedColor: Color(_color),
//                                  allowShades: false,
////                selectedColor: Colors.red,
//                                  colors: [
//                                    Colors.red,
//                                    Colors.deepOrange,
//                                    Colors.yellow,
//                                    Colors.lightGreen,
//                                    Colors.blueAccent,
//                                    Colors.blueAccent,
//                                  ],
//                                  circleSize: 40,
//                                ),
//                              ],
//                            ),
//                            TextField(
//                              decoration: InputDecoration(
//                                labelText: 'Название',
//                              ),
//                              onChanged: (str) {
//                                name = str;
//                              },
//                            ),
//                            TextField(
//                              decoration: InputDecoration(
//                                labelText: 'Описание',
//                              ),
//                              minLines: 2,
//                              maxLines: 5,
//                              onChanged: (str) {
//                                desc = str;
//                              },
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//                //last block w/ button
//                Padding(
//                  padding: EdgeInsets.only(bottom: 8.0),
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.circular(10.0),
//                    child: Container(
//                      color: Theme.of(context).backgroundColor,
//                      child: Padding(
//                        padding: const EdgeInsets.all(15.0),
//                        child: Column(
//                          children: <Widget>[
//                            //space inside block
//                            TextField(
//                              decoration: InputDecoration(
//                                labelText: 'Длительность в минутах',
//                              ),
//                              keyboardType: TextInputType.number,
//                              onChanged: (str) {
//                                duration = int.parse(str);
//                              },
//                            ),
//                            TextField(
//                              decoration: InputDecoration(
//                                labelText: 'Цена',
//                              ),
//                              keyboardType: TextInputType.number,
//                              onChanged: (str) {
//                                cost = int.parse(str);
//                              },
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top: 10.0),
//                              child: RaisedButton(
//                                onPressed: () => createLesson(),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text(
//                                      'Создать',
//                                      style: TextStyle(
//                                          color: Theme.of(context)
//                                              .backgroundColor,
//                                          fontSize: 17),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
//        )
//      ],
//    ),
//  );
//}
