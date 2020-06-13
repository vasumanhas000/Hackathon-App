import 'package:flutter/material.dart';

class BoilerPage extends StatefulWidget {
  @override
  _BoilerPageState createState() => _BoilerPageState();
}

class _BoilerPageState extends State<BoilerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/first');
                },
                child: Text('Go to main flow.'),
              ),
            ),
          ),
          Container(
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Go to login flow.'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
