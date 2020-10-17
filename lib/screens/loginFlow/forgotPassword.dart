import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email,message="A link has been sent to the given email";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: (){
        _dismissKeyboard(context);
      },
      child: Scaffold(
        body: Builder(
          builder: (context)=>SafeArea(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'Image',
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 46, 0, 0),
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
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 90, 0),
                  child: Text(
                    """Find teams and projects to 
collaborate during Hackathons""",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: kConstantTextColor, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Email',
                    ),
                    style: kFieldTextStyle,
                    onChanged: (val) {
                      setState(() {
                        email = val;
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
                        minWidth: 100,
                        height: 38,
                        child: FlatButton(
                            onPressed: () async{
                              try{
                               await resetPassword(email.trim());
                              }
                              catch(e){
                                if(e.code=="ERROR_USER_NOT_FOUND"){
                                  message="User with this email doesn't exist.";
                                }
                                else if(e.code=="ERROR_INVALID_EMAIL"){
                                  message="Your email address appears to be malformed.";
                                }
                                else{
                                  message="An undefined error happened";
                                }
                              }
                              final snackBar = SnackBar(
                                content: Text(
                                  message,style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                                ),
                                backgroundColor:kConstantBlueColor ,
                              );
                              await Scaffold.of(context).showSnackBar(snackBar);
                            },
                            child: Text(
                              'Send Link',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 16),
                            ),
                            color: kConstantBlueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
