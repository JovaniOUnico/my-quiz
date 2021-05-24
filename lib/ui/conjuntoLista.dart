import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_quiz/controllers/grupo_lista.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_quiz/ui/listaQuestoes.dart';

/** Configurações Globais */
import 'package:my_quiz/ui/globalText.dart';

class ConjuntoLista extends StatefulWidget {
  @override
  _ConjuntoListaState createState() => _ConjuntoListaState();
}

class _ConjuntoListaState extends State<ConjuntoLista> {
  final StreamController _streamController = StreamController<dynamic>();
  
  /* Atributos da Classe */
  List<GrupoLista> ofc_lista_conjunto;
  int ofc_lista_conjunto_qtd;
  List<GrupoLista> ofc_aux_lista_conjunto;
  int ofc_aux_lista_conjunto_qtd;
  dynamic fbr_lista_conjunto;

  String textFillter = "";
  TextEditingController _search_controller = new TextEditingController();

  filtraListaConjunto() {
    ofc_aux_lista_conjunto = new List<GrupoLista>();

    this.fbr_lista_conjunto.documents.forEach((element) {
      //passa para m array de listas
      GrupoLista aux_questao_lista = new GrupoLista();
      aux_questao_lista.setDocumentoId(element.documentID);

      bool encontrou = false;
      element.data.forEach((key, value) {
        if (key == "nome") {
          aux_questao_lista.setNome(value);
          if (value.contains(textFillter)) {
            encontrou = true;
          }
        } else if (key == "tags") {
          aux_questao_lista.setTags(value);
          value.forEach((texto) {
            if (texto.contains(textFillter)) {
              encontrou = true;
            }
          });
        }
      });
      if (encontrou) {
        ofc_aux_lista_conjunto.add(aux_questao_lista);
        encontrou = false;
      }
    });
    ofc_aux_lista_conjunto_qtd = ofc_lista_conjunto.length;
  }

  pegaListaConjunto() {

    ofc_lista_conjunto = new List<GrupoLista>();

    this.fbr_lista_conjunto.documents.forEach((element) {
      //passa para m array de listas
      GrupoLista aux_questao_lista = new GrupoLista();
      aux_questao_lista.setDocumentoId(element.documentID);

      //
      element.data.forEach((key, value) {
        if (key == "nome") {
          aux_questao_lista.setNome(value);
        } else if (key == "tags") {
          aux_questao_lista.setTags(value);
        }
      });
      ofc_lista_conjunto.add(aux_questao_lista);
    });
    //TODO Usar length
    ofc_lista_conjunto_qtd = ofc_lista_conjunto.length;
  }

  getConjunto() async {

    //Pega todas as questoes da lista
    QuerySnapshot questoesSnap =
        await Firestore.instance.collection('areas_lista').getDocuments();

    this.fbr_lista_conjunto = questoesSnap;
    _streamController.add(fbr_lista_conjunto);
    pegaListaConjunto();
  }

  gerandoListagem() {

    getConjunto();
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

  _listView() {
    //verifica se o texto não esta vazio se estiver atualiza com pesquisa se não estiver atualiza sem pesquisa
    //
    if (textFillter != null && textFillter.isNotEmpty) {
      // com algo para pesquisar
      filtraListaConjunto();
      return ListView.builder(
        itemCount: ofc_aux_lista_conjunto.length,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String imageLocal;
          if (ofc_aux_lista_conjunto.length > 0) {
            imageLocal = ofc_aux_lista_conjunto[index].getImg();
            return GestureDetector(
              onTap: () {
                //TODO aqui chama para a tela de listagem de questoes
                //setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListQuestions(
                        ofc_aux_lista_conjunto[index].id, imageLocal),
                  ),
                );
                print(ofc_aux_lista_conjunto[index].id);
              },
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      //TODO colocar um quadrado aqui
                      GText.DMText(
                        ofc_aux_lista_conjunto[index].nome, //TODO Dificuldade
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
                      imageLocal,
                      fit: BoxFit.cover,
                      width: 900,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return GText.DText("Nada Enconrado");
          }
        },
      );
    } else {
      // sem nada pra pesquisar
    }

    return ListView.builder(
      itemCount: ofc_lista_conjunto_qtd,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        String imageLocal;
        imageLocal = ofc_lista_conjunto[index].getImg();
        return GestureDetector(
          onTap: () {
            //TODO aqui chama para a tela de listagem de questoes
            //setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ListQuestions(ofc_lista_conjunto[index].id, imageLocal),
              ),
            );
            print(ofc_lista_conjunto[index].id);
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  //TODO colocar um quadrado aqui
                  GText.DMText(ofc_lista_conjunto[index].nome),//TODO Dificuldade
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
                  imageLocal,
                  fit: BoxFit.cover,
                  width: 900,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradienteFundo(),
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
          pesquisaTexto(),
          pesquisaBarra(),
          Expanded(
            child: LayoutBuilder(
            builder: (_, constraints){
              return 
                Container(
                  width: constraints.maxWidth * .9,
                  height: constraints.maxHeight,
                  child: SingleChildScrollView(
                    child: Column(
                    children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              gerandoListagem(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  gradienteFundo(){
    return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.pinkAccent,
          ],
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

  pesquisaTexto(){
    return 
       Center(
         child: GText.DText(
           "Escolha Um Quiz",
         ),
       );
  }

  pesquisaBarra(){
    return Material(
        child: TextField(
         controller: _search_controller,
         onChanged: (text) {
           _streamController.add('search');
           textFillter = text;
         },
         decoration: InputDecoration(
           enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.red),
               borderRadius: BorderRadius.all(Radius.circular(2)),
           ),
           fillColor: Colors.transparent,
           prefixIcon: Icon(Icons.search),
           hintText: "Pesquise pelo assunto de seu Interesse",
         ),
       ),
      );
  }

}
