import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditUser extends StatefulWidget {
  final User user;
  EditUser({@required this.user});
  @override
  _EditUserState createState() => _EditUserState(this.user);
}

class _EditUserState extends State<EditUser> {
  final _auth = FirebaseAuth.instance;
  String Token;
  Future updateProfile(String name,String university,String bio,String year,String github,String stack,String link,List skillList)async{
    FirebaseUser user = await _auth.currentUser();
    Token= await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {"authtoken": Token,"Content-Type": "application/json"};
    var response = await http.patch(
        "https://hackportal.azurewebsites.net/users",
        headers: headers,body: jsonEncode({
      "name":name,
      "college":university,
      "expectedGraduation":year,
      "bio":bio,
      "skills":skillList,
      "githubLink":github,
      "stackOverflowLink":stack,
      "externalLink":link
    }));
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

  _EditUserState(this.user);
  User user;
  int selectWeb,
      selectMobile,
      selectDevOps,
      selectML,
      selectAI,
      selectDesign,
      selectManagement,
      selectBlock,
      selectCyber;
  List skillList=[];
  var toRemove = [];
  bool _isInAsyncCall = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List userSkills=user.skills;
    print(userSkills);
    for(var i in userSkills){
      if(i.toString().toLowerCase()=='Web Development'.toLowerCase()){
        selectWeb=1;
      }
      if(i.toString().toLowerCase()=='App Development'.toLowerCase()){
        selectMobile=1;
      }
      if(i.toString().toLowerCase()=='DevOps'.toLowerCase()){
        selectDevOps=1;
      }
      if(i.toString().toLowerCase()=='Machine Learning'.toLowerCase()){
        selectML=1;
      }
      if(i.toString().toLowerCase()=='Artificial Intelligence'.toLowerCase()){
        selectAI=1;
      }
      if(i.toString().toLowerCase()=='Design'.toLowerCase()){
        selectDesign=1;
      }
      if(i.toString().toLowerCase()=='Management'.toLowerCase()){
        selectManagement=1;
      }
      if(i.toString().toLowerCase()=='BlockChain'.toLowerCase()){
        selectBlock=1;
      }
      if(i.toString().toLowerCase()=='CyberSecurity'.toLowerCase()){
        selectCyber=1;
      }
    }
     name = TextEditingController(text: user.name);
     university = TextEditingController(text: user.college);
     bio = TextEditingController(text: user.bio);
     year = TextEditingController(text: user.year);
     github = TextEditingController(text: user.github);
     stack = TextEditingController(text: user.stack);
     link = TextEditingController(text: user.link);
  }
  TextEditingController name,university,bio,year,github,stack,link;
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    university.dispose();
    bio.dispose();
    year.dispose();
    github.dispose();
    stack.dispose();
    link.dispose();
  }
  void _moveToSignInScreen(BuildContext context) =>
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FlowPage(currentIndex:3,)));
  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: user.name);
    final university = TextEditingController(text: user.college);
    final bio = TextEditingController(text: user.bio);
    final year = TextEditingController(text: user.year);
    final github = TextEditingController(text: user.github);
    final stack = TextEditingController(text: user.stack);
    final link = TextEditingController(text: user.link);
    return GestureDetector(
      onTap: (){
        _dismissKeyboard(context);
      },
      child: WillPopScope(
        onWillPop: (){
          _moveToSignInScreen(context);
        },
        child: Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: _isInAsyncCall,
            opacity: 0.5,
            progressIndicator: SpinKitFoldingCube(
              color: kConstantBlueColor,
            ),
            child: SafeArea(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Text(
                        'Name:',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                        controller: name,
                        decoration: kTextFieldDecoration,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'University Name:',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                        controller: university,
                        decoration: kTextFieldDecoration,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Year of graduation:',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                        controller: year,
                        decoration: kTextFieldDecoration,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Description:',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                        maxLines: 6,
                        controller: bio,
                        decoration: kTextFieldDecoration,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Skills:',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectWeb!=1){
                              selectWeb=1;}
                            else{
                              selectWeb=0;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectWeb==1?kConstantBlueColor:Color(0xffD8D8D8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Text('Web Development',style: TextStyle(fontSize: 18),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectMobile!=1){
                              selectMobile=1;}
                            else{
                              selectMobile=0;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectMobile==1?kConstantBlueColor:Color(0xffD8D8D8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Text('Mobile App Development',style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectDevOps!=1){
                              selectDevOps=1;}
                            else{
                              selectDevOps=0;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectDevOps==1?kConstantBlueColor:Color(0xffD8D8D8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Text('Devops',style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectML!=1){
                              selectML=1;}
                            else{
                              selectML=0;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectML==1?kConstantBlueColor:Color(0xffD8D8D8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Text('Machine Learning',style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectAI!=1){
                              selectAI=1;}
                            else{
                              selectAI=0;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectAI==1?kConstantBlueColor:Color(0xffD8D8D8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Text('Artificial Intelligence',style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectDesign!=1){
                              selectDesign=1;}
                            else{
                              selectDesign=0;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectDesign==1?kConstantBlueColor:Color(0xffD8D8D8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Text('Design - UI/UX',style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectManagement!=1){
                              selectManagement=1;}
                            else{
                              selectManagement=0;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectManagement==1?kConstantBlueColor:Color(0xffD8D8D8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Text('Management skills',style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectBlock!=1){
                              selectBlock=1;}
                            else{
                              selectBlock=0;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectBlock==1?kConstantBlueColor:Color(0xffD8D8D8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Text('Blockchain',style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectCyber!=1){
                              selectCyber=1;}
                            else{
                              selectCyber=0;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectCyber==1?kConstantBlueColor:Color(0xffD8D8D8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                child: Text('CyberSecurity',style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        'Github:',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                        controller: github,
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
                        style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                        controller: stack,
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
                      child: TextField(style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                        controller: link,
                        decoration: kTextFieldDecoration,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,24,24,8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: ButtonTheme(
                              child: FlatButton(onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FlowPage(currentIndex:3,)));
                              },child: Text('Cancel',style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 16),),color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color: kConstantBlueColor,width: 2)),),
                        height: 38,minWidth: 100,    ),
                          ),
                          ButtonTheme(
                            child: FlatButton(onPressed: ()async{
                              if(selectWeb==1){
                                var count=0;
                                for(var i in skillList){
                                  if(i=='Web Development'){
                                    count+=1;
                                  }
                                }
                                if(count==0){
                                  skillList.add('Web Development');
                                }
                              }
                              if(selectMobile==1){
                                var count=0;
                                for(var i in skillList){
                                  if(i=='App Development'){
                                    count+=1;
                                  }
                                }
                                if(count==0){
                                  skillList.add('App Development');
                                }
                              }
                              if(selectDevOps==1){
                                var count=0;
                                for(var i in skillList){
                                  if(i=='DevOps'){
                                    count+=1;
                                  }
                                }
                                if(count==0){
                                  skillList.add('DevOps');
                                }
                              }
                              if(selectML==1){
                                var count=0;
                                for(var i in skillList){
                                  if(i=='Machine Learning'){
                                    count+=1;
                                  }
                                }
                                if(count==0){
                                  skillList.add('Machine Learning');
                                }
                              }
                              if(selectAI==1){
                                var count=0;
                                for(var i in skillList){
                                  if(i=='Artificial Intelligence'){
                                    count+=1;
                                  }
                                }
                                if(count==0){
                                  skillList.add('Artificial Intelligence');
                                }
                              }
                              if(selectDesign==1){
                                var count=0;
                                for(var i in skillList){
                                  if(i=='Design'){
                                    count+=1;
                                  }
                                }
                                if(count==0){
                                  skillList.add('Design');
                                }

                              }
                              if(selectManagement==1){
                                var count=0;
                                for(var i in skillList){
                                  if(i=='Management'){
                                    count+=1;
                                  }
                                }
                                if(count==0){
                                  skillList.add('Management');
                                }
                              }
                              if(selectBlock==1){
                                var count=0;
                                for(var i in skillList){
                                  if(i=='BlockChain'){
                                    count+=1;
                                  }
                                }
                                if(count==0){
                                  skillList.add('BlockChain');
                                }
                              }
                              if(selectCyber==1){
                                var count=0;
                                for(var i in skillList){
                                  if(i=='CyberSecurity'){
                                    count+=1;
                                  }
                                }
                                if(count==0){
                                  skillList.add('CyberSecurity');
                                }
                              }
                              if(selectWeb!=1){
                                for(var i in skillList){
                                  if(i=='Web Development'){
                                    toRemove.add(i);
                                  }
                                }
                              }
                              if(selectMobile!=1){
                                for(var i in skillList){
                                  if(i=='App Development'){
                                    toRemove.add(i);
                                  }
                                }
                              }
                              if(selectDevOps!=1){
                                for(var i in skillList){
                                  if(i=='DevOps'){
                                    toRemove.add(i);
                                  }
                                }
                              }
                              if(selectML!=1){
                                for(var i in skillList){
                                  if(i=='Machine Learning'){
                                    toRemove.add(i);
                                  }
                                }
                              }
                              if(selectAI!=1){
                                for(var i in skillList){
                                  if(i=='Artificial Intelligence'){
                                    toRemove.add(i);
                                  }
                                }
                              }
                              if(selectDesign!=1){
                                for(var i in skillList){
                                  if(i=='Design'){
                                    toRemove.add(i);
                                  }
                                }
                              }
                              if(selectManagement!=1){
                                for(var i in skillList){
                                  if(i=='Management'){
                                    toRemove.add(i);
                                  }
                                }
                              }
                              if(selectBlock!=1){
                                for(var i in skillList){
                                  if(i=='BlockChain'){
                                    toRemove.add(i);
                                  }
                                }
                              }
                              if(selectCyber!=1){
                                for(var i in skillList){
                                  if(i=='CyberSecurity'){
                                    toRemove.add(i);
                                  }
                                }
                              }
                              skillList.removeWhere( (e) => toRemove.contains(e));
                              setState(() {
                                _isInAsyncCall=true;
                              });
                              if(await updateProfile(name.text, university.text, bio.text, year.text, github.text, stack.text, link.text, skillList)==200){
                                setState(() {
                                  _isInAsyncCall=false;
                                });
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FlowPage(currentIndex:3,)));
                              }else{
                                setState(() {
                                  _isInAsyncCall=false;
                                });
                                final snackBar = SnackBar(
                                  backgroundColor: kConstantBlueColor,
                                  content: Text(
                                    'Error.Please try again later',style: TextStyle(color: Colors.white),
                                  ),
                                  action:
                                  SnackBarAction(label: '', onPressed: () {}),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              };
                            },child: Text('Confirm',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontSize: 16),),color: kConstantBlueColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),),minWidth: 100,height: 38,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
