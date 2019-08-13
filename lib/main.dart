import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tutor_helper/screens/ClassesArchive.dart';
import 'package:tutor_helper/screens/ClassesList.dart';
import 'package:tutor_helper/screens/Dashboard.dart';
import 'package:tutor_helper/screens/Class.dart';
import 'package:tutor_helper/screens/Settings.dart';
import 'package:tutor_helper/screens/StudentsList.dart';
import 'package:tutor_helper/screens/UserLessonsList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TutorHelper',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
//        const Locale('en', 'US'),
        const Locale('ru', 'RU'),
      ],
      /*theme: ThemeData(
//        backgroundColor: Color(0xFF383c5d),
//          scaffoldBackgroundColor: DarkTheme.main,
//        primaryColorDark: Colors.blue,
//        primarySwatch: ,
//          primaryColor: DarkTheme.prm,
//      primaryColor: Color(0xFF5dcb9a),
      ),*/
      theme: ThemeData.light().copyWith(
        accentColor: Colors.greenAccent,
        primaryColor: Colors.green,
        buttonColor: Colors.green,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
          )
        ),
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

GlobalKey<StudentsListState> studentListKey = GlobalKey();

class MyHomePage extends StatefulWidget {
  final List<DrawerItem> drawerItems = [
    DrawerItem('Расписание', Icons.access_time, ClassesList()),
    DrawerItem('Архив', Icons.archive, ClassesArchive()),
    DrawerItem('Ученики', Icons.people, StudentsList(key: studentListKey,)),
    DrawerItem('Предметы', Icons.list, UserLessonsList()),
    DrawerItem('Обратная связь', Icons.feedback, UserLessonsList()),
//    DrawerItem('Главная', Icons.home, Dashboard()),
//    DrawerItem('Статистика', Icons.equalizer, ClassesList()),
//    DrawerItem('Тест (Class)', Icons.accessible_forward, ClassP()),
//    DrawerItem('Тест (Student)', Icons.accessible_forward, Student(1)),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedDrawerIndex = 0;
  String appBarTitle = 'TutorHelper';

  _onSelectItem(int index) {
    appBarTitle = widget.drawerItems[index].title;
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
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            child: ListView(
              padding: EdgeInsets.zero,
              children: drawerOptions,
            ),
          ),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
