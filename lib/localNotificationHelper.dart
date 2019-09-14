import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

NotificationDetails get _noSound {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'silent channel id',
    'silent channel name',
    'silent channel description',
    playSound: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails(presentSound: false);

  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showSilentNotification(
    FlutterLocalNotificationsPlugin notifications, {
      @required String title,
      @required String body,
      int id = 0,
    }) =>
    _showNotification(notifications,
        title: title, body: body, id: id, type: _noSound);

NotificationDetails get _ongoing {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.High,
    priority: Priority.High,
    ongoing: false,
    autoCancel: true,
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}



Future showOngoingNotification(
    FlutterLocalNotificationsPlugin notifications, {
      @required String title,
      @required String body,
      int id = 0,
    }) =>
    _showNotification(notifications,
        title: title, body: body, id: id, type: _ongoing);

Future showTestNotification(
    FlutterLocalNotificationsPlugin showDailyAtTime, {
      @required String title,
      @required String body,
      int id = 0,
    }) =>
    _showNotification(showDailyAtTime,
        title: title, body: body, id: id, type: _ongoing);

//local
Future _showNotification(
    FlutterLocalNotificationsPlugin notifications, {
      @required String title,
      @required String body,
      @required NotificationDetails type,
      int id = 0,
    }) =>
    notifications.show(id, title, body, type);




//
//var scheduledNotificationDateTime =
//new DateTime.now().add(new Duration(seconds: 5));
//var androidPlatformChannelSpecifics =
//new AndroidNotificationDetails('your other channel id',
//    'your other channel name', 'your other channel description');
//var iOSPlatformChannelSpecifics =
//new IOSNotificationDetails();
//NotificationDetails platformChannelSpecifics = new NotificationDetails(
//    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//await flutterLocalNotificationsPluginschedule(
//0,
//'scheduled title',
//'scheduled body',
//scheduledNotificationDateTime,
//platformChannelSpecifics);
