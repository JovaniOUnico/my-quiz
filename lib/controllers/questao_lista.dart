import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class QuestaoLista {
  int dificuldade;
  String nome_lista;
  String tema;
  String id;

  void setDificuldade(int value) {
    dificuldade = value;
  }

  void setNomeLista(String value) {
    nome_lista = value;
  }

  void setTema(String value) {
    tema = value;
  }

  void setDocumentoId(String value) {
    id = value;
  }

  String nivelDificuldade() {
    if (dificuldade == 1) {
      return "Fácil";
    } else if (dificuldade == 2) {
      return "Médio";
    } else if (dificuldade == 3) {
      return "Dificil";
    }
  }

  BoxDecoration corDificuldade() {
    if (dificuldade == 1) {
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.green,
            Colors.greenAccent,
          ],
        ),
      );
    } else if (dificuldade == 2) {
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.orange,
            Colors.yellow,
          ],
        ),
      );
    } else if (dificuldade == 3) {
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.red,
            Colors.pinkAccent,
          ],
        ),
      );
    }
  }
}
