import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_helper/widgets/ArchiveClassWidget.dart';
import 'package:tutor_helper/models/StLessonModel.dart';
import 'dart:math' as math;
import 'package:tutor_helper/widgets/StatCardWidget.dart';

final GlobalKey<StatCardWidgetState> key = new GlobalKey<StatCardWidgetState>();

class ClassesArchive extends StatefulWidget {
  @override
  State createState() => ClassesArchiveState();
}

class ClassesArchiveState extends State<ClassesArchive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: StLessonModel().allPast(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0)
                  return Center(
                    child: Text(
                      'Занятия отсутствуют',
                      style: TextStyle(fontSize: 20, color:  Theme.of(context).hintColor),
                    ),
                  );

                List list = snapshot.data;
                List<Widget> _slivers = [];

                _slivers.add(SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        StatCardWidget(key: key,),
                      ],
                    ),
                  )
                ])));

                DateTime maxDate = DateTime.now();
                int maxDay = 0;

                List<Widget> _sliverWidgets = [];

                for (int index = 0; index < list.length; index++) {
                  DateTime itemDate = DateTime.parse(list[index].date);
                  int itemDay = itemDate.day;

                  if (itemDay != maxDay) {
                    maxDate = itemDate;
                    maxDay = itemDay;

                    if (index != 0) {
                      _slivers.add(SliverList(
                          delegate: SliverChildListDelegate(_sliverWidgets)));
                      _sliverWidgets = [];
                    }

                    _slivers.add(SliverPersistentHeader(
                      pinned: true,
//                        floating: true,
                      delegate: _SliverAppBarDelegate(
                        maxHeight: 40,
                        minHeight: 5,
                        child: Container(
//                              margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x55000000), blurRadius: 4)
                              ],
                            ),
                            child: Center(
                                child: Text(
                              _getDateString(maxDate),
                              style: Theme.of(context).textTheme.headline,
                            ))),
                      ),
                    ));
                  }
                  _sliverWidgets.add(ArchiveClassWidget(list[index]));
                }

                _slivers.add(SliverList(
                    delegate: SliverChildListDelegate(_sliverWidgets)));

                return CustomScrollView(slivers: _slivers);
              } else {
                return Center(
                  child: Text('Загрузка', style: TextStyle( color:  Theme.of(context).hintColor)),
                );
              }
            }),
      ),
    );
  }

  String _getDateString(DateTime maxDate) {
    int today = DateTime.now().day;

    if (maxDate.day == today) return 'Сегодня';
    if (maxDate.day == today + 1) return 'Завтра';

    return DateFormat('MMMd', 'ru').format(maxDate);
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
