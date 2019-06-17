import 'package:flutter/material.dart';
import 'package:tutor_helper/models/StudentModel.dart';

class StudentCard extends StatelessWidget {

  final StudentModel student;
  final String className;


  StudentCard(this.student, {this.className});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF3f4674),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(student.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
//              Text('16 лет', style: TextStyle(color: Colors.white),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                className != null ?
                Row(
                  children: <Widget>[
                    ClipRRect(borderRadius: BorderRadius.circular(50),
                      child: Container(height: 15,width: 15, color: Color(0xFF5dcb9a),),),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(className, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                    ),
                  ],
                )
                    :Container(),

                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.phone, color: Colors.white,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.alternate_email, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
