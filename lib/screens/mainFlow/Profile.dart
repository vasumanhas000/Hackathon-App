import 'package:flutter/material.dart';
import 'editUser.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<User> getUser() async {
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
        skills: usersJson["skills"],
      );
      return (user);
    }
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
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
            } else {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image(
                                image: AssetImage('images/Top-Rectangle.png')),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,8,0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Edit',
                                                style: TextStyle(
                                                    color: kConstantBlueColor,
                                                    fontSize: 22)),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: kConstantBlueColor,
                                                ),
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditUser(user:snapshot.data)));
                                                })
                                          ],
                                        ),
                                        Text('Sign out',
                                            style: TextStyle(
                                                color: kConstantBlueColor,
                                                fontSize: 22)),
                                      ],
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 18, 0, 0),
                                      child: Text(snapshot.data.name,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 30)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          child: Text(
                            'Email:',
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 30, 0, 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                snapshot.data.email,
                                style: TextStyle(fontSize: 22),
                              )),
                        ),
                        Padding(
                          child: Text(
                            'University Name:',
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              snapshot.data.college,
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                        Padding(
                          child: Text(
                            'Year of graduation',
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Text(
                            snapshot.data.year,
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Padding(
                          child: Text(
                            'Description',
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 25, 0, 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                          child: Text(
                            snapshot.data.bio,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
