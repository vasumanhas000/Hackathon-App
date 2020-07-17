import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreateTeam extends StatefulWidget {
  final String id;
  CreateTeam({@required this.id});
  @override
  _CreateTeamState createState() => _CreateTeamState(this.id);
}

class _CreateTeamState extends State<CreateTeam> {
  int selectWeb,
      selectMobile,
      selectDevOps,
      selectML,
      selectAI,
      selectDesign,
      selectManagement,
      selectBlock,
      selectCyber;
  String id;
  String name, description;
  List skillList = [];
  var toRemove=[];
  Future postTeam(
      String name, String description, String id, List skills) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authtoken": "vaibhav"
    };
    String url = 'https://hackportal.azurewebsites.net/teams/setteam';
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "eventId": id,
          "teamName": name,
          "description": description,
          "skillsRequired": skills,
        }));
    print(response.statusCode);
    return response.statusCode;
  }

  _CreateTeamState(this.id);
  bool _isInAsyncCall = false;

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        _dismissKeyboard(context);
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16,24,16,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Create Your Team',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Muli',
                              ),
                            ),
                          ),
                          Image(image: AssetImage('images/stc.png'),fit: BoxFit.contain,height: SizeConfig.safeBlockVertical*3.15,)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Text(
                        'Team name:',
                        style: TextStyle(color: Color(0xff293241), fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        decoration: kTextFieldDecoration,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Project Description:',
                        style: TextStyle(color: Color(0xff293241), fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        maxLines: 6,
                        decoration: kTextFieldDecoration,
                        onChanged: (val) {
                          setState(() {
                            description = val;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Skills required:',
                        style: TextStyle(color: Color(0xff293241), fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectWeb == 1
                                  ? kConstantBlueColor
                                  : Color(0xffD8D8D8),
                            ),
                            onTap: () {
                              setState(() {
                                if (selectWeb != 1) {
                                  selectWeb = 1;
                                } else {
                                  selectWeb = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Text('Web Development',style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectMobile == 1
                                  ? kConstantBlueColor
                                  : Color(0xffD8D8D8),
                            ),
                            onTap: () {
                              setState(() {
                                if (selectMobile != 1) {
                                  selectMobile = 1;
                                } else {
                                  selectMobile = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Text('Mobile App Development',style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectDevOps == 1
                                  ? kConstantBlueColor
                                  : Color(0xffD8D8D8),
                            ),
                            onTap: () {
                              setState(() {
                                if (selectDevOps != 1) {
                                  selectDevOps = 1;
                                } else {
                                  selectDevOps = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Text('DevOps',style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectML == 1
                                  ? kConstantBlueColor
                                  : Color(0xffD8D8D8),
                            ),
                            onTap: () {
                              setState(() {
                                if (selectML != 1) {
                                  selectML = 1;
                                } else {
                                  selectML = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Text("Machine Learning",style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectAI == 1
                                  ? kConstantBlueColor
                                  : Color(0xffD8D8D8),
                            ),
                            onTap: () {
                              setState(() {
                                if (selectAI != 1) {
                                  selectAI = 1;
                                } else {
                                  selectAI = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Text('Artificial Intelligence',style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectDesign == 1
                                  ? kConstantBlueColor
                                  : Color(0xffD8D8D8),
                            ),
                            onTap: () {
                              setState(() {
                                if (selectDesign != 1) {
                                  selectDesign = 1;
                                } else {
                                  selectDesign = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Text('Design - UI/UX',style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectManagement == 1
                                  ? kConstantBlueColor
                                  : Color(0xffD8D8D8),
                            ),
                            onTap: () {
                              setState(() {
                                if (selectManagement != 1) {
                                  selectManagement = 1;
                                } else {
                                  selectManagement = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Text('Management Skills',style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectBlock == 1
                                  ? kConstantBlueColor
                                  : Color(0xffD8D8D8),
                            ),
                            onTap: () {
                              setState(() {
                                if (selectBlock != 1) {
                                  selectBlock = 1;
                                } else {
                                  selectBlock = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Text('Blockchain',style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 15, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.fiber_manual_record,
                              size: 24,
                              color: selectCyber == 1
                                  ? kConstantBlueColor
                                  : Color(0xffD8D8D8),
                            ),
                            onTap: () {
                              setState(() {
                                if (selectCyber != 1) {
                                  selectCyber = 1;
                                } else {
                                  selectCyber = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Text('CyberSecurity',style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 24, 24, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(
                                    context, 'Team creation was cancelled.');
                              },
                              child: Text('Cancel',style: TextStyle(color: kConstantBlueColor),),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color: kConstantBlueColor,width: 1)),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              setState(() {
                                _isInAsyncCall=true;
                              });
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
                              if (await postTeam(
                                      name, description, id, skillList) ==
                                  200) {
                                setState(() {
                                  _isInAsyncCall=false;
                                });
                                Navigator.pop(
                                    context, 'Your team was successfully created.');
                              } else {
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
                              }
                            },
                            child: Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white,fontFamily:'Montserrat'),
                            ),
                            color: kConstantBlueColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
    );
  }
}
