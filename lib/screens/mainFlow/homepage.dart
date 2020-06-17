import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/homepage_components/detailspage.dart';
import 'package:hackapp/components/hackathons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Hackathon>> getHacks() async {
    var response = await http.get(
        "https://hackportal.herokuapp.com/hackathons/gethackathon?authtoken=test");
    List<Hackathon> hacks = [];
    if (response.statusCode == 200) {
      var hackathonsJson = jsonDecode(response.body);
      for (var u in hackathonsJson) {
        Hackathon hack = Hackathon(
            description: u['description'],
            location: u['location'],
            end: u['endDate'],
            start: u['startDate'],
            url: u['eventUrl'],
            name: u['nameOfEvent']);
        hacks.add(hack);
      }
    }
    return (hacks);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 50, 15),
            child: Container(
              child: Text(
                'Hacks happening around you',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
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
                        padding: EdgeInsets.fromLTRB(13, 15, 13, 5),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15,10,0,0),
                                child: Text(
                                  snapshot.data[index].name,
                                  style: TextStyle(color: Colors.white,fontSize: SizeConfig.blockSizeHorizontal*9),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15,14,0,0),
                                child: Text(
                                  snapshot.data[index].description,
                                  style: TextStyle(color: Colors.white,fontSize: SizeConfig.blockSizeHorizontal*4.25),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){ Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HackDetails(hackathon: snapshot.data[index],),
                                    ));},
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(15,14,0,0),
                                  child: Text(
                                    'Learn More',
                                    style: TextStyle(color: Colors.white,fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          height: SizeConfig.blockSizeVertical*25,
                          decoration: BoxDecoration(
                            color: Color(0xff98C1D9),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
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
