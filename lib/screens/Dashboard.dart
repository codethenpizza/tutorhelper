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
      child: ExpansionTile(
        children: <Widget>[
          Container(
            height: 200,
            child: Center(child: Text('asdas'),),
          )
        ],
        title: Padding(
          padding: EdgeInsets.all(0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.deepOrange,
                  child: Center(
                    child: Text('М', style: TextStyle(fontSize: 30, color: Colors.white),),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Иван Иванов', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Text('120 минут - 2000р'),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('12:20'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
