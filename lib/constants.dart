import 'package:flutter/material.dart';

 const kConstantPurpleColor= Color(0xff985F99);

 const kConstantBackgroundColor=Color(0xffE5E5E5);

const kTextFieldDecoration =InputDecoration(
 hintText: 'Enter a value',
 contentPadding:
 EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
 enabledBorder: OutlineInputBorder(
  borderSide: BorderSide(color: kConstantPurpleColor, width: 1.0),
 ),
 focusedBorder: OutlineInputBorder(
  borderSide: BorderSide(color: kConstantPurpleColor, width: 2.0),
 ),
);