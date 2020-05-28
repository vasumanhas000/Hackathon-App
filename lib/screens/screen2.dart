import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Expanded(
      flex: 1,
      child: Container(
      child: Text('View Applications',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      ),
    ),
    Expanded(flex: 8,
      child: ListView(
      children: [
      Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(26),
      ),
      ),
      Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(26),
      ),
      ),
      Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(26),
      ),
      ),
      Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(26),
      ),
      ),
      ],
      ),
    ),
      ],
    );
  }
}
