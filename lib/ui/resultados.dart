import 'package:flutter/material.dart';
import 'package:my_quiz/ui/questoes.dart';
import 'package:my_quiz/ui/conjuntoLista.dart';

/** Configurações Globais */
import 'package:my_quiz/ui/globalText.dart';

class Results extends StatefulWidget {

  /* Atributos Classe */
  int ofc_acertos;
  int ofc_erros;
  int ofc_qtd;
  int dificuldade;
  String ofc_id_questoes;

  Results(this.ofc_acertos, this.ofc_erros, this.ofc_qtd, this.ofc_id_questoes, this.dificuldade);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Container(

      /* Gradiente do Fundo das Questões */
      decoration: BoxDecoration(
            gradient: gradienteFundo(),
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
                tituloContainer(),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(30, 90, 30, 0),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                  child: acertosContainer(),
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
                      child: Center(
                      child:RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          decorationStyle: TextDecorationStyle.wavy,
                          fontFamily: 'Mont'
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.ofc_acertos.toString() + ' ACERTOS DE ',
                            style: TextStyle(color: Colors.green, fontFamily: 'Mont'),
                          ),
                          TextSpan(
                            text: ' ' + widget.ofc_qtd.toString(),
                            style: TextStyle(color: Colors.purple, fontFamily: 'Mont'),
                          ),
                          TextSpan(
                            text: ' PERGUNTAS ',
                            style: TextStyle(color: Colors.white,fontFamily: 'Mont',),
                          ),
                        ],
                      ),
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
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 38.0, fontFamily: 'Mont'),
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
                                      Questions(widget.ofc_id_questoes,widget.dificuldade,widget.ofc_qtd),
                                ),
                              );
                            },
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            textColor: Colors.orange,
                            child: Text(
                              "Tentar Novamente",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 38.0,fontFamily: 'Mont'),
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

  acertosContainer(){
    return Container(
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
              style: TextStyle(color: Colors.green, fontFamily: 'Mont'),
            ),
          ],
        ),
      ),
    );
  }

  tituloContainer() {
    return Container(
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
      child: GText.ProjetoTitulo(),
    );
  }

  gradienteFundo() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.blue,
        Colors.red,
      ],
    );
  }

}
