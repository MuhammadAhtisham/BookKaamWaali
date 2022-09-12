import 'package:flutter/material.dart';

///visible/invisible password
bool _isObscure = false;
bool isChecked = true;
InputDecoration buildInputDecoration(IconData icons,String hinttext) {
  return InputDecoration(
    fillColor: Colors.black12, filled: true,
    hintText: hinttext,
    prefixIcon: Icon(icons,
    color: Color(0xFF3E3E61),),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
          color: Color(0xFF3E3E61),
          width: 1.5
      ),
    ),
    enabledBorder:OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
         color: Colors.black12,
        width: 0,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 16, horizontal: 18),

  );

}

