import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class UserLessonCreate extends StatefulWidget {

  @override
  State createState() => UserLessonCreateState();
}

class UserLessonCreateState extends State<UserLessonCreate> {
  String name;
  String desc;
  int cost;
  int _color;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('TutorHelper'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MaterialColorPicker(
                onMainColorChange: (ColorSwatch color) {
                  _color = color.value;
                },
                allowShades: false,
//                selectedColor: Colors.red,
                colors: [
                  Colors.red,
                  Colors.deepOrange,
                  Colors.yellow,
                  Colors.lightGreen,
                  Colors.blueAccent,
                ],
                circleSize: 50,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Название'
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
                    labelText: 'Цена'
                ),
                keyboardType: TextInputType.number,
                onChanged: (str) {
                  cost = int.parse(str);
                },
              ),
              RaisedButton(
                onPressed: () => createLesson(context),
                child: Text('Создать'),
              )
            ],
          ),
        ),
      );

  createLesson(BuildContext context) async {
    LessonModel lesson = new LessonModel(color: _color, name: name, desc: desc, cost: cost);
//    print(lesson.toMap());
    await lesson.save();
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Студент создан!'),duration: Duration(seconds: 1),));
    Navigator.pop(context);
  }
}
