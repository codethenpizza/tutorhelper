import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tutor_helper/main.dart';
import 'package:tutor_helper/widgets/ClassWidget.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'dart:math' as math;

import 'ClassCreate.dart';
import 'StudentCreate.dart';

class ClassesList extends StatefulWidget {
  @override
  State createState() => ClassesListState();
}

class ClassesListState extends State<ClassesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: StLessonModel().allComing(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0)
                return Center(
                  child: Text('Занятия отсутствуют'),
                );

//              return ListView.builder(
//                itemCount: snapshot.data.length,
//                itemBuilder: (BuildContext context, int index) {
//                  print(snapshot.data);
//                  var sLesson = snapshot.data[index];
//                  return ClassWidget(sLesson);
//                },
//              );

//              return CustomScrollView(
//                slivers: <Widget>[
//
//                  SliverPersistentHeader(
//                    pinned: true,
//                    floating: true,
//                    delegate: _SliverAppBarDelegate(
//                      maxHeight: 100,
//                      minHeight: 70,
//                      child: Container(
//                          color: Colors.lightBlue, child: Center(child:
//                      Text('Чтв 20'))
//                      ),
//                    ),
//                  ),
//                  SliverList(
//                    delegate: SliverChildBuilderDelegate((context, index) {
//                      var sLesson = snapshot.data[index];
//                      return ClassWidget(sLesson);
//                    }, childCount: snapshot.data.length),
//                  )
//                ],
//              );
              List list = snapshot.data;
              List<Widget> _slivers = [];

//              DateTime maxDate = DateTime.parse(list[0].date);
//              int maxDay = maxDate.day;

              DateTime maxDate = DateTime.now();
              int maxDay = 0;

              List<Widget> _sliverWidgets = [];

              for(int index = 0; index < list.length; index++) {
                DateTime itemDate = DateTime.parse(list[index].date);
                int itemDay = itemDate.day;

                print(['maxDay', maxDay, 'itemDay', itemDay, 'index', index]);

                if (itemDay != maxDay) {
                  maxDate = itemDate;
                  maxDay = itemDay;

                  if(index != 0){
                    _slivers.add(
                        SliverList(delegate: SliverChildListDelegate(_sliverWidgets))
                    );
                    _sliverWidgets = [];
                  }

                  _slivers.add(
                      SliverPersistentHeader(
                        pinned: true,
//                        floating: true,
                        delegate: _SliverAppBarDelegate(
                          maxHeight: 70,
                          minHeight: 50,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Color(0xFF383c51),
                                boxShadow: [
                                  BoxShadow(color: Color(0x55000000), blurRadius: 4)
                                ],
                              ),
                              child: Center(child:
                          Text(_getDateString(maxDate), style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white
                          ),))
                          ),
                        ),
                      )
                  );
                }
                _sliverWidgets.add(ClassWidget(list[index]));

              }

              _slivers.add(
                  SliverList(delegate: SliverChildListDelegate(_sliverWidgets))
              );

              return CustomScrollView(
                slivers: _slivers
              );
            } else {
              return Center(
                child: Text('Загрузка'),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
//            print(await StLessonModel().getAllLessons());
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ClassCreate()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _getDateString(DateTime maxDate) {
    int today = DateTime.now().day;

    if(maxDate.day == today) return 'Сегодня';
    if(maxDate.day == today+1) return 'Завтра';

    return DateFormat('MMMd').format(maxDate);
  }
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
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return new SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}