import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flushbar/flushbar.dart';

class UserLessonCreate extends StatefulWidget {
  final Function updateList;

  UserLessonCreate({this.updateList}) : super();

  @override
  State createState() => UserLessonCreateState();
}

class UserLessonCreateState extends State<UserLessonCreate> {
  String name;
  String desc;
  int duration;
  int cost;
  int _color = Colors.red.value;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('TutorHelper'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              MaterialColorPicker(
                onMainColorChange: (ColorSwatch color) {
                  _color = color.value;
                },
                selectedColor: Color(_color),
                allowShades: false,
//                selectedColor: Colors.red,
                colors: [
                  Colors.red,
                  Colors.deepOrange,
                  Colors.yellow,
                  Colors.lightGreen,
                  Colors.blueAccent,
                ],
                circleSize: 40,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Название',
                ),
                onChanged: (str) {
                  name = str;
                },
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
              TextField(
                decoration: InputDecoration(
                  labelText: 'Длительность в минутах',
                ),
                keyboardType: TextInputType.number,
                onChanged: (str) {
                  duration = int.parse(str);
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Цена',
                ),
                keyboardType: TextInputType.number,
                onChanged: (str) {
                  cost = int.parse(str);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  textColor: Colors.white,
                  onPressed: () => createLesson(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: const Text('Создать'),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  createLesson() async {
    LessonModel lesson = new LessonModel(
        color: _color, name: name, desc: desc, duration: duration, cost: cost);

    await lesson.save();

    Navigator.pop(context);
    Flushbar(
      message: 'Шаблон создан',
      duration: Duration(seconds: 3),
    )..show(context);
    widget.updateList();
  }
}
