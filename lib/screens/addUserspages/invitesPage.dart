import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/addUserspages/page2.dart';
import 'package:hackapp/screens/mainFlow/addUsers.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackapp/components/Team.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AcceptInvite extends StatefulWidget {
  final String id;
  AcceptInvite({this.id});
  @override
  _AcceptInviteState createState() => _AcceptInviteState(this.id);
}

class _AcceptInviteState extends State<AcceptInvite> {
  Future getTeam(String id) async {
    Map<String, String> headers = {"authtoken": "test"};
    var response = await http.get(
        "https://hackportal.herokuapp.com/teams/getteaminfo/$id",
        headers: headers);
    if (response.statusCode == 200) {
      var teamsJson = jsonDecode(response.body);
      print(teamsJson);
      if(response.statusCode==200){
        var teamsJson=jsonDecode(response.body);
        Team team= Team(
            creatorId: teamsJson["creatorId"],
            teamName: teamsJson["teamName"],
            eventId: teamsJson["eventId"],
            description: teamsJson["description"],
            skills: teamsJson["skillsRequired"],
            members: teamsJson["membersInfo"],
            eventName: teamsJson["nameOfEvent"],
            cId: teamsJson["creatorInfo"]["_id"],
            cName: teamsJson["creatorInfo"]["name"]
        );
        return team;
      }
      else{
        print(response.statusCode);
        return null;
      }
    }
  }
  Future acceptInvite(String id) async{
    Map<String, String> headers = {"authtoken": "test","Content-Type": "application/json",};
    var response = await http.patch(
        "https://hackportal.herokuapp.com/users/acceptteaminvite/$id",
        headers: headers,);
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }
  Future rejectInvite(String id) async{
    Map<String, String> headers = {"authtoken": "test","Content-Type": "application/json",};
    var response = await http.patch(
      "https://hackportal.herokuapp.com/users/rejectteaminvite/$id",
      headers: headers,);
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }
  String id;
  _AcceptInviteState(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kConstantBlueColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8,20,8,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.arrowCircleLeft,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FlowPage(currentIndex: 2,)));
                  },
                ),
                FutureBuilder(
                    future: getTeam(id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                            itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8,30,0,0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FittedBox(child: Text(snapshot.data.teamName,style: TextStyle(color: Colors.white,fontSize: 32,fontFamily: 'Muli'),),fit: BoxFit.contain,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2,20,8,0),
                                  child: FittedBox(child: Text(snapshot.data.eventName,style: TextStyle(color: Colors.white,fontSize: 22,fontFamily: 'Muli'),),fit: BoxFit.contain,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2,25,0,0),
                                  child: Text('Project Description:',style: TextStyle(color: Colors.white,fontSize: 15),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(4,10,8,0),
                                  child: Text(snapshot.data.description,style: TextStyle(color: Colors.white,fontSize: 17),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2,25,0,0),
                                  child: Text('Skills Required:',style: TextStyle(color: Colors.white,fontSize: 15),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(80,10,0,0),
                                  child: ListView.builder(itemCount: snapshot.data.skills.length,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context, int index){
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 3),
                                          child: Text(snapshot.data.skills[index],style: TextStyle(color: Colors.white,fontSize: 17),),
                                        );
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2,25,0,0),
                                  child: Text('Creator:',style: TextStyle(color: Colors.white,fontSize: 15),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(80,10,0,0),
                                  child:  Padding(
                                          padding: const EdgeInsets.only(top: 3),
                                          child: Text(snapshot.data.cName,style: TextStyle(color: Colors.white,fontSize: 17),),
                                        )
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,30,8,0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: RaisedButton(onPressed: ()async{
                                          if(await rejectInvite(id)==200){
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FlowPage(currentIndex: 2,)));
                                        }
                                          else{
                                            final snackBar=SnackBar(content: Text('Error.Please try again later',style: TextStyle(fontFamily: 'Montserrat',color: kConstantBlueColor),),backgroundColor: Colors.white,);
                                            await Scaffold.of(context).showSnackBar(snackBar);
                                          }
                                          },child: Text('Decline'),color: Colors.white,),
                                      ),
                                      RaisedButton(onPressed: ()async{
                                        if(await acceptInvite(id)==201){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FlowPage(currentIndex: 2,)));
                                      }
                                        else{
                                          final snackBar=SnackBar(content: Text('Error.Please try again later',style: TextStyle(fontFamily: 'Montserrat',color: kConstantBlueColor),),backgroundColor: Colors.white,);
                                          await Scaffold.of(context).showSnackBar(snackBar);
                                        }
                                        },child: Text('Accept',style: TextStyle(color: Colors.white),),color: kConstantBlueColor,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                            });
                      }
                    }),

              ],
            ),
          ),
        ));
  }
}
