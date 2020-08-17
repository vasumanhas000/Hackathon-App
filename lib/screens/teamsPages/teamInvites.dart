import 'package:flutter/material.dart';
import 'package:hackapp/components/Team.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/teamsPages/teamInvitesCRUD.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TeamInvites extends StatefulWidget {
  final String id;
  TeamInvites({this.id});
  @override
  _TeamInvitesState createState() => _TeamInvitesState(this.id);
}

class _TeamInvitesState extends State<TeamInvites> {
  _TeamInvitesState(this.id);
  Future viewInvites(String id) async {
    Map<String, String> headers = {"authtoken": "vaibhav"};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/teams/getteaminfo/$id",
        headers: headers);
    if (response.statusCode == 200) {
      var teamsJson = jsonDecode(response.body);
      Team team = Team(
        pendingRequests: teamsJson["pendingRequestsInfo"],
      );
      print(team);
      return team;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 23),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xff3d5a80),
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Container(
                    child: Text(
                      'View Invites',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Muli',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                child: FutureBuilder(
                    future: viewInvites(id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 350),
                          child: Container(
                            child: SpinKitFoldingCube(
                              size: 50,
                              color: kConstantBlueColor,
                            ),
                          ),
                        );
                      }
                      else if(snapshot.data.pendingRequests.length==0){
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 350),
                            child: Text('You have no pending requests'),
                          ),
                        );
                      }
                      else{
                        return ListView.builder(itemCount: snapshot.data.pendingRequests.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index)=>
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>InviteCRUD(user: snapshot.data.pendingRequests[index],id: id,)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15,0,25,10),
                                child: Container(
                                  height: 45,
                                  width: 350,
                                  color: Color.fromRGBO(41, 50, 65, 0.1),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data.pendingRequests[index]['name'],style: TextStyle(fontSize: 20),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

