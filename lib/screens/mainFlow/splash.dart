import 'dart:async';
import 'package:hackapp/screens/loginFlow/loginFormPages/form0.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/loginFlow/loginPage.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getProfile(String token)async{
    Map<String, String> headers = {"authtoken": token};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/users/getuserprofile",
        headers: headers);
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }
  final _auth = FirebaseAuth.instance;
  Future handleAuth()async{
    FirebaseUser user= await _auth.currentUser();
    if(user!=null){
      String Token= await user.getIdToken().then((result) {
        String  token = result.token;
        return token;
      });
      if(user.isEmailVerified){
        if(await getProfile(Token)==404){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Form0()));
        }
        else if(await getProfile(Token)==200){
          Navigator.of(context).pushNamedAndRemoveUntil('/first', (Route<dynamic> route) => false);
        }
      }
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), ()=>handleAuth());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child:
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image(image: AssetImage('images/stc.png'),height: 50,width: 50,),
                    ),
                  ),
                ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: Align(child: Text('Made with ❤ by STC'),alignment: Alignment.bottomCenter,),
            ),
          ),
        ],
      ),
        );
  }
}

