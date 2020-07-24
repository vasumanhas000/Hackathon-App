import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/screens/loginFlow/signIn.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 14,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'Image',
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20,46,0,0),
                              child: Image(
                                image: AssetImage('images/LoginPageImage.png'),
                                fit: BoxFit.fill,
                                height: SizeConfig.safeBlockVertical * 45,
                                width: SizeConfig.safeBlockHorizontal * 90,
                              ),
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'Text1',
                          child: Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
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
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: Text(
                            """Find teams and projects to 
collaborate during Hackathons""",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: kConstantTextColor, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 54),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonTheme(
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: kConstantBlueColor,
                                        fontFamily: 'Montserrat',fontWeight: FontWeight.w500,fontSize: 16),
                                  ),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: BorderSide(color: kConstantBlueColor,width: 2)),
                                ),
                                minWidth: 100,
                              ),
                              ButtonTheme(
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontFamily: 'Montserrat',fontSize: 16),
                                  ),
                                  color: kConstantBlueColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                minWidth: 100,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Expanded(child: Align(child: Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: Text('Made with ❤ by STC'),
            ),alignment: Alignment.bottomCenter,))
          ],
        ),
      ),
    );
  }
}
