//import 'package:flutter/material.dart';
//
//class Layout extends StatelessWidget {
//  final Widget child;
//  final String title;
//  final List<Widget> actions;
//
//  const Layout({Key key, this.child, this.title, this.actions})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        child: Stack(children: <Widget>[
//      Container(
//        child: Image.asset(
//          'assets/appbarfullbg.jpg',
//          fit: BoxFit.cover,
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//        ),
//        color: Colors.lightGreen,
//      ),
//      Scaffold(
//          backgroundColor: Colors.transparent,
//          appBar: AppBar(
//              title: Text(this.title),
//              backgroundColor: Colors.transparent,
//              elevation: 0.0,
//              actions: actions),
//          body: Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 8.0),
//              child: this.child))
//    ]));
//  }
//}

import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget> actions;

  const Layout({Key key, this.child, this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _blankFocusNode = new FocusNode();

    return Container(
        child: Stack(children: <Widget>[
          Container(
            child: Image.asset(
              'assets/appbarfullbg.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            color: Colors.lightGreen,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  title: Text(this.title),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  actions: actions),
              body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_blankFocusNode);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: this.child,
                  )))
        ]));
  }
}
