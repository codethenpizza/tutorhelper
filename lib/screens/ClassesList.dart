import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_helper/widgets/ClassWidget.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'package:tutor_helper/widgets/WeekChartWidget.dart';
import 'dart:math' as math;
import 'package:tutor_helper/widgets/LessonsListWidget.dart';
import 'package:tutor_helper/widgets/WeekChartWidget.dart';
import 'ClassCreate.dart';

class ClassesList extends StatefulWidget {
  @override
  State createState() => ClassesListState();
}
//TODO: add ajax on subject list
//TODO: make label for deleted students & subjects
class ClassesListState extends State<ClassesList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
//                  height: 180,
                  child: FutureBuilder<List<StLessonModel>>(

                      future: StLessonModel().allComing(date:getDate()),
                      builder: (BuildContext context, AsyncSnapshot<List<StLessonModel>> snapshot) {
//                        print(snapshot);
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0)
                            return Container();

                          List list = snapshot.data;

                          return Column(

                            children: <Widget>[

                              Container(
                                child: SizedBox(
                                  height: 180,
//                            child: StackedBarChart(list: list,),
                                  child: StackedBarChart(list: list,),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text('Загрузка', style: TextStyle( color:  Theme.of(context).hintColor)),
                          );
                        }
                      }),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: FutureBuilder<List<StLessonModel>>(
                        future: StLessonModel().allComing(),
                        builder: (BuildContext context, AsyncSnapshot<List<StLessonModel>> snapshot) {
//                          print(snapshot);
                          if (snapshot.hasData) {
                            if (snapshot.data.length == 0)
                              return Center(
                                child: Text(
                                  'Занятия отсутствуют',
                                  style: TextStyle(fontSize: 20, color: Theme.of(context).hintColor ),
                                ),
                              );

                            List list = snapshot.data;

                            return Container(
                              child: LessonsListWidget(list: list,),
//                            <Widget>[
//                              Expanded(
//                                child: SizedBox(
//                                  height: 200,
//                                  child: LessonsListWidget(list: list,),
//                                ),
//                              )
//                            ],
                            );
                          } else {
                            return Center(
                              child: Text('Загрузка', style: TextStyle( color:  Theme.of(context).hintColor)),
                            );
                          }
                        }),
                  )


                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ClassCreate()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  getDate() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, 00, 00, 00);
    return date;
  }

//  String _getDateString(DateTime maxDate) {
//    DateTime today = DateTime.now();
//
//    if (maxDate.day == today.day) return 'Сегодня';
//    if (maxDate.day == today.add(Duration(days: 1)).day) return 'Завтра';
//
//    return DateFormat('MMMd', 'ru').format(maxDate);
//  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
