import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:intl/intl.dart';
import 'package:tutor_helper/widgets/Layout.dart';
import 'package:tutor_helper/widgets/CardLayout.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tutor_helper/SetNotifClass.dart';

class ClassEdit extends StatefulWidget {
  final StLessonModel sLesson;

  ClassEdit(this.sLesson);

  @override
  State createState() => ClassEditState();
}


class ClassEditState extends State<ClassEdit> {
  int studentId;
  int lessonId;
  DateTime selectedDate;

  TextEditingController durationController = new TextEditingController();
  TextEditingController costController = new TextEditingController();
  TextEditingController homeworkController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    studentId = widget.sLesson.studentId;
    lessonId = widget.sLesson.lessonId;
    durationController.text = widget.sLesson.duration.toString();
    costController.text = widget.sLesson.totalCost.toString();
    selectedDate = DateTime.parse(widget.sLesson.date);
    homeworkController.text = widget.sLesson.homework ?? '';
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null) {
      selectedDate = picked;
      _selectTime(context);
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null)
      setState(() {
        selectedDate = new DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, picked.hour, picked.minute);
      });
  }

  void removeClass() async {
    await widget.sLesson.delete();
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) =>
      Layout(
        title: 'Редактирование занятия',
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete), onPressed: removeClass)
        ],
        child: ListView(
          children: <Widget>[
            CardLayout(
              children: <Widget>[
                FutureBuilder(
                  future: StudentModel().all(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      List<DropdownMenuItem> list = snapshot.data
                          .map((x) => DropdownMenuItem(
                        value: x.id,
                        child: Text(x.name),
                      ))
                          .toList();
                      bool exist = list.where((item) => item.value == studentId).length == 1;
                      return DropdownButton(
                        isExpanded: true,
                        onChanged: (val) {
                          setState(() {
                            studentId = val;
                          });
                        },
                        items: list,
                        value: exist ? studentId : null,
                        hint: Text(exist ? 'Ученик' : 'Ученик был удален'),
                      );
                    } else {
                      return Text('Загрузка');
                    }
                  },
                ),
                FutureBuilder(
                  future: LessonModel().all(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      List<DropdownMenuItem> list = snapshot.data
                          .map((x) => DropdownMenuItem(
                        value: x.id,
                        child: Text(x.name),
                      ))
                          .toList();
                      bool exist = list.where((item) => item.value == lessonId).length == 1;
                      return DropdownButton(
                        isExpanded: true,
                        onChanged: (val) {
                          setState(() {
                            lessonId = val;
                          });
                        },
                        items: list,
                        value: exist ? lessonId : null,
                        hint: Text(exist ? 'Урок' : 'Урок был удален'),
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
                      DateFormat('HH:mm - d MMM yyyy', 'ru')
                          .format(selectedDate),
                      style: Theme.of(context).textTheme.body2,
                    ),
                    FlatButton(
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              onConfirm: (date) {
//                                print('confirm $date');
                                setState(() {
                                  selectedDate = date;
                                });
                              },
                              currentTime: selectedDate,
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
            CardLayout(
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
                  controller: homeworkController,
                  maxLines: 6,
                  minLines: 6,
                  decoration: InputDecoration(
                    labelText: 'Домашнее задание',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    onPressed: () => createClass(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Обновить',
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
          ],
        ),
      );




  createClass(BuildContext context) async {
    StLessonModel stLesson = new StLessonModel(
        id: widget.sLesson.id,
        studentId: studentId,
        lessonId: lessonId,
        date: selectedDate.toIso8601String(),
        duration: int.parse(durationController.text),
        totalCost: int.parse(costController.text),
        payed: widget.sLesson.payed,
        homework: homeworkController.text
    );
    var id = await stLesson.save();
    stLesson.id = id;
    Notifications(context).setNotify(stLesson);
//    await stLesson.save();
//    Notifications(context).setNotify(stLesson);

    Navigator.pop(context);
    Flushbar(
      message: 'Занятие изменено',
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
