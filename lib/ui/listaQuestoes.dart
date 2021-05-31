import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_quiz/controllers/questao_lista.dart';
import 'package:my_quiz/ui/questoes.dart';

/** Configurações Globais */
import 'package:my_quiz/ui/globalText.dart';

class ListQuestions extends StatefulWidget {
  
  /* Atributos Classe */
  String id_lista;
  String img_local;

  @override
  ListQuestions(this.id_lista, this.img_local);
  @override
  _ListQuestionsState createState() => _ListQuestionsState();
}

class _ListQuestionsState extends State<ListQuestions> {

  /* Atributos Classe */
  List<QuestaoLista> ofc_lista_questionario;
  int ofc_lista_questionario_qtd;
  dynamic fbr_lista_questionario;
  final StreamController _streamController = StreamController<dynamic>();

  pegaListaQuestao() {
    ofc_lista_questionario = new List<QuestaoLista>();
    String id_lista = widget.id_lista;

    this.fbr_lista_questionario.documents.forEach((element) {
      //passa para m array de listas
      QuestaoLista aux_questao_lista = new QuestaoLista();
      aux_questao_lista.setDocumentoId(element.documentID);
      if (element.data['colecao_id'] == id_lista) {
        //
        element.data.forEach((key, value) {
          if (key == "dificuldade") {
            aux_questao_lista.setDificuldade(value);
          } else if (key == "nome_lista") {
            aux_questao_lista.setNomeLista(value);
          } else if (key == "tema") {
            aux_questao_lista.setTema(value);
          }
        });
        ofc_lista_questionario.add(aux_questao_lista);
      } else {
        //questão não tem o id certo
      }
    });
    ofc_lista_questionario_qtd = ofc_lista_questionario.length;
  }

  _listView() {
    return ListView.builder(
      itemCount: ofc_lista_questionario_qtd,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            //TODO aqui chama para a tela de listagem de questoes
            //setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Questions(ofc_lista_questionario[index].id,ofc_lista_questionario[index].dificuldade, ofc_lista_questionario[index].qtd_questoes),
              ),
            );
            print(ofc_lista_questionario[index].qtd_questoes);
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GText.DLText(
                    ofc_lista_questionario[index]
                        .nome_lista, //TODO Dificuldade
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.white10,
                      width: 4.0,
                      style: BorderStyle.solid),
                ),
                child: Image.asset(
                  widget.img_local,
                  fit: BoxFit.cover,
                  width: 900,
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration:
                          ofc_lista_questionario[index].corDificuldade(),
                    ),
                  ),
                  GText.DMText(
                    ofc_lista_questionario[index]
                        .nivelDificuldade(), //TODO Dificuldade
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  gerandoListagem() {
    getLista();
    //TODO: Verificar como funciona o Stream Builder
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: GText.DMText("Erro Ao Acessar"),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return _listView();
      },
    );
  }

  getLista() async {
    //Pega todas as questoes da lista
    QuerySnapshot questoesSnap =
        await Firestore.instance.collection('lista').getDocuments();

    this.fbr_lista_questionario = questoesSnap;
    _streamController.add(fbr_lista_questionario);
    pegaListaQuestao();
  }

  @override
  _ListQuestionState() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.lightBlueAccent),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height *.18,
            child:
              LayoutBuilder(
                builder: (_, constraints){
                  return Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Column(
                      children: <Widget>[
                        cabecalho(constraints.maxWidth,constraints.maxHeight),
                      ]
                    ),
                  );
                }
              ),
            ),
            Container(
              width:  MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .80,
              child: SingleChildScrollView(
                child: Padding(
                padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      gerandoListagem(),
                    ],
                  ),
                ),
              ),
            ),    
          ],
        ),
      ),
    );
  }

  cabecalho(width,height){
    return Stack(
              children: <Widget>[
                Image.asset(
                  "images/flor.png",
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(width * .25, height * .25, width * .25, 0),
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
                ),
              ],
            );
  }

}
