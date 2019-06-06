//import 'package:flutter/material.dart';
//
//
//
//
//class ClassCreate extends StatefulWidget {
//  @override
//  State createState() => ClassCreateState();
//}
//
//class ClassCreateState extends State<ClassCreate> {
//  @override
//  Widget build(BuildContext context) {
//    return ListView(
//      children: <Widget>[ClassCard()],
//    );
//  }
//}
//
//class ClassCard extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Column(children: <Widget>[
//      DropdownButton<String>(
//        isExpanded: true,
//
//        items: <String>['One', 'Two', 'Free', 'Four']
//            .map<DropdownMenuItem<String>>((String value) {
//          return DropdownMenuItem<String>(
//            value: "1",
//            child: Text("one"),
//          );
//        })
//        value: ,
//        onChanged: (String newValue) {
//          setState(() {
//            _value = value;
//          });
//        },
//      ),
//    ]);
//  }
//}
