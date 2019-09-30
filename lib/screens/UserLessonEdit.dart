import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/ColorPicker.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:tutor_helper/widgets/Layout.dart';
import 'package:tutor_helper/widgets/CardLayout.dart';

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
  var _formKey = GlobalKey<FormState>();

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


//  @override
//  Widget build(BuildContext context) => Container(
//          child: new Stack(children: <Widget>[
//        new Container(
//          child: new Image.asset(
//            'assets/appbarfullbg.jpg',
//            fit: BoxFit.cover,
//            height: MediaQuery.of(context).size.height,
//          ),
//          color: Colors.lightGreen,
//        ),
//        Scaffold(
//          backgroundColor: Colors.transparent,
//          appBar: AppBar(
//            title: Text('TutorHelper'),
//            backgroundColor: Colors.transparent,
//            elevation: 0.0,
//            actions: <Widget>[
//              IconButton(icon: Icon(Icons.delete), onPressed: removeUserLesson)
//            ],
//          ),
//          body: Builder(builder: (context) {
//            return Padding(
//              padding: const EdgeInsets.all(8.0),
//              child:
//              Form(
//                key: _formKey,
//                child: ListView(
//                children: <Widget>[
//                  CardLayout(
//                    children: <Widget>[
//                      ColorPicker(
//                        onMainColorChange: (ColorSwatch color) {
//                          _color = color.value;
//                        },
//                        elevation: 10,
//                        selectedColor: Color(_color),
//                        allowShades: false,
////                selectedColor: Colors.red,
//                        colors: [
//                          Colors.red,
//                          Colors.deepOrange,
//                          Colors.yellow,
//                          Colors.lightGreen,
//                          Colors.blueAccent,
//                        ],
//                        circleSize: 40,
//                      ),
//                      TextFormField(
//                        controller: nameController,
//                        validator: (String value) {
//                          if (value.isEmpty) {
//                            return "Название не может быть пустым";
//                          }
//                        },
//                        decoration: InputDecoration(
//                          labelText: 'Название',
//                        ),
//                      ),
//                      TextField(
//                        controller: descController,
//                        decoration: InputDecoration(
//                          labelText: 'Описание',
//                        ),
//                        minLines: 2,
//                        maxLines: 5,
//                      ),
//                    ],
//                  ),
//                  CardLayout(
//                    children: <Widget>[
//                      TextFormField(
//                        controller: durationController,
//                        validator: (String value) {
//                          if (value.isEmpty && value != null) {
//                            return "Укажите длительность";
//                          }
////                                      else if (value ){
////                                        return "Укажите длительность";
////                                      }
//                        },
//                        decoration: InputDecoration(
//                          labelText: 'Длительность в минутах',
//                        ),
//                        keyboardType: TextInputType.number,
//                      ),
//                      TextFormField(
//                        controller: costController,
//                        validator: (String value) {
//                          if (value.isEmpty && value != null) {
//                            return "Укажите цену урока";
//                          }
////                                      else if (value ){
////                                        return "Укажите длительность";
////                                      }
//                        },
//                        decoration: InputDecoration(
//                          labelText: 'Цена',
//                        ),
//                        keyboardType: TextInputType.number,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(top: 10.0),
//                        child: RaisedButton(
//                          onPressed: () {
//                            setState(() {
//                              if (_formKey.currentState.validate()) {
//                                editLesson(context);
//                              }
//                            });
//                          },
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Text(
//                                'Обновить',
//                                style: TextStyle(
//                                    color: Theme.of(context).backgroundColor,
//                                    fontSize: 17),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  )
//                ],
//              ),
//              ),
//            );
//          }),
//        )
//      ]));

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
                            controller: nameController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Название не может быть пустым";
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
                            controller: descController,
                            decoration: InputDecoration(
                              labelText: 'Описание',
                            ),
                            minLines: 2,
                            maxLines: 5,
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
                        controller: costController,
                        validator: (String value) {
                          if (value.isEmpty && value != null) {
                            return "Укажите цену урока";
                          }
//                                      else if (value ){
//                                        return "Укажите длительность";
//                                      }
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
                            controller: costController,
                            validator: (String value) {
                              if (value.isEmpty && value != null) {
                                return "Укажите цену урока";
                              }
    //                                      else if (value ){
    //                                        return "Укажите длительность";
    //                                      }
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
                                    editLesson(context);
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


