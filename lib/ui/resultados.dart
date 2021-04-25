import 'package:flutter/material.dart';
import 'package:my_quiz/ui/questoes.dart';
import 'package:my_quiz/ui/conjuntoLista.dart';

class Results extends StatefulWidget {
  int ofc_acertos;
  int ofc_erros;
  int ofc_qtd;
  String ofc_id_questoes;

  Results(this.ofc_acertos, this.ofc_erros, this.ofc_qtd, this.ofc_id_questoes);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blueGrey),
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
                      width: 1.0,
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
                          text: ' Você Completou o Quiz!! ',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  )),
                  margin: EdgeInsets.fromLTRB(30, 90, 30, 30),
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
                          text: widget.ofc_acertos.toString() + ' ACERTOS DE ',
                          style: TextStyle(color: Colors.green),
                        ),
                        TextSpan(
                          text: ' ' + widget.ofc_qtd.toString(),
                          style: TextStyle(color: Colors.purple),
                        ),
                        TextSpan(
                          text: ' PERGUNTAS ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: FlatButton(
                              onPressed: () {
                                //volta na primeira tela
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConjuntoLista(),
                                  ),
                                );
                              },
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              textColor: Colors.orange,
                              child: Text(
                                "Voltar ao Inicio",
                                style: TextStyle(fontSize: 38.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Questions(widget.ofc_id_questoes),
                                ),
                              );
                            },
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            textColor: Colors.orange,
                            child: Text(
                              "Tentar Novamente",
                              style: TextStyle(fontSize: 38.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
