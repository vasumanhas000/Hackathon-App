import 'package:flutter/material.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'verification.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
  String email,password;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index)=>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 40),
                  child: Image(
                    image: AssetImage('images/LoginPageImage.png'),
                    fit: BoxFit.contain,
                    height: SizeConfig.safeBlockVertical * 60,
                    width: SizeConfig.safeBlockHorizontal * 80,
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
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
                padding: const EdgeInsets.fromLTRB(0,30,15,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: RaisedButton(onPressed: (){
                        Navigator.pop(context);
                      },child: Text('Cancel',style: TextStyle(color: kConstantBlueColor),),color: Colors.white,),
                    ),
                    RaisedButton(onPressed: ()async{
                      await signUp( email, password);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification()));
                    },child: Text('SignUp',style: TextStyle(color: Colors.white),),color: kConstantBlueColor,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
