import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackapp/screens/loginFlow/loginFormPages/form1.dart';

class Form0 extends StatefulWidget {
  final String text;
  Form0({this.text});
  @override
  _Form0State createState() => _Form0State(this.text);
}

class _Form0State extends State<Form0> {
  String text1;
  _Form0State(this.text1);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder:(BuildContext context, int index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'Heading',
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 30),
                    child: Container(
                      child: Text(
                        'Complete your profile',
                        style: TextStyle(fontFamily: 'Muli', fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
              Hero(
                tag: 'Icons',
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/1unfilled.png'),
                        height: 45,
                      ),
                      Image(
                        image: AssetImage('images/blueLine.png'),
                        color: Colors.white,
                      ),
                      Image(
                        image: AssetImage('images/2unfilled.png'),
                        height: 45,
                      ),
                      Image(
                        image: AssetImage('images/blueLine.png'),
                        color: Colors.white,
                      ),
                      Image(
                        image: AssetImage('images/3unfilled.png'),
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 30),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Personal',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Name:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  decoration: kTextFieldDecoration,
                  onChanged: (text) {
                    print(text);
                    text1 = text;
                    print(text1);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Contact Number:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'University Name:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Year Studying In:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  decoration: kTextFieldDecoration,
                ),
              ),
              Hero(
                tag: 'BottomIcon',
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.arrowCircleRight,
                              color: kConstantBlueColor,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Form1()));
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ]
          );
          }
        ),
      ),
    );
  }
}
