import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_quiz/controllers/questao.dart';
import 'package:my_quiz/ui/resultados.dart';

/** Configurações Globais */
import 'package:my_quiz/ui/globalText.dart';
class Questions extends StatefulWidget {
  String id_lista;
  int dificuldade;
  int qtd_perguntas = 0;

  @override
  Questions(this.id_lista, this.dificuldade, this.qtd_perguntas){
    //TODO Aqui pega a lista de perguntas e a quantidade
  }

  @override
  _QuestionsState createState() => _QuestionsState(this.qtd_perguntas);
}

class _QuestionsState extends State<Questions> {
  
  /* Atributos classe */
  List<Questao> ofc_lista_questoes;
  Map<int, String> ofc_lista_alternativas;
  int dificuldade;

  int ofc_questao_atual;
  int ofc_qtd_questoes = 0;
  int ofc_acertos      = 0;
  int ofc_erros        = 0;
  double progress      = 0;
  String txt_progress  = "";

  dynamic lista_questoes;
  final _streamController = StreamController<dynamic>();

  void proxima_questao() {

    //Atualiza barra de Progresso
    setState(() {
      //Altera Barra de Progresso
      progress = ofc_questao_atual+1/ofc_qtd_questoes;
    });

    if (ofc_qtd_questoes - 1 == ofc_questao_atual) {
      //chama tela
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Results(this.ofc_acertos, this.ofc_erros,
                this.ofc_qtd_questoes, widget.id_lista, this.dificuldade),
          ),
        );
      });
    } else {
      //atualiza questoes Não do jeito certo, mas funciona
      _streamController.add("next");
    }
  }

  void acertou() {
    ofc_acertos++;
    proxima_questao();
  }

  void errou() {
    ofc_erros++;
    proxima_questao();
  }

  pegaQuestoes() {
    ofc_lista_questoes = new List<Questao>();
    String id_lista = widget.id_lista;

    this.lista_questoes.documents.forEach((element) {
      if (element.data['lista_id'] == id_lista) {
        //
        // passa para um MAP de questões
        Questao aux_questao = new Questao();
        element.data.forEach((key, value) {
          if (key == "correta") {
            aux_questao.setCorretas(value);
          } else if (key == "incorretas") {
            aux_questao.setErradas(value);
          } else if (key == "enunciado") {
            aux_questao.setEnunciado = value;
          }
        });
        ofc_lista_questoes.add(aux_questao);
      } else {
        //questão não tem o id certo
      }
    });
    ofc_qtd_questoes = ofc_lista_questoes.length;
  }

  _listView() {
    if (ofc_lista_questoes == null) {
      pegaQuestoes();
    }

    if (ofc_questao_atual == null) {
      ofc_questao_atual = 0;
    } else {
      ofc_questao_atual++;
    }

    int contador = ofc_questao_atual+1;
    this.txt_progress = contador.toString()+"/"+ofc_qtd_questoes.toString();

    if (ofc_questao_atual != (ofc_qtd_questoes)) {
      ofc_lista_alternativas =
          ofc_lista_questoes[ofc_questao_atual].setListaAlternativas(4);
      int aux_certa = ofc_lista_questoes[ofc_questao_atual].alternativa_certa;

      return 
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: GText.DXLText(ofc_lista_questoes[ofc_questao_atual].enunciado),
            ),
            ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == aux_certa) {
                  String texto = ofc_lista_alternativas[index];
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: FlatButton(
                      color: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      onPressed: () {
                        acertou();
                      },
                      child: GText.DLText('$texto'),
                    ),
                  );
                } else {
                  String texto = ofc_lista_alternativas[index];
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: FlatButton(
                      color: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      onPressed: () {
                        errou();
                      },
                      child: GText.DLText('$texto'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator()); //Colocar Loading
    }
  }

  gerandoBotoes() {
    //TODO: Verificar como funciona o Stream Builder
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: GText.DText("Erro Ao Acessar"),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return _listView();
      },
    );
  }

  getQuestao() async {
    //Pega todas as questoes da lista
    QuerySnapshot questoesSnap =
        await Firestore.instance.collection('questoes').getDocuments();

    this.lista_questoes = questoesSnap;
    _streamController.add(lista_questoes);
  }

  @override
  _QuestionsState(int valor) {
    //metodo construtor
    this.ofc_qtd_questoes = valor;
    this.txt_progress = "0/"+ofc_qtd_questoes.toString();
    getQuestao();
  }

  @override
  Widget build(BuildContext context) {
    this.dificuldade = widget.dificuldade;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: getCorDificuldade()),
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/flor.png",
              fit: BoxFit.cover,
              height: 200,
            ),

              SizedBox(
                width: MediaQuery.of(context).size.width-20,
                child: LinearProgressIndicator(
                  value: progress,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                  backgroundColor: Colors.white,
                ),
              ),
              Center(
                child: GText.DText(txt_progress),
              ),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      gerandoBotoes(),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 160.0),
              child: Image.asset(
                "images/flor.png",
                fit: BoxFit.cover,
                height: 200,
              ),
            )
          ],
        ),
      ),
    );
  }

  getCorDificuldade(){
    if(this.dificuldade == 1){
      return Colors.green[300];
    }else if(this.dificuldade == 2){
      return Colors.red[200];
    }else if(this.dificuldade == 3){
      return Colors.red[300];
    }else{
      return Colors.red[400];
    }
  }
}
