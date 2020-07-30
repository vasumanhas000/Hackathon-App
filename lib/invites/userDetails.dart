import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackapp/components/userSearch.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/invites/userInvite.dart';
import 'package:hackapp/components/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetails extends StatefulWidget {
  final user;
  UserDetails({@required this.user});
  @override
  _UserDetailsState createState() => _UserDetailsState(this.user);
}

class _UserDetailsState extends State<UserDetails> {
  final _auth = FirebaseAuth.instance;
  String Token;
  Future getUser() async {
    FirebaseUser user = await _auth.currentUser();
    Token= await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {"authtoken": Token};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/users",
        headers: headers);
    if (response.statusCode == 200) {
      var usersJson = jsonDecode(response.body);
      User user = User(
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
      for (var i in user.teams) {
        if (i["creatorId"] == user.id) {
          print(i);
          admin.add(i);
        }
      }
    }
  }
  List admin = [];
  var user;
  _UserDetailsState(this.user);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 32, 8, 0),
                child: FittedBox(
                  child: Text(
                    user['name'],
                    style:
                    TextStyle(fontSize: 32,fontWeight: FontWeight.w600),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 30, 0, 0),
                child: Text(
                  'Email:',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 5, 0, 0),
                child: FittedBox(
                  child: Text(
                    user['email'],
                    style: TextStyle(fontSize: 18),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 25, 0, 0),
                child: Text(
                  'University Name:',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 5, 0, 0),
                child: FittedBox(
                  child: Text(
                    user['college'],
                    style: TextStyle(fontSize: 18),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 25, 0, 0),
                child: Text(
                  'Year of graduation',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 5, 0, 0),
                child: FittedBox(
                  child: Text(
                    user['expectedGraduation'],
                    style: TextStyle(fontSize: 18),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 25, 0, 0),
                child: Text(
                  'Description:',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 5, 6, 0),
                child: Text(
                  user['bio'],
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 25, 0, 0),
                child: Text(
                  'Skills:',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                ),
              ),
              ListView.builder(
                  itemCount: user['skills'].length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if (user['skills'].length == 0) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text('No Skills'),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(22, 8, 0, 0),
                        child: Text(
                          user['skills'][index],
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonTheme(
                      height: 38,
                      minWidth: 100,
                      child: FlatButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserInvite(
                                        admin: admin,
                                        email: user['email'],
                                      )));
                          Scaffold.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("$result",style: TextStyle(fontFamily: 'Montserrat',color:Colors.white),),backgroundColor: result!=null?kConstantBlueColor:Colors.white,));
                        },
                        child: Text(
                          'Invite',
                          style: TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        color: kConstantBlueColor,
                      ),
                    )
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
