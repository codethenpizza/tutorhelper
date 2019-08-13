import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        selectedDate = new DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, selectedTime.hour, selectedTime.minute);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
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
                          ),
                        ),
                        Text(
                          '20.09.19 — Математика',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      decoration: BoxDecoration(
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      '1000Р',
                                      style: TextStyle(fontSize: 15),
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
                                    ),
                                  ),
                                ),
                                Container(
//                              color: Colors.blue,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
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
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3.0),
                                              child: Text(
                                                'Математика',
                                                style: TextStyle(fontSize: 20),
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
                                          style: TextStyle(fontSize: 15),
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
                                          ),
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
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Icon(
                                                  Icons.directions_walk,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {});
                                            },
                                          ),
                                          InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Icon(
                                                  Icons.work,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {});
                                            },
                                          ),
                                          InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Icon(
                                                  Icons.account_balance_wallet,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {});
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
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(DateFormat('dd-MM-yyyy H:m')
                                                  .format(selectedDate)),
                                              RaisedButton(
                                                onPressed: () =>
                                                    _selectDate(context),
                                                child: Text(
                                                  'Выбрать дату',
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Class',
                                            ),
                                          ),
                                          TextFormField(
                                            style: TextStyle(),
                                            decoration: InputDecoration(
                                              labelText: 'Homework',
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: RaisedButton(
                                              onPressed: () {},
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8),
                                                child: const Text('Готово',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    )),
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
