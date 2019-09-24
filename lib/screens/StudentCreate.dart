import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StudentModel.dart';

//font awesome
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentCreate extends StatefulWidget {
  @override
  State createState() => StudentCreateState();
}

class StudentCreateState extends State<StudentCreate> {
  String name;
  String phone;
  String email;
  String skype;
  String address;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new Image.asset(
              'assets/appbarfullbg.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            color: Colors.lightGreen,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Создание ученика'),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Form(
              key: _formKey,
              child: ListView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
//                    height: MediaQuery.of(context).size.height - 110,
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Center(
                                child: Icon(
                          FontAwesomeIcons.user,
                          color: Theme.of(context).backgroundColor,
                          size: 120,
                        ))),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              color: Theme.of(context).backgroundColor,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "Название не может быть пустым";
                                        } else {
                                          name = value;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Имя',
                                      ),
//                                      onChanged: (str) {
//                                        name = str;
//                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Телефон',
                                      ),
                                      onChanged: (str) {
                                        phone = str;
                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Почта',
                                      ),
                                      onChanged: (str) {
                                        email = str;
                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Skype',
                                      ),
                                      onChanged: (str) {
                                        skype = str;
                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Адрес',
                                      ),
                                      onChanged: (str) {
                                        address = str;
                                      },
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (_formKey.currentState.validate()) {
                                              createStudent(context);
                                            }
                                          });
                                        },
//                                        onPressed: () => createStudent(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Создать',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  createStudent(BuildContext context) async {
    StudentModel student =
        new StudentModel(name: name, phone: phone, email: email, skype: skype, address: address);
    await student.save();
    Navigator.pop(context);
    Flushbar(
      message: 'Ученик создан',
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
