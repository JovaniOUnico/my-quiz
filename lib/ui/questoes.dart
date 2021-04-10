import 'package:flutter/material.dart';

class Questions extends StatefulWidget {
  Questions({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.red[200]),
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/flor.png",
              fit: BoxFit.cover,
              height: 200,
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.only(top: 120.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Qual A Resposta Certa?",
                          style:
                              TextStyle(color: Colors.white, fontSize: 30.0))),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: FlatButton(
                        onPressed: () {},
                        child: Text("Resposta A",
                            style: TextStyle(
                                color: Colors.white, fontSize: 30.0))),
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text("Resposta B",
                          style:
                              TextStyle(color: Colors.white, fontSize: 30.0))),
                  FlatButton(
                      onPressed: () {},
                      child: Text("Resposta C",
                          style:
                              TextStyle(color: Colors.white, fontSize: 30.0))),
                  FlatButton(
                      onPressed: () {},
                      child: Text("Resposta D",
                          style:
                              TextStyle(color: Colors.white, fontSize: 30.0)))
                ],
              ),
            )),
            Padding(
                padding: EdgeInsets.only(top: 160.0),
                child: Image.asset(
                  "images/flor.png",
                  fit: BoxFit.cover,
                  height: 200,
                ))
          ],
        ));
  }
}
