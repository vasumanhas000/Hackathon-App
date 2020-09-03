import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kConstantBlueColor = Color(0xff3D5A80);

const kConstantBackgroundColor = Color(0xffE5E5E5);

const kConstantTextColor = Color(0xff293241);

const kTextFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 00.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
    color: kConstantBlueColor,
    width: 0.5,
  )),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kConstantBlueColor, width: 0.5)),
);

const kFieldTextStyle = TextStyle(
  color: Color(0xff293241),
  fontSize: 18,
  fontFamily: 'Montserrat-Medium',
);

const kHeadingTextStyle = TextStyle(
  color: Color(0xff9499A0),
  fontWeight: FontWeight.w600,
  fontFamily: 'Montserrat',
  fontSize: 14,
);

const kBigTextFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kConstantBlueColor, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kConstantBlueColor, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);

const kBaseUrl='https://hackportal.herokuapp.com';