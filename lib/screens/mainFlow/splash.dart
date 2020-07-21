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
  final _auth = FirebaseAuth.instance;
  Future handleAuth()async{
    FirebaseUser user= await _auth.currentUser();
    if(user!=null){
      Navigator.push(context, MaterialPageRoute(builder:(context)=> FlowPage(currentIndex: 0,)));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleAuth();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: kConstantBlueColor,
        ),
      ),
    );
  }
}

