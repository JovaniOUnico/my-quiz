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
      decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
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
                  child: Container(
                    margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
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
                    child: RichText(
                      text: TextSpan(
                        text: "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 43,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: acertosTexto(),
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 90, 30, 30),
                  padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
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
                      child:RichText(
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

  acertosTexto(){
    if(widget.ofc_acertos == widget.ofc_qtd){
      return "Parabéns você acertou todas as questões";
    }else if(widget.ofc_acertos == widget.ofc_erros){
      return "Parabéns você acertou metade das questões";
    }else if(widget.ofc_acertos > widget.ofc_erros){
      return "Parabéns você acertou a maioria das questões";
    }else if(widget.ofc_acertos < widget.ofc_erros){
      return "Que Pena você errou a maioria das questões";
    }else if(widget.ofc_erros == widget.ofc_qtd){
      return "Que pena vocÊ errou todas as questões";
    }
  }
}
