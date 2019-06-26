import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_helper/config/themeConfig.dart';
class ClassP extends StatefulWidget {
  @override
  _ClassPState createState() => _ClassPState();
}

class _ClassPState extends State<ClassP> {
  @override
  Widget build(BuildContext context) {
    return ClassPCard();
  }
}

class ClassPCard extends StatefulWidget {
  @override
  _ClassPCardState createState() => _ClassPCardState();
}

class _ClassPCardState extends State<ClassPCard> {
  var _buttOneColor = DarkTheme.prm;
  var _buttTwoColor = DarkTheme.prm;
  var _buttThreeColor = DarkTheme.prm;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
//          children: <Widget>[ClassTopPart(), HomeScreenBottomPart()],
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: DarkTheme.acc,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Arthur\nMarkovich',
                          style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                              color: DarkTheme.txt),
                        ),
                        Text(
                          '20.09.19 — Математика',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: DarkTheme.txt),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: DarkTheme.acc,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      decoration: BoxDecoration(
                          color: DarkTheme.main, //bg color
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(36.0),
                              topRight: Radius.circular(36.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20, right: 20, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              //homework
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '60 Минут',
                                      style: TextStyle(
                                          color: DarkTheme.txt, fontSize: 15),
                                    ),
                                    Text(
                                      '1000Р',
                                      style: TextStyle(
                                          color: DarkTheme.txt, fontSize: 15),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 13),
                                  child: Text(
                                    'Домашнее задание',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        color: DarkTheme.txt),
                                  ),
                                ),
                                Container(
//                              color: Colors.blue,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: DarkTheme.prm //homework card color
                                    ,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                color: DarkTheme.acc,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3.0),
                                              child: Text(
                                                'Математика',
                                                style: TextStyle(
                                                    color: DarkTheme.txt,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                          'Nam volutpat eget quam sit amet pellentesque. Nullam at finibus neque. '
                                          'Vestibulum pharetra sem a est rutrum, quis vestibulum diam facilisis. '
                                          'Pellentesque habitant morbi tristique senectus et netus et '
                                          'malesuada fames ac turpis egestas.',
                                          style: TextStyle(
                                              color: DarkTheme.txt,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        //after class
                                        padding: const EdgeInsets.only(
                                            top: 15.0, bottom: 13),
                                        child: Text(
                                          'После урока',
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600,
                                              color: DarkTheme.txt),
                                        ),
                                      ),
                                      Row(
                                        //after class icons
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: _buttOneColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Icon(
                                                  Icons.directions_walk,
                                                  color: DarkTheme.txt,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                if (_buttOneColor ==
                                                    DarkTheme.prm) {
                                                  _buttOneColor = DarkTheme.acc;
                                                } else {
                                                  _buttOneColor =
                                                      DarkTheme.prm;
                                                }
                                              });
                                            },
                                          ),
                                          InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: _buttTwoColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Icon(
                                                  Icons.work,
                                                  color: DarkTheme.txt,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                if (_buttTwoColor ==
                                                    DarkTheme.prm) {
                                                  _buttTwoColor = DarkTheme.acc;
                                                } else {
                                                  _buttTwoColor =
                                                      DarkTheme.prm;
                                                }
                                              });
                                            },
                                          ),
                                          InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: _buttThreeColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Icon(
                                                  Icons.account_balance_wallet,
                                                  color: DarkTheme.txt,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                if (_buttThreeColor ==
                                                    DarkTheme.prm) {
                                                  _buttThreeColor = DarkTheme.acc;
                                                } else {
                                                  _buttThreeColor =
                                                      DarkTheme.prm;
                                                }
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        //after class
                                        padding: const EdgeInsets.only(
                                            top: 15.0, bottom: 13),
                                        child: Text(
                                          'Добавить новый',
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600,
                                              color: DarkTheme.txt),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(DateFormat('dd-MM-yyyy H:m').format(selectedDate), style: TextStyle(color: DarkTheme.txt),),
                                              RaisedButton(
                                                color: DarkTheme.prm,
                                                onPressed: () => _selectDate(context),
                                                child: Text('Выбрать дату', style: TextStyle(color: DarkTheme.txt),),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            style: new TextStyle(
                                                color: DarkTheme.txt),
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
                                                labelText: 'Class',
                                                labelStyle: TextStyle(
                                                    color: DarkTheme.txt),
                                                border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: DarkTheme.txt))),
                                          ),
                                          TextFormField(
                                            style: TextStyle(
                                              color: DarkTheme.txt,
                                            ),
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
                                                labelText: 'Homework',
                                                labelStyle: TextStyle(
                                                    color: DarkTheme.txt),
                                                border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: DarkTheme.txt))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: RaisedButton(
                                              color: DarkTheme.btn,
                                              onPressed: () {},
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8),
                                                child: const Text('Готово',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: DarkTheme.txt)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ))
          ], //add bottom here
        ),
      ),
    );
  }
}

class ClassTopPart extends StatefulWidget {
  @override
  _ClassTopPartState createState() => _ClassTopPartState();
}

class _ClassTopPartState extends State<ClassTopPart> {
  Widget build(BuildContext context) {
    var _buttColor = Color(0xFF3f4674);

    return new Container(
        child: Column(
      children: <Widget>[
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Arthur\nMarkovich',
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '20.09.19 — Математика',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              decoration: BoxDecoration(
                  color: Color(0xFF383c5d), //card color
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36.0),
                      topRight: Radius.circular(36.0))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, left: 20, right: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      //homework
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '60 Минут',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              '1000Р',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 13),
                          child: Text(
                            'Домашнее задание',
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        Container(
//                              color: Colors.blue,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Color(0xFF3f4674) //homework card color
                            ,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Text(
                                        'Математика',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                  'Nam volutpat eget quam sit amet pellentesque. Nullam at finibus neque. '
                                  'Vestibulum pharetra sem a est rutrum, quis vestibulum diam facilisis. '
                                  'Pellentesque habitant morbi tristique senectus et netus et '
                                  'malesuada fames ac turpis egestas.',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                //after class
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 13),
                                child: Text(
                                  'После урока',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              Row(
                                //after class icons
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFF3f4674),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.directions_walk,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFF3f4674),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.work,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
//                                      Container(
//                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
//                                          color: Color(0xFF3f4674),
//                                        ),
//                                        child: Padding(
//                                          padding: const EdgeInsets.all(15.0),
//                                          child: Icon(Icons.payment, color: Colors.white,size: 40,),
//                                        ),
//                                      ),

                                  InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xFF3f4674),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Icon(
                                          Icons.work,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _buttColor = Colors.white;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                //after class
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 13),
                                child: Text(
                                  'Добавить новый',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    style: new TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue)),
                                        labelText: 'Date',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                  ),
                                  TextFormField(
                                    style: new TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue)),
                                        labelText: 'Class',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue)),
                                        labelText: 'Homework',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: RaisedButton(
                                      color: Color(0xFF3f4674),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: const Text('Готово',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
