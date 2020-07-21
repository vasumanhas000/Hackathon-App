import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/addUserspages/nonAdminTeam.dart';
import 'package:hackapp/screens/addUserspages/teamDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackapp/components/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/screens/addUserspages/page2.dart';

class MyTeams extends StatefulWidget {
  @override
  _MyTeamsState createState() => _MyTeamsState();
}

class _MyTeamsState extends State<MyTeams> {
  Future getTeams()async{
    Map<String, String> headers = {"authtoken": "vaibhav"};
    final String url= "https://hackportal.azurewebsites.net/users/getuserprofile";
    var response = await http.get(
        url, headers: headers);
    if(response.statusCode==200){
      var teamsJson=jsonDecode(response.body);
      User team= User(
        id: teamsJson["_id"],
        teams: teamsJson["teamsInfo"],
      );
      print(team);
      return team;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
            Padding(
            padding: const EdgeInsets.fromLTRB(16,24,8,0),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('My Teams',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:Border.all(color: kConstantBlueColor,width: 2.5),
                          ),
                          child: Center(child: IconButton(icon: Icon(Icons.email,color: kConstantBlueColor,size: 20,), onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Page2()));
                          })),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex:8,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48),
                      child: FutureBuilder(
                          future: getTeams(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 200),
                                child: Container(
                                  child: SpinKitFoldingCube(
                                    size: 50,
                                    color: kConstantBlueColor,
                                  ),
                                ),
                              );
                            }
                            else if(snapshot.data.teams.length==0){
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 200),
                                  child: Text('You have no teams'),
                                ),
                              );
                            }
                            else{
                              return ListView.builder(itemCount: snapshot.data.teams.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index)=>
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,8,16),
                                      child: GestureDetector(
                                        onTap: (){
                                          if(snapshot.data.teams[index]["creatorId"]==snapshot.data.id){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamDetails(id: snapshot.data.teams[index]["_id"],)));
                                          }
                                          else{
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NTeamDetails(id: snapshot.data.teams[index]["_id"],)));
                                          }
                                        },
                                        child: Container(
                                          height: 220,
                                          decoration: BoxDecoration(
                                            color: kConstantBlueColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(14,22,16,0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(fit: BoxFit.contain,child: Text(snapshot.data.teams[index]['teamName'],style: TextStyle(color: Colors.white,fontSize: 26),)),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(14,18,14,4),
                                                  child: AutoSizeText(snapshot.data.teams[index]['description'],style: TextStyle(color: Colors.white,fontSize: 16),maxLines: 7,),
                                                ),
                                              ],
                                            ),
                                          )
                                        ),
                                      ),
                                    ),
                              );
                            }
                          }
                      ),
                    ),
                  ),
                ],
              ),
        ),
         ),
    );
  }
}
