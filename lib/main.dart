import 'package:flutter/material.dart';
import 'package:tutor_helper/screens/ClassCreate.dart';
import 'package:tutor_helper/screens/ClassesList.dart';
import 'package:tutor_helper/screens/Dashboard.dart';
import 'package:tutor_helper/screens/Class.dart';
import 'package:tutor_helper/screens/StudentsList.dart';
import 'package:tutor_helper/widgets/StudentCard.dart';
//import 'package:tutor_helper/screens/ForTests.dart';
import 'package:tutor_helper/screens/UserLessonCreate.dart';

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

class DrawerItem {
  String title;
  IconData icon;
  Widget widget;
  DrawerItem(this.title, this.icon, this.widget);
}

class MyHomePage extends StatefulWidget {

  final List<DrawerItem> drawerItems = [
    DrawerItem('Главная', Icons.home, StudentsList()),
    DrawerItem('Ученики', Icons.people, StudentsList()),
    DrawerItem('Расписание', Icons.access_time, ClassesList()),
    DrawerItem('Архив', Icons.archive, ClassesList()),
    DrawerItem('Статистика', Icons.equalizer, ClassesList()),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedDrawerIndex = 0;

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }

  _getDrawerItemWidget(int pos) {
    return widget.drawerItems[pos].widget;
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }


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
            Column(children: drawerOptions),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Настройки'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserLessonCreate()));
                    },
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
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

class MainWrap extends StatelessWidget{

  final Widget child;
  final Widget floatingActionButton;

  MainWrap({this.child, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    print(child.runtimeType.toString());
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Ученики'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsList()));
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('Расписание'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesList()));
                },
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
        body: child,
        floatingActionButton: floatingActionButton,
    );
  }
}
