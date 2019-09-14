import 'package:flutter/material.dart';
import 'package:tutor_helper/widgets/CardLayout.dart';
import 'package:tutor_helper/database/DBProvider.dart';
import 'dart:math' as math;

class StatCardWidget extends StatelessWidget {
  //=stats variables=

  //lessons per Person (mid)
//  String MidlessonsPerStudent;

  //lessons per day (mid)
//  String MidLessonsPerDay;

  //most busy day
//  String MBDay;

  //most free day
//  String MFDay;

  //functions
  getAllMoney() async {
    final db = await DBProvider.db.database;
    var resp = await db.rawQuery('SELECT SUM(total_cost) FROM S_Lessons');
    return resp[0]['SUM(total_cost)'];
  }

  getAllStudents() async {
    final db = await DBProvider.db.database;
    var resp = await db.query('Students', columns: ['id']);
    return resp.length;
  }

  getAllHours() async {
    final db = await DBProvider.db.database;
    var resp = await db.rawQuery('SELECT SUM(duration) FROM S_Lessons');
    return resp[0]['SUM(duration)'];
  }

  getAllLessons() async {
    final db = await DBProvider.db.database;
    var resp = await db.query('S_Lessons', columns: ['id']);
    return resp.length;
  }



//  getAllLessons() async {
//    final db = await DBProvider.db.database;
//    var resp = await db.query('S_Lessons');
//
////    return resp.length.toString();
//
//  }

  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(12.0),
//              child: RaisedButton(
//                onPressed: getAllMoney,
//              ),
//            ),
            //card - all money
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FutureBuilder(
                            future: getAllMoney(),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                return Text(
                                  snap.data.toString(),
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Theme.of(context).accentColor),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          Text('Всего денег \n заработано', textAlign: TextAlign.center,),
                        ],
                      ),
                    )))),
            //card - all lessons
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: getAllLessons(),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return Text(
                                      snap.data.toString(),
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Theme.of(context).accentColor),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Text('Всего уроков \n проведено', textAlign: TextAlign.center,),
                            ],
                          ),
                        )))),
            //card - all hours
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: getAllHours(),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return Text(
                                      snap.data.toString(),
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Theme.of(context).accentColor),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Text('Всего часов \n потрачено', textAlign: TextAlign.center,),
                            ],
                          ),
                        )))),
            //card - all students
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: getAllStudents(),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return Text(
                                      snap.data.toString(),
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Theme.of(context).accentColor),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Text('Всего человек \n обучалось', textAlign: TextAlign.center,),
                            ],
                          ),
                        )))),
          ],
        ));
  }
}
