import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'signUp.dart';
import 'dart:ui';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 40),
                      child: Image(
                        image: AssetImage('images/LoginPageImage.png'),
                        fit: BoxFit.contain,
                        height: SizeConfig.safeBlockVertical * 60,
                        width: SizeConfig.safeBlockHorizontal * 80,
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Hack Portal',
                        style: TextStyle(
                            fontFamily: 'Muli',
                            fontSize: 40,
                            fontWeight: FontWeight.w600),
                      ),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: (){},child: Text('Login',style: TextStyle(color: kConstantBlueColor),),color: Colors.white,),
                        RaisedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },child: Text('SignUp',style: TextStyle(color: Colors.white),),color: kConstantBlueColor,),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
