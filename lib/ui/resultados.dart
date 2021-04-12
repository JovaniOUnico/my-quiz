import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  Results({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.lightBlueAccent),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(
                  "images/flor.png",
                  fit: BoxFit.cover,
                  width: 900,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(100, 90, 100, 0),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.white10,
                        width: 4.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'MEGA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        TextSpan(
                          text: ' QUIZ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[400]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(30, 90, 30, 0),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  )),
                  child: RichText(
                    text: TextSpan(
                      text: "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'MUITO ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: ' BEM!!',
                          style: TextStyle(color: Colors.green),
                        ),
                        TextSpan(
                          text: ' FALTOU POUCO!!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 90, 30, 0),
                  padding: const EdgeInsets.only(bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      text: "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '8 ACERTOS DE ',
                          style: TextStyle(color: Colors.orange),
                        ),
                        TextSpan(
                          text: ' 10',
                          style: TextStyle(color: Colors.purple),
                        ),
                        TextSpan(
                          text: ' PERGUNTAS ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
