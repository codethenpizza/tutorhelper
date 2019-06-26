import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:intl/intl.dart';
import 'package:tutor_helper/config/themeConfig.dart';


class ClassCreate extends StatefulWidget {
  @override
  State createState() => ClassCreateState();
}

class ClassCreateState extends State<ClassCreate> {
  int studentId;
  int lessonId;
  int duration;
  int totalCost;

  //start
  DateTime selectedDate = DateTime.now();

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
        initialTime: TimeOfDay.now(),);

    if (picked != null)
      setState(() {
        selectedDate = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, picked.hour, picked.minute);
      });
  }
  //end

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('TutorHelper'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    return DropdownButton(
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          studentId = val;
                        });
                        print(studentId);
                      },
                      items: list,
                      value: studentId,
                      hint: Text('--Ученик--'),
                    );
                  }else{
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
                    return DropdownButton(
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          lessonId = val;
                        });
                        print(lessonId);
                      },
                      items: list,
                      value: lessonId,
                      hint: Text('--Урок--'),
                    );
                  }else{
                    return Text('Загрузка');
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(DateFormat('dd-MM-yyyy HH:mm').format(selectedDate)),
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Выбрать дату'),
                  ),
                ],
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Длительность в минутах'
                ),
                onChanged: (str) {
                  duration = int.parse(str);
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Конечная стоимость',
                ),
                onChanged: (str) {
                  totalCost = int.parse(str);
                },
              ),
              RaisedButton(
                onPressed: () => createClass(context),
                child: Text('Создать'),
              )
            ],
          ),
        ),
      );

  createClass(BuildContext context) async {
    StLessonModel stLesson = new StLessonModel(
      studentId: studentId,
      lessonId: lessonId,
      date: selectedDate.toIso8601String(),
      duration: duration,
      totalCost: totalCost
    );
    await stLesson.save();
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Студент создан!'),duration: Duration(seconds: 1),));
    Navigator.pop(context);
  }
}
