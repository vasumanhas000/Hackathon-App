import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'screens/loginFlow/loginPage.dart';
import 'screens/mainFlow/flow.dart';
import 'screens/mainFlow/splash.dart';
import 'screens/loginFlow/loginFormPages/form0.dart';

void main() {
  runApp(HackApp());
}
class HackApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        '/':(context)=>SplashScreen(),
        '/first':(context)=>FlowPage(currentIndex: 0,),
        '/third':(context)=>FlowPage(currentIndex: 2,),
        '/login':(context)=>LoginPage(),
        '/form':(context)=>Form0(),
      },
    );
  }
}

