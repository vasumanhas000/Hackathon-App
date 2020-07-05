import 'package:flutter/material.dart';
import 'package:hackapp/screens/addUserspages/nonAdminTeam.dart';
import 'package:hackapp/screens/addUserspages/teamDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackapp/components/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/constants.dart';
class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Future getTeams()async{
    Map<String, String> headers = {"authtoken": "vaibhav"};
    final String url= "https://hackportal.herokuapp.com/users/getuserprofile";
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,30,8,10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My teams',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FutureBuilder(
              future: getTeams(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Container(
                      child: SpinKitFoldingCube(
                        size: 50,
                        color: kConstantBlueColor,
                      ),
                    ),
                  );
                }
                else if(snapshot.data.teams.length==0){
                  return Text('You have no teams');
                }
                else{
                  return ListView.builder(itemCount: snapshot.data.teams.length,
                    shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)=>
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,20,0),
                      child: GestureDetector(
                        onTap: (){
                          if(snapshot.data.teams[index]["creatorId"]==snapshot.data.id){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamDetails(id: snapshot.data.teams[index]["_id"],)));
                        }
                          else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NTeamDetails(id: snapshot.data.teams[index]["_id"],)));
                          }
                          },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: kConstantBlueColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child:
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                        child: Text(snapshot.data.teams[index]['teamName'],style: TextStyle(color: Colors.white,fontSize: 20),),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
