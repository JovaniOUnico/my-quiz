class GrupoLista {
  String nome;
  List<dynamic> tags;
  String id;

  void setDocumentoId(String value) {
    id = value;
  }

  void setTags(List<dynamic> value) {
    tags = new List<dynamic>();
    tags.addAll(value);
  }

  void setNome(String value) {
    nome = value;
  }

  String getImg() {
    if (nome == "Geografia") {
      return "images/img_geografia.jpg";
    } else if (nome == "História") {
      return "images/img_historia.jpg";
    } else if (nome == "Programação") {
      return "images/img_programacao.jpg";
    } else if (nome == "Ingles") {
      return "images/img_ingles.jpg";
    } else {
      return "images/default.jpg";
    }
  }
}
