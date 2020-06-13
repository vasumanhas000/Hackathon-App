import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(18, 52, 0, 0),
                  height: 116,
                  width: 116,
                  decoration: BoxDecoration(
                    color: Color(0xff98C1D9),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(301, 361, 0, 0),
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Color(0xffEE6C4D),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(66, 120, 0, 0),
                  height: 272,
                  width: 270,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('images/Login-Image.png'),
                    fit: BoxFit.cover,
                  )),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 150, 0),
              child: Text(
                'Hack Portal',
                style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 40,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 30, 90, 0),
              child: Text(
                'Find teams and projects to collaborate during Hackathons',
                textAlign: TextAlign.left,
                style: TextStyle(color: kConstantTextColor, fontSize: 20),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/form');
              },
              child: Container(
                child: Text('Login'),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
