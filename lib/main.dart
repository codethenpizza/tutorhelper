import 'package:flutter/material.dart';
import 'package:tutor_helper/screens/ClassCreate.dart';
import 'package:tutor_helper/screens/ClassesList.dart';
import 'package:tutor_helper/screens/Dashboard.dart';
import 'package:tutor_helper/screens/Class.dart';
//import 'package:tutor_helper/screens/ForTests.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TutorHelper',
      theme: ThemeData(
//        backgroundColor: Color(0xFF383c5d),
          scaffoldBackgroundColor: Color(0xFF383c5d),
//        primaryColorDark: Colors.blue,
//        primarySwatch: Color(0xFF5dcb9a),
          primaryColor: Color(0xFF393c5e),
//      primaryColor: Color(0xFF5dcb9a),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('TutorHelper'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Главная'),
              selected: true,
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Ученики'),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Расписание'),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text('Архив'),
            ),
            ListTile(
              leading: Icon(Icons.equalizer),
              title: Text('Статистика'),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Настройки'),
                  ),
                  ListTile(
                    leading: Icon(Icons.feedback),
                    title: Text('Обратная связь'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: ClassP()

//          Column(
//            children: <Widget>[

//            ],
//          )




    );
  }
}
