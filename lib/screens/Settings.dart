import 'package:flutter/material.dart';
import 'package:tutor_helper/screens/UserLessonCreate.dart';
import 'package:tutor_helper/screens/UserLessonsList.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Шаблоны занятий'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserLessonsList())),
          )
        ],
      ),
    );
  }
}
