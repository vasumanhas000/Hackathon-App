import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';
import 'package:hackapp/screens/addUserspages/invitesPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Future getUser() async {
    Map<String, String> headers = {"authtoken": "test"};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/users/getuserprofile",
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
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'View Invites',
                  style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: FutureBuilder(
                      future: getUser(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 200),
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
                            padding: const EdgeInsets.only(top: 200),
                            child: Center(
                              child: Text(
                                'You have no pending invites',
                              ),
                            ),
                          );
                        }
                        else{
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16,14,16,10),
                            child: ListView.builder(
                              itemCount: snapshot.data.teamInvites.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index1)=>
                               Padding(
                                 padding: const EdgeInsets.only(bottom: 10),
                                 child: GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AcceptInvite(id:snapshot.data.teamInvites[index]["_id"])));
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 350,
                                    color: Color.fromRGBO(41, 50, 65, 0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(child: FittedBox(fit: BoxFit.contain,child: Text(snapshot.data.teamInvites[index1]['teamName'],style: TextStyle(fontSize: 20),))),
                                        ],
                                      ),
                                    ),
                                  ),
                              ),
                               ),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
