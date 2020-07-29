import 'dart:async';
import 'package:hackapp/screens/loginFlow/loginFormPages/form0.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/loginFlow/loginPage.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  final _auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  String Token;
  Future handleAuth() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Token= await user.getIdToken().then((result) {
        String token = result.token;
        print(token);
        return token;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FlowPage(currentIndex: 0,)));
      }
    else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), ()=>handleAuth());
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 35,
    );

    controller.addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,10,150),
                        child: Container(
                          child: Image(
                            image: AssetImage('images/applogo.png'),
                            height: 100,
                            width: 100,
                          ),
                          margin: EdgeInsets.only(top: controller.value),
                        ),
                      ),
                    ),
                    Center(child: Text('Hack Portal',style: TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.w600,fontSize: 30),)),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Align(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Made with ❤ by STC'),
              ),
              alignment: Alignment.bottomCenter,
            ))
          ],
        ),
      ),
    );
  }
}
