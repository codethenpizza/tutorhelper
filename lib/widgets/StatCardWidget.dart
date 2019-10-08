import 'package:flutter/material.dart';
import 'package:tutor_helper/widgets/CardLayout.dart';
import 'package:tutor_helper/database/DBProvider.dart';
import 'dart:math' as math;


class StatCardWidget extends StatefulWidget {
  StatCardWidget({ Key key }) : super(key: key);

  @override
  createState() => StatCardWidgetState();

}

class StatCardWidgetState extends State<StatCardWidget> {

  //functions
  Future allMoney;
  getAllMoney() async {
    final db = await DBProvider.db.database;
    var resp = await db.rawQuery('SELECT SUM(total_cost) FROM S_Lessons WHERE payed = 1');
    var result = resp[0]['SUM(total_cost)'] == null ? 0 : resp[0]['SUM(total_cost)'];
    return result;
  }

  Future allPayed;
  getAllPayed() async {
    final db = await DBProvider.db.database;
    var resp = await db.rawQuery('SELECT SUM(payed) FROM S_Lessons WHERE payed = 1');
    var result = resp[0]['SUM(payed)'] == null ? 0 : resp[0]['SUM(payed)'];
    return result;
  }

  Future allUnPayed;
  getAllUnPayed() async {
    final db = await DBProvider.db.database;
//    String today =  DateTime.now().toIso8601String();
    var resp = await db.rawQuery("SELECT Count(payed) FROM S_Lessons WHERE date < ? AND payed = 0", [DateTime.now().toIso8601String()]);
//    var res = await db.query(
//      'S_Lesson',
//      orderBy: "date DESC",
//      where: "date < ? AND payed = 0",
//      whereArgs: [DateTime.now().toIso8601String()],
//    );
    var result = resp[0]['Count(payed)'] == null ? 0 : resp[0]['Count(payed)'];
    print(resp);
    return result;
//    return resp[0]['Count(payed)'];
  }

  Future allStudents;
  getAllStudents() async {
    final db = await DBProvider.db.database;
    var resp = await db.query('Students', columns: ['id']);
    return resp.length;
  }

  Future allHours;
  getAllHours() async {
    final db = await DBProvider.db.database;
    var resp = await db.rawQuery('SELECT SUM(duration) FROM S_Lessons');
    return resp[0]['SUM(duration)'];
  }

  Future allLessons;
  getAllLessons() async {
    final db = await DBProvider.db.database;
    var resp = await db.query('S_Lessons', columns: ['id']);
    return resp.length;
  }

  resetAll() {
    setState(() {
      allMoney = getAllMoney();
      allStudents = getAllStudents();
      allHours = getAllHours();
      allLessons = getAllLessons();
      allPayed = getAllPayed();
      allUnPayed = getAllUnPayed();
    });
  }

  @override
  void initState() {
    resetAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: ListView(

          scrollDirection: Axis.horizontal,
          children: <Widget>[

            //all money
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FutureBuilder(
                            future: allMoney,
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
            //all payed
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: allPayed,
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
                              Text('Всего уроков \n оплачено', textAlign: TextAlign.center,),
                            ],
                          ),
                        )))),
            //all unPayed
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: allUnPayed,
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
                              Text('Всего уроков \n  не оплачено', textAlign: TextAlign.center,),
                            ],
                          ),
                        )))),
            //all lessons
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: allLessons,
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
                          child:
                          FutureBuilder(
                            future: allHours,
                            builder: (context, snap) {
                              if (snap.hasData) {
                                print(snap.data);
                                var is_minutes = snap.data < 60;
                                var time = is_minutes ? snap.data : (snap.data/60).toStringAsFixed(0);
//                                var time =  snap.data;
                                return Column(
                                   children: <Widget>[
                                     SizedBox(
                                       height: 15,
                                     ),
                                     Text(
                                       time.toString(),
//                                       time.toString(),
                                       style: TextStyle(
                                           fontSize: 35,
                                           color: Theme.of(context).accentColor),
                                     ),
                                     SizedBox(
                                       height: 1,
                                     ),
                                     is_minutes ?
                                     Text('Всего минут \n потрачено', textAlign: TextAlign.center,) : Text('Всего часов \n потрачено', textAlign: TextAlign.center,)
                                   ],
                                );

                              } else {
                                return Container();
                              }
                            },
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
                                future: allStudents,
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



//class StatCardWidget extends StatelessWidget {
//
//  //functions
//  getAllMoney() async {
//    final db = await DBProvider.db.database;
//    var resp = await db.rawQuery('SELECT SUM(total_cost) FROM S_Lessons WHERE payed = 1');
//    var result = resp[0]['SUM(total_cost)'] == null ? 0 : resp[0]['SUM(total_cost)'];
//    return result;
//  }
//
//  getAllStudents() async {
//    final db = await DBProvider.db.database;
//    var resp = await db.query('Students', columns: ['id']);
//    return resp.length;
//  }
//
//  getAllHours() async {
//    final db = await DBProvider.db.database;
//    var resp = await db.rawQuery('SELECT SUM(duration) FROM S_Lessons');
//    return resp[0]['SUM(duration)'];
//  }
//
//  getAllLessons() async {
//    final db = await DBProvider.db.database;
//    var resp = await db.query('S_Lessons', columns: ['id']);
//    return resp.length;
//  }
//
//
//  Widget build(BuildContext context) {
//    return Container(
//        height: 200,
//        width: MediaQuery.of(context).size.width,
//        child: ListView(
//
//          scrollDirection: Axis.horizontal,
//          children: <Widget>[
//
//            Card(
//                child: Padding(
//                    padding: const EdgeInsets.all(15.0),
//                    child: Container(
//                        child: Center(
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          FutureBuilder(
//                            future: getAllMoney(),
//                            builder: (context, snap) {
//                              if (snap.hasData) {
//                                return Text(
//                                  snap.data.toString(),
//                                  style: TextStyle(
//                                      fontSize: 35,
//                                      color: Theme.of(context).accentColor),
//                                );
//                              } else {
//                                return Container();
//                              }
//                            },
//                          ),
//                          Text('Всего денег \n заработано', textAlign: TextAlign.center,),
//                        ],
//                      ),
//                    )))),
//            //card - all lessons
//            Card(
//                child: Padding(
//                    padding: const EdgeInsets.all(15.0),
//                    child: Container(
//                        child: Center(
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              FutureBuilder(
//                                future: getAllLessons(),
//                                builder: (context, snap) {
//                                  if (snap.hasData) {
//                                    return Text(
//                                      snap.data.toString(),
//                                      style: TextStyle(
//                                          fontSize: 35,
//                                          color: Theme.of(context).accentColor),
//                                    );
//                                  } else {
//                                    return Container();
//                                  }
//                                },
//                              ),
//                              Text('Всего уроков \n проведено', textAlign: TextAlign.center,),
//                            ],
//                          ),
//                        )))),
//            //card - all hours
//            Card(
//                child: Padding(
//                    padding: const EdgeInsets.all(15.0),
//                    child: Container(
//                        child: Center(
//                          child:
//                          FutureBuilder(
//                            future: getAllHours(),
//                            builder: (context, snap) {
//                              if (snap.hasData) {
//                                return Column(
//                                   children: <Widget>[
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Text(
//                                       snap.data.toString(),
//                                       style: TextStyle(
//                                           fontSize: 35,
//                                           color: Theme.of(context).accentColor),
//                                     ),
//                                     SizedBox(
//                                       height: 1,
//                                     ),
//                                     snap.data <= 60 ?
//                                     Text('Всего минут \n потрачено', textAlign: TextAlign.center,) : Text('Всего часов \n потрачено', textAlign: TextAlign.center,)
//                                   ],
//                                );
//
//                              } else {
//                                return Container();
//                              }
//                            },
//                          ),
//
//
//
//                        )))),
//            //card - all students
//            Card(
//                child: Padding(
//                    padding: const EdgeInsets.all(15.0),
//                    child: Container(
//                        child: Center(
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              FutureBuilder(
//                                future: getAllStudents(),
//                                builder: (context, snap) {
//                                  if (snap.hasData) {
//                                    return Text(
//                                      snap.data.toString(),
//                                      style: TextStyle(
//                                          fontSize: 35,
//                                          color: Theme.of(context).accentColor),
//                                    );
//                                  } else {
//                                    return Container();
//                                  }
//                                },
//                              ),
//                              Text('Всего человек \n обучалось', textAlign: TextAlign.center,),
//                            ],
//                          ),
//                        )))),
//          ],
//        ));
//  }
//}
