import 'package:flutter/material.dart';

class Common
{
  static late String email;
  static late String name;

  headingtextWidget(text) {
    return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40,
        color: Color(0xFF3E3E61),
        fontWeight: FontWeight.bold,
      ),
    );
  }
  subheadingtextWidget(text) {
    return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 17,
      ),
    );
  }
  TextStyleWidget()
  {
    return TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF3E3E61),
    );
  }

  btnStyleWidget(){
    return ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        primary: Color(0xFF3E3E61),
        // shadowColor: Colors.brown.withOpacity(1), //0 to 1 values
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        // side: BorderSide(color: Colors.black),
        // elevation: 9.0,
    );
  }
  btntextWidget(text){
    return Text(text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  appBarContainer()
  {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 10),
      child: Icon(Icons.arrow_back,
          color: Color(0xFF3E3E61),
          size: 30),
    );
  }

}