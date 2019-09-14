import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:tutor_helper/localNotificationHelper.dart';
import 'package:tutor_helper/models/LessonModel.dart';
import 'main.dart';
import 'models/StLessonModel.dart';
import 'database/DBProvider.dart';
import 'models/StudentModel.dart';

class Notifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  BuildContext context;
  AndroidInitializationSettings androidSettings;
  IOSInitializationSettings iOSSettings;

  AndroidNotificationDetails android;
  IOSNotificationDetails iOS;

  InitializationSettings initSettings;
  NotificationDetails platform;

  Notifications(this.context) {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    androidSettings = AndroidInitializationSettings('app_icon');
    iOSSettings = IOSInitializationSettings();
    initSettings = InitializationSettings(androidSettings, iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
    android = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      importance: Importance.High,
      priority: Priority.High,
      ongoing: false,
      autoCancel: false,
//      channelShowBadge: true,
    );
    iOS = IOSNotificationDetails();

    platform = NotificationDetails(android, iOS);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );



  void setNotify(StLessonModel stLesson) async {

    String lessonTime = DateFormat('Hm', 'ru').format(DateTime.parse(stLesson.date));
    LessonModel lesson = await LessonModel().find(stLesson.lessonId);
    StudentModel student = await StudentModel().find(stLesson.studentId);

//    var scheduledNotificationDateTime = new DateTime.now().add(Duration(seconds: 10));
    DateTime notifDate = DateTime.parse(stLesson.date).subtract(Duration(hours: 1));
//    print(lessonTime);
//    print(notifDate);
    var scheduledNotificationDateTime = notifDate;
    await flutterLocalNotificationsPlugin.schedule(stLesson.id, 'У вас занятие в ${lessonTime}!', '${student.name}, ${lesson.name}', scheduledNotificationDateTime, platform);
  }
}
