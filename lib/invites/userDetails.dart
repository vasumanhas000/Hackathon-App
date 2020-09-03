import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';
import 'package:hackapp/invites/userInvites.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackapp/components/sizeConfig.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,24,16,24),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Muli'
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Image(image: AssetImage('images/stc.png'),fit: BoxFit.contain,height: SizeConfig.safeBlockVertical*3.15,color: kConstantBlueColor,),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 14, 0, 0),
                child: Text(
                  'Name :',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 5, 8, 0),
                child: FittedBox(
                  child: Text(
                    user['name'],
                    style:
                    TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 25, 0, 0),
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
                          final result =await Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInvites(email: user['email'],)));
                          // = await Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => UserInvite(
                          //               admin: admin,
                          //               email: user['email'],
                          //             )));
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
