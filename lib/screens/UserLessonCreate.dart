import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:tutor_helper/widgets/Layout.dart';

import '../ColorPicker.dart';

class UserLessonCreate extends StatefulWidget {
  UserLessonCreate() : super();

  @override
  State createState() => UserLessonCreateState();
}

class UserLessonCreateState extends State<UserLessonCreate> {
  String name;
  String desc;
  int duration;
  int cost;
  int _color = Colors.red.value;
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Layout(
        title: "Создание урока",
        child:
        Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
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
                          ColorPicker(
                            elevation: 10,
                            shrinkWrap: true,
                            onMainColorChange: (ColorSwatch color) {
                              _color = color.value;
                            },
                            selectedColor: Color(_color),
                            allowShades: false,
                            colors: [
                              Colors.red,
                              Colors.deepOrange,
                              Colors.yellow,
                              Colors.lightGreen,
                              Colors.blueAccent,
                            ],
                            circleSize: 40,
                          ),
                          TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Название не может быть пустым";
                              } else {
                                name = value;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Название',
                            ),
//                                  onChanged: (str) {
//                                    name = str;
//                                  },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Описание',
                            ),
                            minLines: 2,
                            maxLines: 5,
                            onChanged: (str) {
                              desc = str;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //last block w/ button
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
                          TextFormField(
                            validator: (String value) {
                              if (value.isEmpty && value != null) {
                                return "Укажите длительность";
                              }
//                                      else if (value ){
//                                        return "Укажите длительность";
//                                      }
                              else {
                                duration = int.parse(value);
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Длительность в минутах',
                            ),
                            keyboardType: TextInputType.number,
//                                  onChanged: (str) {
//                                    duration = int.parse(str);
//                                  },
                          ),
                          TextFormField(
                            validator: (String value) {
                              if (value.isEmpty && value != null) {
                                return "Укажите цену урока";
                              }
//                                      else if (value ){
//                                        return "Укажите длительность";
//                                      }
                              else {
                                cost = int.parse(value);
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Цена',
                            ),
                            keyboardType: TextInputType.number,
//                                    onChanged: (str) {
//                                      cost = int.parse(str);
//                                    },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    createLesson();
                                  }
                                });
                              },
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
        ));
  }

  createLesson() async {
    LessonModel lesson = new LessonModel(
        color: _color, name: name, desc: desc, duration: duration, cost: cost);

    await lesson.save();

    Navigator.pop(context);
    Flushbar(
      message: 'Шаблон создан',
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
