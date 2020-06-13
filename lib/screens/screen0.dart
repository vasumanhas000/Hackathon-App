import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';

class Screen0 extends StatefulWidget {
  @override
  _Screen0State createState() => _Screen0State();
}

class _Screen0State extends State<Screen0> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            'Create a Team',
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10 , 10),
          child: TextField(
            decoration: kTextFieldDecoration,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10 , 10),
          child: TextField(
            decoration: kTextFieldDecoration,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10 , 10),
          child: TextField(
            decoration: kTextFieldDecoration,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10 , 10),
          child: TextField(
            decoration: kTextFieldDecoration,
          ),
        ),
        Container(
          width: 95,
          height: 35,
          margin: EdgeInsets.only(left: 250),
          child: Center(child: Text('Finish',style: TextStyle(color: Colors.white,fontSize: 18),)),
          decoration: BoxDecoration(
            color: kConstantBlueColor,
          ),
        ),
      ],
    );
  }
}
