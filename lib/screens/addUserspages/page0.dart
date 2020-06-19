import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
class Page0 extends StatefulWidget {
  @override
  _Page0State createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 27),
                child: Container(
                  child: Text('Create your team', style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w600),),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(29, 10, 0, 0),
                child: Text(
                  'Team name:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(29, 10, 0, 0),
                child: Text(
                  'Hackathon name:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(29, 10, 0, 0),
                child: Text(
                  'Hackathon link:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(29, 10, 0, 0),
                child: Text(
                  'Team size:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(29, 10, 0, 0),
                child: Text(
                  'Project Description:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  maxLines: 6,
                  decoration: kTextFieldDecoration,
                ),
              ),
            ],
          ),
        );
  }
}
