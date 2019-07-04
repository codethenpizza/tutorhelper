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

//                      style: TextStyle(color: Colors.white),
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          studentId = val;
                        });
                        print(studentId);
                      },
                      items: list,
                      value: studentId,
                      hint: Text('Ученик', style: TextStyle(color: DarkTheme.txt),),
                    );
                  }else{
                    return Text('Загрузка', style: TextStyle(color: DarkTheme.txt),);
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
                      hint: Text('Урок', style: TextStyle(color: DarkTheme.txt)),
                    );
                  }else{
                    return Text('Загрузка', style: TextStyle(color: DarkTheme.txt));
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(DateFormat('dd-MM-yyyy HH:mm').format(selectedDate), style: TextStyle(color: DarkTheme.txt),),
//                  RaisedButton(
//                    onPressed: () => _selectDate(context),
//                    child: Text('Выбрать дату'),
//                  ),
                  RaisedButton(
                    color: DarkTheme.btn,
                    onPressed: () => _selectDate(context),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8),
                      child: Text('Выбрать дату',
                          style: TextStyle(
                              fontSize: 15,
                              color: DarkTheme.txt)),
                    ),
                  ),
                ],
              ),
              TextField(
                style: TextStyle(color: DarkTheme.txt),
                keyboardType: TextInputType.number,
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
                  labelText: 'Длительность в минутах',
                    labelStyle: TextStyle(
                        color: DarkTheme.txt),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: DarkTheme.txt)),
                ),
                onChanged: (str) {
                  duration = int.parse(str);
                },
              ),
              TextField(
                style: TextStyle(color: DarkTheme.txt),
                keyboardType: TextInputType.number,
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
                    labelText: 'Конечная стоимость',
                  labelStyle: TextStyle(
                      color: DarkTheme.txt),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: DarkTheme.txt)),
                ),
                onChanged: (str) {
                  totalCost = int.parse(str);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                  color: DarkTheme.btn,
                  onPressed: () => createClass(context),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8),
                    child: Text('Создать',
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
