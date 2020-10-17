import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/components/User.dart';
import 'package:hackapp/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:http/http.dart' as http;

class UserInvites extends StatefulWidget {
  final String email;
  UserInvites({this.email});
  @override
  _UserInvitesState createState() => _UserInvitesState();
}

class _UserInvitesState extends State<UserInvites> {
  bool _isInAsyncCall = false;
  final _auth = FirebaseAuth.instance;
  String Token;
  Future getUser() async {
    FirebaseUser user = await _auth.currentUser();
    Token = await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    List admin = [];
    Map<String, String> headers = {"authtoken": Token};
    var response = await http.get("$kBaseUrl/users", headers: headers);
    if (response.statusCode == 200) {
      var usersJson = jsonDecode(response.body);
      User user1 = User(
        id: usersJson["_id"],
        name: usersJson['name'],
        college: usersJson['college'],
        bio: usersJson['bio'],
        year: usersJson['expectedGraduation'],
        teams: usersJson['teamsInfo'],
        email: usersJson['email'],
        github: usersJson['githubLink'],
        stack: usersJson['stackOverflowLink'],
        link: usersJson['externalLink'],
      );
      for (var i in user1.teams) {
        if (i["creatorId"] == user1.id) {
          print(i);
          admin.add(i);
        }
      }
      return admin;
    }
  }

  Future sendInvite(String id) async {
    FirebaseUser user1 = await _auth.currentUser();
    Token = await user1.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authtoken": Token
    };
    String url = '$kBaseUrl/teams/sendinvite';
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "inviteeEmail": widget.email,
          "teamId": id,
        }));
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

  bool button = false;
  String _selectedRadio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: _isInAsyncCall,
            opacity: 0.5,
            progressIndicator: SpinKitFoldingCube(
              color: kConstantBlueColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      child: FittedBox(
                        child: Text(
                          'Send Invite',
                          style: TextStyle(
                              fontFamily: 'Muli',
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: Image(
                        image: AssetImage('images/stc.png'),
                        color: kConstantBlueColor,
                        height: SizeConfig.safeBlockVertical * 3.15,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 8, 0),
                  child: Text(
                    'Choose team :',
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                ),
                SizedBox(),
                Expanded(
                  child: FutureBuilder(
                      future: getUser(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: Container(
                              child: SpinKitFoldingCube(
                                size: 50,
                                color: kConstantBlueColor,
                              ),
                            ),
                          );
                        } else if (snapshot.data.length == 0) {
                          return Center(
                            child: Container(
                              child: Text(
                                "You don't have teams to choose from.",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: kConstantBlueColor),
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 8),
                                child: RadioListTile(
                                  value: snapshot.data[index]['_id'],
                                  groupValue: _selectedRadio,
                                  onChanged: (val) {
                                    setState(() {
                                      button = true;
                                      _selectedRadio = val;
                                    });
                                  },
                                  title: Text(
                                    snapshot.data[index]['teamName'],
                                    style: TextStyle(
                                        color: kConstantBlueColor,
                                        fontSize: 26),
                                  ),
                                ),
                                // child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: <Widget>[
                                //       Row(
                                //         children: <Widget>[
                                //           Radio(
                                //               value: snapshot.data[index]
                                //                   ['_id'],
                                //               groupValue: _selectedRadio,
                                //               onChanged: (val) {
                                //                 setState(() {
                                //                    button=true;
                                //                   _selectedRadio = val;
                                //                 });
                                //               }),
                                //           FittedBox(
                                //             fit: BoxFit.contain,
                                //             child: Text(
                                //               snapshot.data[index]['teamName'],
                                //               style: TextStyle(
                                //                   color: kConstantBlueColor,
                                //                   fontSize: 26),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ]),
                              );
                            },
                          );
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 32, 16, 8),
                  child: button == false
                      ? SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                                minWidth: 100,
                                height: 38,
                                child: FlatButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isInAsyncCall = true;
                                    });
                                    if (await sendInvite(_selectedRadio) ==
                                        200) {
                                      setState(() {
                                        _isInAsyncCall = false;
                                      });
                                      print('success');
                                      Navigator.pop(context,
                                          'Invite was successfully sent.');
                                    } else if (await sendInvite(
                                            _selectedRadio) ==
                                        400) {
                                      setState(() {
                                        _isInAsyncCall = false;
                                      });
                                      final snackBar = SnackBar(
                                        content: Text(
                                          'User already has a team for the given hack',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat'),
                                        ),
                                        backgroundColor: kConstantBlueColor,
                                      );
                                      await Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Text(
                                          'Error.Please try again later.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat'),
                                        ),
                                        backgroundColor: kConstantBlueColor,
                                      );
                                      await Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: Text(
                                    'Send Invite',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat'),
                                  ),
                                  color: kConstantBlueColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                )),
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
