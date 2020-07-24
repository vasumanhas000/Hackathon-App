import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'verification.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorMessage;
  Future signUp(String email, String password) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    if(user!=null) {
      FirebaseUser user1 = await _auth.currentUser();
      try {
        await user1.sendEmailVerification();
        return user1.uid;
      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
      }
    }
  }

  final _auth = FirebaseAuth.instance;
  String email='',password='';
 bool _isInAsyncCall=false;
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
                  child:Material(
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
                  margin: EdgeInsets.fromLTRB(20, 20, 90, 0),
                  child: Text(
                    """Find teams and projects to 
collaborate during Hackathons""",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kConstantTextColor, fontSize: 18),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonTheme(
                        child: FlatButton(onPressed: ()async{
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
                            await signUp( email, password);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification()));}catch(e){
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
                              case "ERROR_WEAK_PASSWORD" :
                                errorMessage='Password must be at least 6 characters.';
                                break;
                              case "ERROR_TOO_MANY_REQUESTS":
                                errorMessage = "Too many requests. Try again later.";
                                break;
                              case "ERROR_EMAIL_ALREADY_IN_USE":
                                errorMessage="An account is already present with the given email.";
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
                        },child: Text('Sign up',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontSize: 16),),color: kConstantBlueColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),),minWidth: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
