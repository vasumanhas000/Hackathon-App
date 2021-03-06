import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/teamsPages/myTeamsMain.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'package:hackapp/screens/mainFlow/myTeams.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackapp/components/Team.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AcceptInvite extends StatefulWidget {
  final String id;
  AcceptInvite({this.id});
  @override
  _AcceptInviteState createState() => _AcceptInviteState(this.id);
}

class _AcceptInviteState extends State<AcceptInvite> {
  final _auth = FirebaseAuth.instance;
  String Token;
  Future getTeam(String id) async {
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
      print(teamsJson);
      if (response.statusCode == 200) {
        var teamsJson = jsonDecode(response.body);
        Team team = Team(
            creatorId: teamsJson["creatorId"],
            teamName: teamsJson["teamName"],
            eventId: teamsJson["eventId"],
            description: teamsJson["description"],
            skills: teamsJson["skillsRequired"],
            members: teamsJson["membersInfo"],
            eventName: teamsJson["nameOfEvent"],
            cId: teamsJson["creatorInfo"]["_id"],
            cName: teamsJson["creatorInfo"]["name"]);
        return team;
      } else {
        print(response.statusCode);
        return null;
      }
    }
  }

  Future acceptInvite(String id) async {
    Map<String, String> headers = {
      "authtoken": Token,
      "Content-Type": "application/json",
    };
    var response = await http.patch(
      "$kBaseUrl/users/acceptteaminvite/$id",
      headers: headers,
    );
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

  Future rejectInvite(String id) async {
    Map<String, String> headers = {
      "authtoken": Token,
      "Content-Type": "application/json",
    };
    var response = await http.patch(
      "$kBaseUrl/users/rejectteaminvite/$id",
      headers: headers,
    );
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

  String id;
  _AcceptInviteState(this.id);
  bool _isInAsyncCall = false;
  void _moveToSignInScreen(BuildContext context) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Page2()));
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _moveToSignInScreen(context);
      },
      child: Scaffold(
          backgroundColor: kConstantBlueColor,
          body: ModalProgressHUD(
            inAsyncCall: _isInAsyncCall,
            opacity: 0.5,
            progressIndicator: SpinKitFoldingCube(
              color: kConstantBlueColor,
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: getTeam(id),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 350),
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
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(8, 30, 8, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          padding:
                                              const EdgeInsets.only(top: 12),
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
                                              const EdgeInsets.only(top: 25),
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
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            snapshot.data.description,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 25, 0, 0),
                                          child: Text(
                                            'Skills Required:',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        ListView.builder(
                                            itemCount:
                                                snapshot.data.skills.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 3, 0, 0),
                                                child: Text(
                                                  snapshot.data.skills[index],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              );
                                            }),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 25, 0, 0),
                                          child: Text(
                                            'Creator:',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 3, 0, 0),
                                          child: Text(
                                            snapshot.data.cName,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 32, 8, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: ButtonTheme(
                                                  child: FlatButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        _isInAsyncCall = true;
                                                      });
                                                      if (await rejectInvite(
                                                              id) ==
                                                          200) {
                                                        _isInAsyncCall = false;
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Page2()));
                                                      } else {
                                                        _isInAsyncCall = false;
                                                        final snackBar =
                                                            SnackBar(
                                                          content: Text(
                                                            'Error.Please try again later',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color:
                                                                    kConstantBlueColor),
                                                          ),
                                                          backgroundColor:
                                                              Colors.white,
                                                        );
                                                        await Scaffold.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      }
                                                    },
                                                    child: Text(
                                                      'Decline',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              kConstantBlueColor),
                                                    ),
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                  ),
                                                  minWidth: 100,
                                                  height: 38,
                                                ),
                                              ),
                                              ButtonTheme(
                                                child: FlatButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      _isInAsyncCall = true;
                                                    });
                                                    if (await acceptInvite(
                                                            id) ==
                                                        201) {
                                                      setState(() {
                                                        _isInAsyncCall = false;
                                                      });
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Page2()));
                                                    } else {
                                                      setState(() {
                                                        _isInAsyncCall = false;
                                                      });
                                                      final snackBar = SnackBar(
                                                        content: Text(
                                                          'Error.Please try again later',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color:
                                                                  kConstantBlueColor),
                                                        ),
                                                        backgroundColor:
                                                            Colors.white,
                                                      );
                                                      await Scaffold.of(context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    }
                                                  },
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Montserrat'),
                                                  ),
                                                  color: kConstantBlueColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      side: BorderSide(
                                                          color: Colors.white,
                                                          width: 2)),
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
                        }),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
