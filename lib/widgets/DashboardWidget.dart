import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  final Widget child;
  final String title;

  const DashboardWidget({Key key, this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.title,
          ),
        ),

        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 200,
          ),
          child: child,
        )
      ],
    ),
  );
}
