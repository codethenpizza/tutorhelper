import 'package:flutter/material.dart';

import 'package:tutor_helper/config/themeConfig.dart';

class Class extends StatefulWidget {
  @override
  State createState() => ClassState();
}

class ClassState extends State<Class> {
  @override
  Widget build(BuildContext context) {
    return ClassCard();
  }
}

class ClassCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: DarkTheme.prm,
        borderOnForeground: false,
        elevation: 0,
        child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('12:30', style: TextStyle(fontSize: 20,color: DarkTheme.txt, fontWeight: FontWeight.bold),),
                    Text('1000R', style: TextStyle(fontSize: 20,color: DarkTheme.txt, fontWeight: FontWeight.bold),),
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: DarkTheme.prm,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: <Widget>[

                              Text('Андрей Торбенков', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: DarkTheme.txt),),
                            ],
                          )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ClipRRect(borderRadius: BorderRadius.circular(50),
                                  child: Container(height: 15,width: 15, color: Color(0xFF5dcb9a),),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text('Math', style: TextStyle(color:DarkTheme.txt, fontWeight: FontWeight.bold, fontSize: 15),),
                                ),
                              ],
                            ),

                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.phone, color: DarkTheme.txt,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.alternate_email, color: DarkTheme.txt),
                                ),
                              ],
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )


    );
  }
}
