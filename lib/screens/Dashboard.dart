import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/widgets/DashboardWidget.dart';
import 'package:tutor_helper/screens/ClassCreate.dart';
import 'package:tutor_helper/widgets/SortingWidget.dart';


class Dashboard extends StatefulWidget {
  @override
  State createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  Future lessons;
  Future comingLessons;
  Future pastLessons;


  @override
  void initState() {
    super.initState();
    lessons = StLessonModel().all();
    pastLessons = StLessonModel().allPast();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          FutureBuilder(
            future: lessons,
            builder: (context, snapshot){
              if(snapshot.hasData){
                if(!snapshot.data.isEmpty)
                  return Container();
                else
                  return DashboardWidget(
                    title: 'Обучение',
                    child: Column(
                      children: <Widget>[
                        Text('Добро пожаловать!'),
                        Text('Давайте создадим первое занятие'),
                        RaisedButton(
                          child: Text('Создать'),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ClassCreate())),
                        )
                      ],
                    ),
                  );
              }else{
                return Container();
              }
            },
          ),
          SortingWidget(),
        ],
      ),
    );
  }
}

