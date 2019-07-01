import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
//theme
import 'package:tutor_helper/config/themeConfig.dart';

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
                  enabledBorder:
                  UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: DarkTheme.txt)),
                  focusedBorder:
                  UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                          DarkTheme.acc)),
                  labelText: 'Название',
                  labelStyle: TextStyle(color: DarkTheme.txt),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: DarkTheme.txt)),
                ),
                onChanged: (str) {
                  name = str;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  enabledBorder:
                  UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: DarkTheme.txt)),
                  focusedBorder:
                  UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                          DarkTheme.acc)),
                  labelText: 'Описание',
                  labelStyle: TextStyle(color: DarkTheme.txt),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: DarkTheme.txt)),
                ),
                minLines: 2,
                maxLines: 5,
                onChanged: (str) {
                  desc = str;
                },
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder:
                    UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: DarkTheme.txt)),
                    focusedBorder:
                    UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                            DarkTheme.acc)),
                  labelText: 'Цена',
                  labelStyle: TextStyle(color: DarkTheme.txt),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: DarkTheme.txt)),
                ),
                keyboardType: TextInputType.number,
                onChanged: (str) {
                  cost = int.parse(str);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                  color: DarkTheme.btn,
                  onPressed: () => createLesson(context),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8),
                    child: const Text('Создать',
                        style: TextStyle(
                            fontSize: 20,
                            color: DarkTheme.txt)),
                  ),
                ),
              ),
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
