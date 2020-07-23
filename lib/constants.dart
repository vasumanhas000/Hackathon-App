import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 const kConstantBlueColor= Color(0xff3D5A80);

 const kConstantBackgroundColor=Color(0xffE5E5E5);

 const kConstantTextColor=Color(0xff293241);

const kTextFieldDecoration =InputDecoration(
 fillColor: Color.fromRGBO(41, 50, 65, 0.1),
 filled: true,
 contentPadding:
 EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
 border: OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(2.0)),
 ),
 enabledBorder: OutlineInputBorder(
  borderSide: BorderSide(color: Color.fromRGBO(41, 50, 65, 0.1),width: 0),
  borderRadius: BorderRadius.all(Radius.circular(2.0)),
 ),
 focusedBorder: OutlineInputBorder(
  borderSide: BorderSide(color: Color.fromRGBO(41, 50, 65, 0.1),width: 0),
  borderRadius: BorderRadius.all(Radius.circular(2.0)),
 ),
);


