import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'form2.dart';
class Form1 extends StatefulWidget {
  @override
  _Form1State createState() => _Form1State();
}
class _Form1State extends State<Form1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                          image: AssetImage('images/1filled.png'),
                          height: 45,
                        ),
                        Image(
                          image: AssetImage('images/blueLine.png'),
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
                      'Skills',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 13, 0, 0),
                  child: Text(
                    'Brief description about yourself:',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    maxLines: 6,
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
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Form2()));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: kConstantBlueColor,
                              ),
                              child: Icon(Icons.arrow_forward,color: Colors.white,size: 28,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
