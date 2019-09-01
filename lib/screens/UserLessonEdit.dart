import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class UserLessonEdit extends StatefulWidget {
  final LessonModel lesson;
  final Function updateList;
  final BuildContext scaffoldContext;

  const UserLessonEdit(
      {Key key, this.lesson, this.updateList, this.scaffoldContext})
      : super(key: key);

  @override
  State createState() => UserLessonEditState();
}

class UserLessonEditState extends State<UserLessonEdit> {
  int _color;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController durationController = new TextEditingController();
  TextEditingController costController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _color = widget.lesson.color;
    nameController.text = widget.lesson.name;
    descController.text = widget.lesson.desc;
    durationController.text = widget.lesson.duration.toString();
    costController.text = widget.lesson.cost.toString();
  }

  void removeUserLesson() {
    Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(isInitialRoute: true),
          builder: (context) => AlertDialog(
                title: Text('Вы уверенны, что хотите удалить шаблон урока?'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Отмена'),
                      onPressed: () => Navigator.pop(context)),
                  RaisedButton(
                      textColor: Colors.white,
                      child: Text('Удалить'),
                      onPressed: () async {
                        await widget.lesson.delete();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Flushbar(
                          message: 'Шаблон удален',
                          duration: Duration(seconds: 2),
                        )..show(context);
                        widget.updateList();
                      }),
                ],
              ),
        ));
  }
  //TODO: change when lesson create will be ready
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('TutorHelper'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.delete), onPressed: removeUserLesson)
          ],
        ),
        body: Builder(builder: (context) {
          return Padding(
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
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Название',
                  ),
                ),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: 'Описание',
                  ),
                  minLines: 2,
                  maxLines: 5,
                ),
                TextField(
                  controller: durationController,
                  decoration: InputDecoration(
                    labelText: 'Длительность в минутах',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: costController,
                  decoration: InputDecoration(
                    labelText: 'Цена',
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    onPressed: () => editLesson(context),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: const Text('Обновить'),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      );

  editLesson(BuildContext context) async {
    LessonModel lesson = new LessonModel(
        id: widget.lesson.id,
        color: _color,
        name: nameController.text,
        desc: descController.text,
        duration: int.tryParse(durationController.text),
        cost: int.tryParse(costController.text));

    await lesson.save();

    Navigator.pop(context);
    widget.updateList();
    Flushbar(
      message: 'Шаблон изменен',
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
