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
  final UserSearch user;
  UserDetails({@required this.user});
  @override
  _UserDetailsState createState() => _UserDetailsState(this.user);
}

class _UserDetailsState extends State<UserDetails> {
  Future getUser() async {
    Map<String, String> headers = {"authtoken": "vaibhav"};
    var response = await http.get(
        "https://hackportal.herokuapp.com/users/getuserprofile",
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
  UserSearch user;
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
              Stack(
                children: [
                  Image(image: AssetImage('images/Top-Rectangle.png')),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 38,
                              color: kConstantBlueColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 26, 0, 0),
                          child: FittedBox(
                            child: Text(
                              user.name,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'Email:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: FittedBox(
                  child: Text(
                    user.email,
                    style: TextStyle(fontSize: 21),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'University Name:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: FittedBox(
                  child: Text(
                    user.college,
                    style: TextStyle(fontSize: 21),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'Year of graduation',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: FittedBox(
                  child: Text(
                    user.year,
                    style: TextStyle(fontSize: 21),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'Description:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 6, 0),
                child: Text(
                  user.bio,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'Skills:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                    itemCount: user.skills.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (user.skills.length == 0) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Text('No Skills'),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(60, 5, 0, 0),
                          child: Text(
                            user.skills[index],
                            style: TextStyle(fontSize: 17),
                          ),
                        );
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserInvite(
                                      admin: admin,
                                      email: user.email,
                                    )));
                        Scaffold.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(content: Text("$result",style: TextStyle(fontFamily: 'Montserrat',color:Colors.white),),backgroundColor: result!=null?Color(0xff98c1d9):Colors.white,));
                      },
                      child: Text(
                        'Invite',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: kConstantBlueColor,
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
