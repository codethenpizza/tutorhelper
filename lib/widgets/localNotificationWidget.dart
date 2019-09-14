import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tutor_helper/localNotificationHelper.dart';

//import 'package:tutor_helper/screens/ForTests.dart';
//import 'package:tutor_helper/screens/ClassesList.dart';
import 'package:tutor_helper/main.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  //IMPORTANT
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //IMPORTANT/

  final notifications = FlutterLocalNotificationsPlugin();

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
            title: new Text('sadsadsa'),
            content: new Text(body),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: new Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                },
              )
            ],
          ),
    );
  }

  @override
  void initState() {
    super.initState();

    //IMPORTANT
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('app_icon');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
    //IMPORTANT/



    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
//        MaterialPageRoute(builder: (context) => ForTests(payload: payload)),
        MaterialPageRoute(builder: (context) => MyApp()),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            title('Basics'),
            RaisedButton(
              child: Text('Show notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'Tite', body: 'Плоти'),
            ),
            RaisedButton(
              child: Text('Show test notification'),
              onPressed: () async {
                //IMPORTANT
                var android = AndroidNotificationDetails(
                    'channel id', 'channel name', 'channel description');
                var iOS = IOSNotificationDetails();
                var platform = NotificationDetails(android, iOS);
                var scheduledNotificationDateTime = new DateTime.now().add(Duration(seconds: 10));
                await flutterLocalNotificationsPlugin.schedule(0, 'Title ', 'Body', scheduledNotificationDateTime, platform);
                //IMPORTANT/
              },
            ),
            RaisedButton(
              child: Text('Replace notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'ReplacedTitle', body: 'ReplacedBody'),
            ),
            RaisedButton(
              child: Text('Other notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'OtherTitle', body: 'OtherBody', id: 20),
            ),
            const SizedBox(height: 32),
            title('Feautures'),
            RaisedButton(
              child: Text('Silent notification'),
              onPressed: () => showSilentNotification(notifications,
                  title: 'SilentTitle', body: 'SilentBody', id: 30),
            ),
            const SizedBox(height: 32),
            title('Cancel'),
            RaisedButton(
              child: Text('Cancel all notification'),
              onPressed: notifications.cancelAll,
            ),
          ],
        ),
      );

  Widget title(String text) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      );
}
