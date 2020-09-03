import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/Team.dart';
import 'package:hackapp/screens/teamsPages/adminMemberView.dart';
import 'package:hackapp/screens/teamsPages/memberView.dart';
import 'package:hackapp/screens/teamsPages/teamEdit.dart';
import 'package:hackapp/screens/teamsPages/teamInvitesCRUD.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TeamDetails extends StatefulWidget {
  final String id;
  TeamDetails({this.id});
  @override
  _TeamDetailsState createState() => _TeamDetailsState(this.id);
}

class _TeamDetailsState extends State<TeamDetails> {
  final _auth = FirebaseAuth.instance;
  String Token;
  _TeamDetailsState(this.id);
  String id;
  Future<Team> getTeam(String id) async {
    FirebaseUser user = await _auth.currentUser();
    Token = await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {"authtoken": Token};
    var response = await http.get(
        "$kBaseUrl/teams/getteaminfo/$id",
        headers: headers);
    if (response.statusCode == 200) {
      var teamsJson = jsonDecode(response.body);
      Team team = Team(
          teamId: teamsJson["_id"],
          creatorId: teamsJson["creatorId"],
          teamName: teamsJson["teamName"],
          eventId: teamsJson["eventId"],
          description: teamsJson["description"],
          skills: teamsJson["skillsRequired"],
          members: teamsJson["membersInfo"],
          eventName: teamsJson["nameOfEvent"],
          pendingRequests: teamsJson["pendingRequestsInfo"]);
      print(team);
      return team;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      backgroundColor: kConstantBlueColor,
      body: SafeArea(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: getTeam(id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        margin: EdgeInsets.only(top: 350),
                        child: SpinKitFoldingCube(
                          size: 50,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                                      'Project Description :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
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
                                      'Skills Required :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
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
                                      'Members :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: ListView.builder(
                                        itemCount: snapshot.data.members.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: index == 0
                                                ? () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    MemberView(
                                                                      user: snapshot
                                                                          .data
                                                                          .members[index],
                                                                      id: id,
                                                                    )));
                                                  }
                                                : () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AdminMemberView(
                                                                  user: snapshot
                                                                          .data
                                                                          .members[
                                                                      index],
                                                                  id: id,
                                                                )));
                                                  },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 25, 10),
                                              child: GestureDetector(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .white))),
                                                      height: 45,
                                                      width: 350,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    2, 10, 8, 0),
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: Text(
                                                                index == 0
                                                                    ? snapshot.data.members[index]
                                                                            [
                                                                            "name"] +
                                                                        ' (admin)'
                                                                    : snapshot
                                                                            .data
                                                                            .members[index]
                                                                        [
                                                                        "name"],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ))),
                                            ),
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                    child: Text(
                                      'Sent Invites :',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 0, 0),
                                      child: snapshot.data.pendingRequests
                                                  .length ==
                                              0
                                          ? Text(
                                              'You have no pending sent requests',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          : ListView.builder(
                                              itemCount: snapshot
                                                  .data.pendingRequests.length,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 25, 10),
                                                child: GestureDetector(
                                                  child: Container(
                                                    height: 45,
                                                    width: 350,
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color: Colors
                                                                    .white))),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  2, 10, 8, 0),
                                                          child: FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: Text(
                                                                snapshot.data
                                                                        .pendingRequests[
                                                                    index]['name'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        ),
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    InviteCRUD(
                                                                      user: snapshot
                                                                          .data
                                                                          .pendingRequests[index],
                                                                      id: id,
                                                                    )));
                                                  },
                                                ),
                                              ),
                                            )),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 32, 8, 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ButtonTheme(
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditTeam(
                                                            team: snapshot.data,
                                                          )));
                                            },
                                            color: Colors.white,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4),
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                        color:
                                                            kConstantBlueColor,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 0, 3),
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 18,
                                                    color: kConstantBlueColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                          ),
                                          minWidth: 100,
                                          height: 38,
                                        ),
                                      ],
                                    ),
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
      ),
    );
  }
}
