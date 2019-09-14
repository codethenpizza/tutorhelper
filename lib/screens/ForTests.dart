import 'package:flutter/material.dart';
import 'package:tutor_helper/widgets/localNotificationWidget.dart';

class ForTests extends StatelessWidget {
  final String payload;

  const ForTests({
    @required this.payload,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: LocalNotificationWidget(),
    ),
  );
}