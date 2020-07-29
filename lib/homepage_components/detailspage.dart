import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackapp/constants.dart';
import 'teamcreate.dart';
import 'package:hackapp/components/hackathons.dart';
import 'package:url_launcher/url_launcher.dart';

class HackDetails extends StatefulWidget {
  final String hackID;
  HackDetails({this.hackID});
  @override
  _HackDetailsState createState() =>
      _HackDetailsState( this.hackID);
}

class _HackDetailsState extends State<HackDetails> {
  _HackDetailsState(this.id);
  String id;
  var _byteImage;
  String Token;
  final auth = FirebaseAuth.instance;
  Future getHackathon() async {
    FirebaseUser user = await auth.currentUser();
    Token = await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {"authtoken": Token};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/events/geteventinfo/$id",
        headers: headers);
    var hackathonsJson = jsonDecode(response.body);
    Hackathon hack = Hackathon(
        description: hackathonsJson['description'],
        location: hackathonsJson['location'],
        end: hackathonsJson['endDate'],
        start: hackathonsJson['startDate'],
        url: hackathonsJson['eventUrl'],
        name: hackathonsJson['nameOfEvent'],
        id: hackathonsJson['_id'],
        min: hackathonsJson["minimumTeamSize"],
        max: hackathonsJson["maximumTeamSize"],
        image: hackathonsJson["eventImage"],
        creatorID: hackathonsJson['creatorId']);
    var arr = hack.image.split(',');
    print(arr.length);
    _byteImage = Base64Decoder().convert(arr[1]);
    return hack;
  }
  void _moveToSignInScreen(BuildContext context) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => FlowPage(
                currentIndex: 0,
              )));
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        _moveToSignInScreen(context);
      },
      child: Scaffold(
        backgroundColor: Color(0xff3d5a80),
        body: SafeArea(
          child: FutureBuilder(
              future: getHackathon(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Container(
                      child: SpinKitFoldingCube(
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              snapshot.data.name,
                              style: TextStyle(
                                  fontFamily: 'Muli',
                                  fontSize: 34,
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                snapshot.data.location,
                                style: TextStyle(
                                    fontFamily: 'Muli',
                                    fontSize: 24,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                snapshot.data.start + '-' + snapshot.data.end,
                                style: TextStyle(
                                    fontFamily: 'Muli',
                                    fontSize: 22,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 32, 0, 16),
                            child: SizedBox(
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.memory(_byteImage)),
                              height: SizeConfig.safeBlockVertical * 16,
                              width: SizeConfig.blockSizeHorizontal * 140,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              snapshot.data.description,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              'Link:',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              launch(snapshot.data.url);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                snapshot.data.url,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 48, 8, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ButtonTheme(
                                  height: 38,
                                  minWidth: 100,
                                  child: FlatButton(
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CreateTeam(
                                              id: snapshot.data.id,
                                            ),
                                          ));
                                      Scaffold.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(SnackBar(
                                          content: Text(
                                            "$result",
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: kConstantBlueColor),
                                          ),
                                          backgroundColor: result != null
                                              ? Colors.white
                                              : kConstantBlueColor,
                                        ));
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      'Create Team',
                                      style: TextStyle(
                                          color: kConstantBlueColor,
                                          fontFamily: 'Montserrat',
                                          fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
