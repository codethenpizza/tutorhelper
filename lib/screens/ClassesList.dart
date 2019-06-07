import 'package:flutter/material.dart';

import 'package:tutor_helper/widgets/Card.dart';

class ClassesList extends StatefulWidget{

  @override
  State createState() => ClassesListState();

}

class ClassesListState extends State<ClassesList>{

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("ПН 29.02.19", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
          ),

        ],
    ),

        Class(),
        Class(),
        Class(),
        Class(),
        Class(),
        Class(),
        Class(),
      ],
    );
  }
}