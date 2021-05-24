import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GText{
  
  static ProjetoTitulo(){
    return RichText(
      text: TextSpan(
        text: "",
        style: TextStyle(
          color: Colors.black,
          //fontSize: height * .2,
          decorationStyle: TextDecorationStyle.wavy,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'MEGA',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontFamily: 'Mont'  
            ),
          ),
          TextSpan(
            text: ' QUIZ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple[400],
                fontFamily: 'Mont'
            ),
          ),
        ],
      ),
    );
  }

  static DSText(){
    //Small
  }

  static DMText(String text){
    //Medium
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        decoration: TextDecoration.none
      )
    );
  }

  static DLText(String text){
    //Large
    return Text(text, 
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.white, 
          fontSize: 28.0,
          fontFamily: 'Mont'
        ),
    );
  }

  static DXLText(String text){
    //Large
    return Text(text, 
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.white, 
          fontSize: 38.0,
          fontFamily: 'Mont'
        ),
    );
  }

  static DText(String text){
    return Text(
      text,
      style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontFamily: 'Mont' 
             ),
    );
  }


}