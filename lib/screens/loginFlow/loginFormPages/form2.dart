import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
class Form2 extends StatefulWidget {
  final String name,college,year,bio;
  final List skillList;
  Form2({this.year,this.college,this.name,this.bio,this.skillList});
  @override
  _Form2State createState() => _Form2State(this.year,this.college,this.name,this.bio,this.skillList);
}
class _Form2State extends State<Form2> {
  final auth = FirebaseAuth.instance;
 Future postForm(String bio,String name,String year,String college,String github,String stack,String website,List skillList)async{
   FirebaseUser user = await auth.currentUser();
   String Token= await user.getIdToken().then((result) {
     token = result.token;
     return token;
   });
   Map<String, String> headers = {
     "Content-Type": "application/json",
     "authtoken": Token,
   };
   String url = 'https://hackportal.herokuapp.com/users/setprofile';
   var response = await http.post(url,
       headers: headers,
       body: jsonEncode({
         "name":name,
         "college":college,
         "expectedGraduation":year,
         "bio":bio,
         "skills":skillList,
         "githubLink":github,
         "stackOverflowLink":stack,
         "externalLink":website,
       }));
   return response.statusCode;
 }

  _Form2State(this.year,this.college,this.name,this.bio,this.skillList);
  String bio,name,year,college,github='',stack='',website='',token;
  List skillList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: 'Heading',
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 30),
                      child: Container(
                        child: Text(
                          'Complete your profile',
                          style: TextStyle(fontFamily: 'Muli', fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: 'Icons',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('images/1filled.png'),
                          height: 45,
                        ),
                        Image(
                          image: AssetImage('images/blueLine.png'),
                        ),
                        Image(
                          image: AssetImage('images/2filled.png'),
                          height: 45,
                        ),
                        Image(
                          image: AssetImage('images/blueLine.png'),
                        ),
                        Image(
                          image: AssetImage('images/3unfilled.png'),
                          height: 45,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'Personal',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 30),
                  child: Text(
                    '(you can skip this section)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Github:',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    onChanged: (val){
                      setState(() {
                        github=val;
                      });
                    },
                    decoration: kTextFieldDecoration,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Stack Overflow:',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    onChanged: (val){
                      setState(() {
                        stack=val;
                      });
                    },
                    decoration: kTextFieldDecoration,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Your Website:',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    onChanged: (val){
                      setState(() {
                        website=val;
                      });
                    },
                    decoration: kTextFieldDecoration,
                  ),
                ),
                Hero(
                  tag: 'BottomIcon',
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: ()async{
                             if(await postForm(bio, name, year, college, github, stack, website, skillList)==200){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>FlowPage()));
                             };
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: kConstantBlueColor,
                              ),
                              child: Icon(Icons.check,color: Colors.white,size: 30,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
