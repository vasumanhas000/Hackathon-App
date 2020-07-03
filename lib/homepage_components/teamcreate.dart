import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

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
    String url = 'https://hackportal.herokuapp.com/teams/setteam';
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "eventId": id,
          "teamName": name,
          "description": description,
          "skillsRequired": skills,
        }));
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

  _CreateTeamState(this.id);

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _dismissKeyboard(context);
      },
      child: SafeArea(
        child: Scaffold(
          body: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 23),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color(0xff3d5a80),
                            size: 28,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Container(
                        child: Text(
                          'Create Your Team',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Muli',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(28, 10, 0, 0),
                  child: Text(
                    'Team name:',
                    style: TextStyle(color: Color(0xff293241), fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                  margin: EdgeInsets.fromLTRB(28, 10, 0, 0),
                  child: Text(
                    'Project Description:',
                    style: TextStyle(color: Color(0xff293241), fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                  margin: EdgeInsets.fromLTRB(28, 10, 0, 0),
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
                          size: 20,
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
                          child: Text('Web Development'),
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
                          size: 20,
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
                          child: Text('Mobile App Development'),
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
                          size: 20,
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
                          child: Text('Devops'),
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
                          size: 20,
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
                          child: Text('Machine Learning'),
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
                          size: 20,
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
                          child: Text('Artificial Intelligence'),
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
                          size: 20,
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
                          child: Text('Design - UI/UX'),
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
                          size: 20,
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
                          child: Text('Management skills'),
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
                          size: 20,
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
                          child: Text('Blockchain'),
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
                          size: 20,
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
                          child: Text('CyberSecurity'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
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
                          child: Text('Cancel'),
                          color: Colors.white,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (selectWeb == 1) {
                            skillList.add('Web Dev');
                          }
                          if (selectMobile == 1) {
                            skillList.add('App Dev');
                          }
                          if (selectDevOps == 1) {
                            skillList.add('DevOps');
                          }
                          if (selectML == 1) {
                            skillList.add('Machine Learning');
                          }
                          if (selectAI == 1) {
                            skillList.add('AI');
                          }
                          if (selectDesign == 1) {
                            skillList.add('Design');
                          }
                          if (selectManagement == 1) {
                            skillList.add('Management');
                          }
                          if (selectBlock == 1) {
                            skillList.add('BlockChain');
                          }
                          if (selectCyber == 1) {
                            skillList.add('CyberSecurity');
                          }
                          if(selectWeb!=1){
                            for(var i in skillList){
                              if(i=='Web Dev'){
                                toRemove.add(i);
                              }
                            }
                          }
                          if(selectMobile!=1){
                            for(var i in skillList){
                              if(i=='App Dev'){
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
                              if(i=='AI'){
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
                            Navigator.pop(
                                context, 'Your team was successfully created.');
                          } else {
                            final snackBar = SnackBar(
                              content: Text(
                                'Error.Please try again later',style: TextStyle(color: Colors.purple),
                              ),
                              action:
                                  SnackBarAction(label: '', onPressed: () {}),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: kConstantBlueColor,
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
