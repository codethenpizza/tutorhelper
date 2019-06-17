import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  State createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
        ClassCard(),
      ],
    );
  }
}



class ClassCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
//      elevation: 0,
      child: InkWell(
        onTap: (){},
        child: Container(
//          height: 100,
          padding: EdgeInsets.all(10),
          child: Text('Иван Иванов', style: TextStyle(fontSize: 20),),
        ),
      )
    );
  }
}
