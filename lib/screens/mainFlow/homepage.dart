import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/homepage_components/adminDetailsPage.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/homepage_components/detailspage.dart';
import 'package:hackapp/components/hackathons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/homepage_components/addHack.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id;
  Future<List<Hackathon>> getHacks() async {
    await getUser();
    int end=0;
    int i=1;
    List<Hackathon> hacks = [];
    while(end==0){
    Map<String, String> headers = {"authtoken": "vaibhav"};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/events/getevents/$i",
        headers: headers);
    if (response.statusCode == 200) {
      var hackathonsJson = jsonDecode(response.body);
      if(hackathonsJson['documents'].length!=0){
      for (var u in hackathonsJson['documents']) {
        Hackathon hack = Hackathon(
            description: u['description'],
            location: u['location'],
            end: u['endDate'],
            start: u['startDate'],
            url: u['eventUrl'],
            name: u['nameOfEvent'],
            id: u['_id'],
            min: u["minimumTeamSize"],
            max: u["maximumTeamSize"],
            image: u["eventImage"],
            creatorID: u['creatorId']
        );
        print(hack.id);
        hacks.add(hack);
      }
      i++;
      print(i);
    }
      else{
        end=1;
      }
    }
  }
    return hacks;
  }
  Future getUser() async{
    Map<String, String> headers = {"authtoken": "vaibhav"};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/users/getuserprofile",
        headers: headers);
    if (response.statusCode == 200) {
      var usersJson = jsonDecode(response.body);
      id=usersJson['_id'];}
     print(id);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddHack()));
      },child: Icon(Icons.add,color: kConstantBlueColor,size: 32,),backgroundColor: Colors.white,),
      body: SafeArea(
        child: Column(
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
                      'Hacks',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Muli'
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image(image: AssetImage('images/stc.png'),fit: BoxFit.contain,height: SizeConfig.safeBlockVertical*3.15,),
                )
              ],
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: FutureBuilder(
                  future: getHacks(),
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
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(16, 15, 16, 8),
                            child: GestureDetector(
                              onTap: (){
                                if(snapshot.data[index].creatorID==id){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminDetailsPage(hackathon: snapshot.data[index],)));
                                }
                                else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HackDetails(hackathon: snapshot.data[index],)));
                                }
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12,16,16,0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 35),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 12, 14, 4),
                                        child: AutoSizeText(
                                          snapshot.data[index].description,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14),
                                          maxLines: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                height: 240,
                                decoration: BoxDecoration(
                                  color: kConstantBlueColor,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30),
                                      topLeft: Radius.circular(30)),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Container(
//child: Padding(
//padding: const EdgeInsets.all(8.0),
//child: Text(
//hackathons[index],
//style: TextStyle(color: Colors.white),
//),
//),
//height: 190,
//decoration: BoxDecoration(
//color: Color(0xff98C1D9),
//borderRadius: BorderRadius.only(
//bottomRight: Radius.circular(30),
//topLeft: Radius.circular(30)),
//),
//),
