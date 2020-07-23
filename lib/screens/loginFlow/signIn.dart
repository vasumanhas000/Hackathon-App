import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/loginFlow/loginFormPages/form0.dart';
import 'package:hackapp/screens/loginFlow/signUp.dart';
import 'package:http/http.dart' as http;
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String errorMessage;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _auth = FirebaseAuth.instance;
  Future signIn(String email, String password) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if(user!=null) {
      FirebaseUser user1 = await _auth.currentUser();
      return user1;
    }
  }
  Future getProfile(String token)async{
    Map<String, String> headers = {"authtoken": token};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/users/getuserprofile",
        headers: headers);
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  String email='',password='';
 bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.5,
        progressIndicator: SpinKitFoldingCube(
          color: kConstantBlueColor,
        ),
        color: kConstantBlueColor,
      child: GestureDetector(
        onTap: (){
          _dismissKeyboard(context);
        },
        child: Scaffold(
          body: SafeArea(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index)=>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'Image',
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10,25,0,0),
                            child: Image(
                              image: AssetImage('images/LoginPageImage.png'),
                              fit: BoxFit.fill,
                              height: SizeConfig.safeBlockVertical * 50,
                              width: SizeConfig.safeBlockHorizontal * 95,
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
                      Hero(
                        tag: 'Text2',
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 90, 0),
                            child: Text(
                              'Find teams and projects to collaborate during Hackathons',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: kConstantTextColor, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,20,20,0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Email',),
                          onChanged: (val){
                            setState(() {
                              email=val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,20,20,0),
                        child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
                          onChanged: (val){
                            setState(() {
                              password=val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24,24,24,8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(child: Text("Don't have an account ?"),onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));},),
                            RaisedButton(onPressed: ()async{
                              if(email==''||password==''){
                                final snackBar = SnackBar(
                                  content: Text(
                                    'All fields are mandatory.',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                                  ),
                                  backgroundColor:kConstantBlueColor ,
                                );
                                await Scaffold.of(context).showSnackBar(snackBar);
                              }
                              else{
                              setState(() {
                                _isInAsyncCall=true;
                              });
                             try{
                            FirebaseUser user= await signIn(email, password);
                            String Token= await user.getIdToken().then((result) {
                            String  token = result.token;
                              return token;
                            });
                            if(user.isEmailVerified){
                              if(await getProfile(Token)==404){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Form0()));
                                setState(() {
                                  _isInAsyncCall=false;
                                });
                              }
                              else if(await getProfile(Token)==200){
                                setState(() {
                                  _isInAsyncCall=false;
                                });
                                Navigator.of(context).pushNamedAndRemoveUntil('/first', (Route<dynamic> route) => false);
                              }
                            }
                            else{
                              setState(() {
                                _isInAsyncCall=false;
                              });
                              print(false);
                            }}catch(e){
                               switch (e.code) {
                                 case "ERROR_INVALID_EMAIL":
                                   errorMessage = "Your email address appears to be malformed.";
                                   break;
                                 case "ERROR_WRONG_PASSWORD":
                                   errorMessage = "Your password is wrong.";
                                   break;
                                 case "ERROR_USER_NOT_FOUND":
                                   errorMessage = "User with this email doesn't exist.";
                                   break;
                                 case "ERROR_USER_DISABLED":
                                   errorMessage = "User with this email has been disabled.";
                                   break;
                                 case "ERROR_TOO_MANY_REQUESTS":
                                   errorMessage = "Too many requests. Try again later.";
                                   break;
                                 case "ERROR_OPERATION_NOT_ALLOWED":
                                   errorMessage = "Signing in with Email and Password is not enabled.";
                                   break;
                                 default:
                                   errorMessage = "An undefined Error happened.";
                               }
                               setState(() {
                                 _isInAsyncCall=false;
                               });
                               final snackBar = SnackBar(
                                 content: Text(
                                   errorMessage,style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                                 ),
                                 backgroundColor:kConstantBlueColor ,
                               );
                               await Scaffold.of(context).showSnackBar(snackBar);
                             }}
                            },child: Text('Login',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),),color: kConstantBlueColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
