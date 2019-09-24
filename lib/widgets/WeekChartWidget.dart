import 'dart:convert';

/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class StackedBarChart extends StatelessWidget {

  List<StLessonModel> list;
  final bool animate;


  StackedBarChart({this.list, this.animate});


//  /// Creates a stacked [BarChart] with sample data and no transition.
//  factory StackedBarChart.withSampleData() {
//    return new StackedBarChart(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }


  @override
  Widget build(BuildContext context) {
    getDate() {
      DateTime now = DateTime.now();
      DateTime date = DateTime(now.year, now.month, now.day, 00, 00, 00);
//      print(date);
      return date;
    }

    getWeekday(date) {
      DateTime fDate = DateTime.parse(date);
      var formatter = new DateFormat('E', 'ru_RU');
      var weekday = formatter.format(fDate);
      return weekday;
    }

    getDaysArr(){
      Map<String, int> weekDays = {};
      var tdDate = getDate();
      for (var i = 0; i < 7; i++) {
        var day =  tdDate.add(Duration(days: i));
        var weekDay = getWeekday(day.toString());
        weekDays[weekDay] = 0;
      }

      return weekDays;
    }


//    print("==-=-=-=-");
//    print(list.map((x) => x.toMap()).toList());
    var finalDataSample = [];
    var unqLesson = [];
    var currentDate = getDate();
    DateTime finalDate = currentDate.add(Duration(days: 7));
//    print(finalDate);
    list = list.where((e) => finalDate.isAfter(DateTime.parse(e.date))).toList();
    Map<int, Map<String, int>> lessonsMap = {};


//    print('LIST' + list.map((item) => item.toMap()).toList().toString());
    list.forEach((item) {
      var daysArr = getDaysArr();
//      print('weekDays '+daysArr.toString());
      if(!lessonsMap.containsKey(item.lessonId))
        lessonsMap[item.lessonId] = daysArr;

      lessonsMap[item.lessonId][getWeekday(item.date)]++;
//      print('MAP'+item.toMap().toString());
//      print('lessonId'+item.lessonId.toString());
//      print('lessonsMap' + lessonsMap.toString());
    });

//    print("______________");
//    print(lessonsMap);
    List<charts.Series<LessonsPerDay, String>> chartList = [];

    lessonsMap.forEach((lesson, values) {
      List<LessonsPerDay> LPD = [];

      values.forEach((day, count){
        LPD.add(LessonsPerDay(day,count));
      });

      chartList.add(
          new charts.Series<LessonsPerDay, String>(
            id: lesson.toString(),
            domainFn: (LessonsPerDay lpd, _) => lpd.day,
            measureFn: (LessonsPerDay lpd, _) => lpd.count,
            data: LPD,
          )
      );
    });



    return new charts.BarChart(
      chartList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
//      defaultInteractions: false,
    );
//  return Container();
  }




}

class LessonsPerDay {
  final String day;
  final int count;

  LessonsPerDay(this.day, this.count);
}


