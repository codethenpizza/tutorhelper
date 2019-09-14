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
      var formatter = new DateFormat('E');
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
    );
//  return Container();
  }




//  /// Create series list with multiple series
//  static List<charts.Series<Map, String>> _weekLessons(list) {
//
////    for (var i = 0; i < list.length; i++) {
////      list[i].lesson_id
////    }
//    final desktopSalesData = [
//      new LessonsPerDay('2014', 5),
//      new LessonsPerDay('2015', 25),
//      new LessonsPerDay('2016', 100),
//      new LessonsPerDay('2017', 75),
//      new LessonsPerDay('2018', 100),
//      new LessonsPerDay('2019', 75),
//    ];
//
//    final tableSalesData = [
//      new LessonsPerDay('2014', 25),
//      new LessonsPerDay('2015', 50),
//      new LessonsPerDay('2016', 10),
//      new LessonsPerDay('2017', 20),
//    ];
//
//    final mobileSalesData = [
//      new LessonsPerDay('2014', 10),
//      new LessonsPerDay('2015', 15),
//      new LessonsPerDay('2016', 50),
//      new LessonsPerDay('2017', 45),
//    ];
//
//
//    return [
//
//      new charts.Series<Map, String>(
//        id: 'Desktop',
//        domainFn: (String sales, _) => sales.day,
//        measureFn: (LessonsPerDay sales, _) => sales.lessons,
//        data: lessonsMap,
//      ),
//      new charts.Series<LessonsPerDay, String>(
//        id: 'Tablet',
//        domainFn: (LessonsPerDay sales, _) => sales.day,
//        measureFn: (LessonsPerDay sales, _) => sales.lessons,
//        data: tableSalesData,
//      ),
//      new charts.Series<LessonsPerDay, String>(
//        id: 'Mobile',
//        domainFn: (LessonsPerDay sales, _) => sales.day,
//        measureFn: (LessonsPerDay sales, _) => sales.lessons,
//        data: mobileSalesData,
//      ),
//    ];
//  }
}

class LessonsPerDay {
  final String day;
  final int count;

  LessonsPerDay(this.day, this.count);
}


// / Bar chart example
//import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
//
//
//class StackedBarChart extends StatelessWidget {
//  final List seriesList;
//  final bool animate;
//
//  StackedBarChart(this.seriesList, {this.animate});
//
//  /// Creates a stacked [BarChart] with sample data and no transition.
//  factory StackedBarChart.withSampleData() {
//    return new StackedBarChart(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return new charts.BarChart(
//      seriesList,
//      animate: animate,
//      barGroupingType: charts.BarGroupingType.stacked,
//    );
//  }
//
//
//
//
//  /// Create series list with multiple series
//  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
//    final desktopSalesData = [
//      new OrdinalSales('2014', 5),
//      new OrdinalSales('2015', 25),
//      new OrdinalSales('2016', 100),
//      new OrdinalSales('2017', 75),
//      new OrdinalSales('2018', 100),
//      new OrdinalSales('2019', 75),
//    ];
//
//    final tableSalesData = [
//      new OrdinalSales('2014', 25),
//      new OrdinalSales('2015', 50),
//      new OrdinalSales('2016', 10),
//      new OrdinalSales('2017', 20),
//    ];
//
//    final mobileSalesData = [
//      new OrdinalSales('2014', 10),
//      new OrdinalSales('2015', 15),
//      new OrdinalSales('2016', 50),
//      new OrdinalSales('2017', 45),
//    ];
//
//    return [
//      new charts.Series<OrdinalSales, String>(
//        id: 'Desktop',
//        domainFn: (OrdinalSales sales, _) => sales.year,
//        measureFn: (OrdinalSales sales, _) => sales.sales,
//        data: desktopSalesData,
//      ),
//      new charts.Series<OrdinalSales, String>(
//        id: 'Tablet',
//        domainFn: (OrdinalSales sales, _) => sales.year,
//        measureFn: (OrdinalSales sales, _) => sales.sales,
//        data: tableSalesData,
//      ),
//      new charts.Series<OrdinalSales, String>(
//        id: 'Mobile',
//        domainFn: (OrdinalSales sales, _) => sales.year,
//        measureFn: (OrdinalSales sales, _) => sales.sales,
//        data: mobileSalesData,
//      ),
//    ];
//  }
//}
//
///// Sample ordinal data type.
//class OrdinalSales {
//  final String year;
//  final int sales;
//
//  OrdinalSales(this.year, this.sales);
//}

