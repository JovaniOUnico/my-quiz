import 'dart:math';

class Questao {
  String enunciado;
  List<dynamic> corretas;
  List<dynamic> erradas;
  Map<int, String> alternativas_escolhidas;
  int alternativa_certa;

  void set setEnunciado(String value) {
    enunciado = value;
  }

  void setCorretas(List<dynamic> value) {
    corretas = new List<dynamic>();
    corretas.addAll(value);
  }

  void setErradas(List<dynamic> value) {
    erradas = new List<dynamic>();
    erradas.addAll(value);
  }

  Map<int, String> setListaAlternativas(int tam) {
    alternativas_escolhidas = new Map<int, String>();
    String correta;

    int max = tam;

    var rng = new Random();
    int num = rng.nextInt(corretas.length);
    correta = corretas[num];

    num = rng.nextInt(tam - 1);
    alternativa_certa = num;

    num = rng.nextInt(max);
    int i = 0;
    while (i < tam) {
      if (i == alternativa_certa) {
        alternativas_escolhidas[i] = correta;
      } else {
        alternativas_escolhidas[i] = erradas[i];
      }
      print(i);
      i++;
    }
    return alternativas_escolhidas;
  }

  //debug functions
  void mostraCorretas() {
    print(this.setListaAlternativas(4));
  }
}
