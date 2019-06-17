import 'package:flutter/material.dart';

class Student extends StatefulWidget {
  @override
  State createState() => StudentState();
}

class StudentState extends State<Student> {
  @override
  Widget build(BuildContext context) {
    return StudentCard();
  }
}

class StudentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
//          children: <Widget>[ClassTopPart(), HomeScreenBottomPart()],
          children: <Widget>[ClassTopPart(),], //add bottom here
        ),
      ),
    );
  }
}

class ClassTopPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    Text('Arthur\nMarkovich',style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold, color: Colors.white), ),
                    Text('20.09.19 — Math', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
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
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, ),
                  decoration: BoxDecoration(
                      color: Color(0xFF383c5d), //card color
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36.0),
                          topRight: Radius.circular( 36.0)
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column( //contacts
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Контакты', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600,color: Colors.white),),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Ученик', style: TextStyle(fontSize: 20,color: Colors.white),),
                                      Text('8 (999) 999 99 99', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                  Icon(Icons.phone,color: Colors.white,size: 30,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Ольга Васильевна', style: TextStyle(fontSize: 20,color: Colors.white),),
                                      Text('8 (999) 999 99 99', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                  Icon(Icons.phone,color: Colors.white,size: 30,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Николай Генадьевич', style: TextStyle(fontSize: 20,color: Colors.white),),
                                      Text('8 (999) 999 99 99', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                  Icon(Icons.phone,color: Colors.white,size: 30,)
                                ],
                              ),
                            ),

                          ],
                        ),
                        Column( //homework
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 13),
                              child: Text('Домашнее задание', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600,color: Colors.white),),
                            ),
                            Container(
//                              color: Colors.blue,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color(0xFF3f4674) //homework card color
                                ,),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        ClipRRect(borderRadius: BorderRadius.circular(50),
                                          child: Container(height: 15,width: 15, color: Colors.blue,),),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 3.0),
                                          child: Text('Math', style: TextStyle(color: Colors.white, fontSize: 20),),
                                        ),
                                      ],
                                    ),
                                    Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                        'Nam volutpat eget quam sit amet pellentesque. Nullam at finibus neque. '
                                        'Vestibulum pharetra sem a est rutrum, quis vestibulum diam facilisis. '
                                        'Pellentesque habitant morbi tristique senectus et netus et '
                                        'malesuada fames ac turpis egestas.',  style: TextStyle(color: Colors.white,fontSize: 15),)                                ],
                                ),
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
        )

    );
  }
}


