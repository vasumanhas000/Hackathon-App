import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/Team.dart';
import 'package:hackapp/screens/teamsPages/memberView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NTeamDetails extends StatefulWidget {
  final String id;
  NTeamDetails({this.id});
  @override
  _NTeamDetailsState createState() => _NTeamDetailsState(this.id);
}

class _NTeamDetailsState extends State<NTeamDetails> {
  final _auth = FirebaseAuth.instance;
  String Token;
  _NTeamDetailsState(this.id);
  String id;
  Future<Team> getTeam(String id) async {
    FirebaseUser user = await _auth.currentUser();
    Token = await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {"authtoken": Token};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/teams/getteaminfo/$id",
        headers: headers);
    if (response.statusCode == 200) {
      var teamsJson = jsonDecode(response.body);
      Team team = Team(
          creatorId: teamsJson["creatorId"],
          teamName: teamsJson["teamName"],
          eventId: teamsJson["eventId"],
          description: teamsJson["description"],
          skills: teamsJson["skillsRequired"],
          members: teamsJson["membersInfo"],
          eventName: teamsJson["nameOfEvent"]);
      return team;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kConstantBlueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: getTeam(id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Container(
                        child: SpinKitFoldingCube(
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: 1,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    snapshot.data.teamName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontFamily: 'Muli'),
                                  ),
                                  fit: BoxFit.contain,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: FittedBox(
                                    child: Text(
                                      snapshot.data.eventName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontFamily: 'Muli'),
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  child: Text(
                                    'Project Description:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    snapshot.data.description,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  child: Text(
                                    'Skills Required:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: ListView.builder(
                                      itemCount: snapshot.data.skills.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Text(
                                            snapshot.data.skills[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        );
                                      }),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  child: Text(
                                    'Members:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: ListView.builder(
                                      itemCount: snapshot.data.members.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MemberView(user: snapshot
                                                .data
                                                .members[index],
                                              id: id,)));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 25, 10),
                                            child: Container(
                                                height: 45,
                                                width: 350,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.25),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(16,0,8,0),
                                                      child: FittedBox(
                                                        child: Text(
                                              index == 0
                                                          ? snapshot.data.members[index]
                                                                  ["name"] +
                                                              ' (admin)'
                                                          : snapshot.data.members[index]
                                                              ["name"],
                                              style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                            ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
