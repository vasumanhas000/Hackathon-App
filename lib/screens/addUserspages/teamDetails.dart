import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/Team.dart';
import 'package:hackapp/screens/addUserspages/teamEdit.dart';
import 'package:hackapp/screens/addUserspages/teamInvites.dart';
import 'package:hackapp/screens/addUserspages/teamInvitesCRUD.dart';
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
  Future<Team> getTeam(String id)async{
    FirebaseUser user = await _auth.currentUser();
    Token= await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {"authtoken": Token};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/teams/getteaminfo/$id",
        headers: headers);
    if(response.statusCode==200){
      var teamsJson=jsonDecode(response.body);
      Team team= Team(
        teamId: teamsJson["_id"],
        creatorId: teamsJson["creatorId"],
        teamName: teamsJson["teamName"],
        eventId: teamsJson["eventId"],
        description: teamsJson["description"],
        skills: teamsJson["skillsRequired"],
        members: teamsJson["membersInfo"],
        eventName: teamsJson["nameOfEvent"],
        pendingRequests: teamsJson["pendingRequestsInfo"]
      );
      return team;
    }
    else{
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
            itemBuilder: (BuildContext context, int index)=>
             Padding(
              padding: const EdgeInsets.fromLTRB(16,0,8,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: getTeam(id),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        if (snapshot.data == null) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 200),
                            child: Container(
                              child: SpinKitFoldingCube(
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        else{
                          return ListView.builder(itemCount: 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index){
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8,30,8,0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(child: Text(snapshot.data.teamName,style: TextStyle(color: Colors.white,fontSize: 32,fontFamily: 'Muli'),),fit: BoxFit.contain,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: FittedBox(child: Text(snapshot.data.eventName,style: TextStyle(color: Colors.white,fontSize: 22,fontFamily: 'Muli'),),fit: BoxFit.contain,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,25,0,0),
                                    child: Text('Project Description :',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                                  ),
                                  Padding(
                                    padding
                                        : const EdgeInsets.fromLTRB(0,10,0,0),
                                    child: Text(snapshot.data.description,style: TextStyle(color: Colors.white,fontSize: 16),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(2,25,0,0),
                                    child: Text('Skills Required :',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(2,10,0,0),
                                    child: ListView.builder(itemCount: snapshot.data.skills.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context, int index){
                                         return Padding(
                                           padding: const EdgeInsets.only(top: 3),
                                           child: Text(snapshot.data.skills[index],style: TextStyle(color: Colors.white,fontSize: 16),),
                                         );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(2,25,0,0),
                                    child: Text('Members :',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(2,10,0,0),
                                    child: ListView.builder(itemCount: snapshot.data.members.length,
                                        shrinkWrap: true,
                                        physics:NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index){
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 3),
                                            child: Text(snapshot.data.members[index]["name"],style: TextStyle(color: Colors.white,fontSize: 16),),
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(2,25,0,0),
                                    child: Text('Sent Invites :',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                                  ),
                                  Padding(padding: const EdgeInsets.fromLTRB(2,10,0,0),
                                  child:snapshot.data.pendingRequests.length==0?Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Text('You have no pending sent requests',style: TextStyle(color: Colors.white,fontSize: 12),),
                                  ):
                                      ListView.builder(itemCount: snapshot.data.pendingRequests.length,physics:NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (BuildContext context, int index)=>
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0,0,25,10),
                                            child: GestureDetector(
                                              child: Container(
                                                height: 45,
                                                width: 350,
                                                color: Color.fromRGBO(255, 255, 255, 0.25),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(16,0,8,0),
                                                      child: FittedBox(fit: BoxFit.contain,child: Text(snapshot.data.pendingRequests[index]['name'],style: TextStyle(fontSize: 16,color: Colors.white),)),
                                                    ),
                                                  ],
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                ),
                                              ),
                                              onTap: (){
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>InviteCRUD(user: snapshot.data.pendingRequests[index],id: id,)));
                                              },
                                            ),
                                          ),
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,32,8,8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        RaisedButton(onPressed: (){
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditTeam(team: snapshot.data,)));
                                        },color: Colors.white,child: Row(
                                          children: [
                                            Text('Edit',style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat'),),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 6),
                                              child: Icon(Icons.edit,size: 16,color: kConstantBlueColor,),
                                            ),
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
