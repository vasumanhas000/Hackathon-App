import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Future getUser() async {
    Map<String, String> headers = {"authtoken": "vaibhav"};
    var response = await http.get(
        "https://hackportal.herokuapp.com/users/getuserprofile",
        headers: headers);
    if (response.statusCode == 200) {
      var usersJson = jsonDecode(response.body);
      User user = User(
        name: usersJson['name'],
        college: usersJson['college'],
        bio: usersJson['bio'],
        year: usersJson['expectedGraduation'],
        email: usersJson['email'],
        github: usersJson['githubLink'],
        stack: usersJson['stackOverflowLink'],
        link: usersJson['externalLink'],
        id: usersJson["_id"],
        teamInvites: usersJson["teamInvitesInfo"],
      );
      
      return (user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'View Invites',
                style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600),
              ),
            ),
            FutureBuilder(
                future: getUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Container(
                          child: SpinKitFoldingCube(
                            size: 50,
                            color: kConstantBlueColor,
                          ),
                        ),
                      ),
                    );
                  }
                  else if (snapshot.data.teamInvites.length == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Center(
                        child: Text(
                          'You have no pending invites',
                        ),
                      ),
                    );
                  }
                  else{
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15,0,25,0),
                      child: Container(
                        height: 30,
                        color: Color.fromRGBO(41, 50, 65, 0.1),
                        child: Text(snapshot.data.teamInvites[index]['_id']),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
