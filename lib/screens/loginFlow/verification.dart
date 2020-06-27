import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackapp/screens/loginFlow/loginFormPages/form0.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  Timer _timer;
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
        await FirebaseAuth.instance.currentUser()..reload();
        var user = await FirebaseAuth.instance.currentUser();
        if (user.isEmailVerified) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Form0()));
          timer.cancel();
        }
      });
    });
  }
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Container(
          child: Text('Please verify your email to proceed further' ),
        )),
      ),
    );
  }
}
