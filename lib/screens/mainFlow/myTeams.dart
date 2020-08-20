import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/teamsPages/nonAdminTeam.dart';
import 'package:hackapp/screens/teamsPages/teamDetails.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:hackapp/components/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/screens/teamsPages/myTeamsMain.dart';

class MyTeams extends StatefulWidget {
  @override
  _MyTeamsState createState() => _MyTeamsState();
}

class _MyTeamsState extends State<MyTeams> {
  final _auth = FirebaseAuth.instance;
  DioCacheManager _dioCacheManager;
  String Token;
  Future getTeams()async{
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(Duration(days: 7),forceRefresh: true);
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    FirebaseUser user = await _auth.currentUser();
    Token= await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    _dio.options.headers["authtoken"] = "$Token";
//    Map<String, String> headers = {"authtoken": Token};
    final String url= "https://hackportal.azurewebsites.net/users";
    Response response = await _dio.get(
        url,options: _cacheOptions);
    if(response.statusCode==200){
      var teamsJson=response.data;
      User team= User(
        id: teamsJson["_id"],
        teams: teamsJson["teamsInfo"],
      );
      print(team);
      return team;
    }
  }
  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
      },child: Icon(Icons.add,color: kConstantBlueColor,size: 32,),backgroundColor: Colors.white,tooltip: 'Create Team',),
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Page2()));
                          })),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex:8,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 36),
                      child: FutureBuilder(
                          future: getTeams(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 120),
                                  child: Container(
                                    child: SpinKitFoldingCube(
                                      size: 50,
                                      color: kConstantBlueColor,
                                    ),
                                  ),
                                ),
                              );
                            }
                            else if(snapshot.data.teams.length==0){
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 120),
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
                                      padding: const EdgeInsets.fromLTRB(0,0,8,24),
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
                                              topLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(14,22,16,0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(fit: BoxFit.contain,child: Text(snapshot.data.teams[index]['teamName'],style: TextStyle(color: Colors.white,fontSize: 26),)),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(20,18,14,4),
                                                  child: Text(truncateWithEllipsis(240, snapshot.data.teams[index]['description']),style: TextStyle(color: Colors.white,fontSize: 14),maxLines: 6,),
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
