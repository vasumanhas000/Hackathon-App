import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'screens/loginFlow/LoginForm.dart';
import 'screens/loginFlow/loginPage.dart';
import 'screens/mainFlow/flow.dart';
import 'screens/boiler.dart';
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
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          accentColor: kConstantBlueColor,
          textTheme: TextTheme(
              body1: TextStyle(
                fontFamily: 'Montserrat',
                color: kConstantBlueColor,
              )
          )
      ),
      routes: {
        '/':(context)=>BoilerPage(),
        '/first':(context)=>FlowPage(),
        '/login':(context)=>LoginPage(),
        '/form':(context)=>LoginForm(),
      },
    );
  }
}

