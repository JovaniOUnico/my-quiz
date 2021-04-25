import 'package:flutter/material.dart';
import 'package:my_quiz/ui/listaQuestoes.dart';
import 'package:my_quiz/ui/conjuntoLista.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_quiz/ui/questoes.dart';

void main() async {
  runApp(MyApp());

/*   DocumentSnapshot snapshot = await Firestore.instance
      .collection('lista')
      .document('zN2RcJCj9mZoZl1AIyha')
      .get();
  print(snapshot.data);

  QuerySnapshot questoesSnap =
      await Firestore.instance.collection('questoes').getDocuments();
  questoesSnap.documents.forEach((element) {
    if (element.data['lista_id'] == 'zN2RcJCj9mZoZl1AIyha') {
      print(element.data);
    } else {
      print("oque?");
    }
  }); */

/*   QuerySnapshot snapshot =
      await Firestore.instance.collection('areas_lista').getDocuments();
  snapshot.documents.forEach((element) {
    print(element.data['nome']);
  });

  QuerySnapshot snapshot2 =
      await Firestore.instance.collection('lista').getDocuments();
  snapshot2.documents.forEach((element) {
    print(element.data);
  });

  QuerySnapshot snapshot3 =
      await Firestore.instance.collection('questoes').getDocuments();
  snapshot3.documents.forEach((element) {
    print(element.data);
  }); */

  /* DocumentSnapshot snapshot = await Firestore.instance
      .collection('lista_questoes')
      .document('aprender_ingles')
      .get();
  print(snapshot.data); */
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ConjuntoLista(),
      debugShowCheckedModeBanner: false,
    );
  }
}
