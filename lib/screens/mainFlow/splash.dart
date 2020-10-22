import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/loginFlow/loginPage.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'package:http/http.dart' as http;

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
      Token = await user.getIdToken(refresh: true).then((result) {
        String token = result.token;
        print(token);
        return token;
      });
      if (await getProfile(Token) == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FlowPage(
                      currentIndex: 0,
                    )));
<<<<<<< HEAD
      } else {
        _auth.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
=======
      } else {_auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));}
     
>>>>>>> bea407c53207dad5f285918fe20b1d685bba5e8f
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  Future getProfile(String token) async {
    Map<String, String> headers = {"authtoken": token};
    var response = await http.get("$kBaseUrl/users", headers: headers);
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () => handleAuth());
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 150),
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
                    Center(
                        child: Text(
                      'Hack Portal',
                      style: TextStyle(
                          fontFamily: 'Muli',
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    )),
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
