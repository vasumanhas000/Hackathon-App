import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'screens/flow.dart';
import 'screens/login.dart';
void main() {
  runApp(HackApp());
}

class HackApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
          primaryColor: kConstantBackgroundColor,
          scaffoldBackgroundColor: kConstantBackgroundColor,
          accentColor: kConstantPurpleColor,
          textTheme: TextTheme(
              body1: TextStyle(
                color: kConstantPurpleColor,
              )
          )
      ),
      routes: {
        '/':(context)=>LoginPage(),
        '/first':(context)=>FlowPage(),
      },
    );
  }
}

