//import 'package:flutter/material.dart';
//
//class CardLayout extends StatelessWidget {
//  final Widget child;
//
//  const CardLayout({Key key, this.child}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.only(bottom: 8.0),
//      child: ClipRRect(
//        borderRadius: BorderRadius.circular(10.0),
//        child: Container(
//          color: Theme.of(context).backgroundColor,
//          child: Padding(
//            padding: const EdgeInsets.all(15.0),
//            child:  this.child
//            ),
//          ),
//        ),
//      );
//  }
//
//
//}

import 'package:flutter/material.dart';

class CardLayout extends StatelessWidget {
  final List<Widget> children;

  const CardLayout({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child:  Column(
                children: children
              )
          ),
        ),
      ),
    );
  }


}

