import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class FeedbackScreen extends StatelessWidget {
  final String email = "info@code-on.space";

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        child: ListView (
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Здравствуйте!", style: TextStyle(color: Theme.of(context).accentColor, fontSize: 25),),
                  SizedBox(
                    height: 10,
                  ),
                  Text("На данный момент это приложение находится в разработке. \nЕсли у вас что-то не работает или у вас есть идеи как его улучшить или вам совсем не понятно что тут происходит, пожалуйста напишите нам на почту, мы будем очень признательны вам за любую обратную связь!",
                  style: TextStyle(fontWeight: FontWeight.w400),),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      onPressed: () =>
                          launch("mailto:${email}"),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Написать", style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 20),),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/dev.gif",
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      );
  }
}