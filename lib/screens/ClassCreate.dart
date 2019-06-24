import 'package:flutter/material.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/models/StudentModel.dart';
import 'package:intl/intl.dart';

class ClassCreate extends StatefulWidget {
  @override
  State createState() => ClassCreateState();
}

class ClassCreateState extends State<ClassCreate> {
  int studentId;
  int lessonId;

  //start
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _selectTime(context);
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,);

    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        selectedDate = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute);
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
                  Text(DateFormat('dd-MM-yyyy H:m').format(selectedDate)),
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
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Конечная стоимость',
                ),
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
    StLessonModel stLesson = new StLessonModel();
    await stLesson.save();
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Студент создан!'),duration: Duration(seconds: 1),));
    Navigator.pop(context);
  }
}
