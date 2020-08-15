import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/components/hackathons.dart';
import 'package:hackapp/homepage_components/editHack.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hackapp/screens/mainFlow/flow.dart';

class AdminDetailsPage extends StatefulWidget {
  final Hackathon hackathon;
  final String hackId;
  AdminDetailsPage({this.hackathon, this.hackId});
  @override
  _AdminDetailsPageState createState() =>
      _AdminDetailsPageState(this.hackathon, this.hackId);
}

class _AdminDetailsPageState extends State<AdminDetailsPage> {
  String id;
  void _moveToSignInScreen(BuildContext context) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => FlowPage(
                currentIndex: 0,
              )));
  _AdminDetailsPageState(this.hackathon, this.id);
  bool _isInAsyncCall = false;
  Hackathon hackathon;
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

  Future deleteHack() async {
    Map<String, String> headers = {"authtoken": Token};
    var response = await http.delete(
        'https://hackportal.azurewebsites.net/events/deleteevent/$id',
        headers: headers);
    print(response.statusCode);
    return response.statusCode;
  }


  _launchURL(String url) async {
    String webpage ;
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      webpage = "http://" + url;
    }
    if (await canLaunch(webpage)) {
      await launch(webpage);
    } else {
      throw 'Could not launch $webpage';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        _moveToSignInScreen(context);
      },
      child: Scaffold(
        backgroundColor: Color(0xff3d5a80),
        body: ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          opacity: 0.5,
          progressIndicator: SpinKitFoldingCube(
            color: kConstantBlueColor,
          ),
          child: SafeArea(
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
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
                                _launchURL(snapshot.data.url);
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
                              padding: const EdgeInsets.fromLTRB(0, 32, 8, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: ButtonTheme(
                                      height: 38,
                                      minWidth: 100,
                                      child: FlatButton(
                                        onPressed: () async {
                                          setState(() {
                                            _isInAsyncCall = true;
                                          });
                                          if (await deleteHack() == 200) {
                                            setState(() {
                                              _isInAsyncCall = false;
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FlowPage(
                                                          currentIndex: 0,
                                                        )));
                                          }
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat',
                                              fontSize: 16),
                                        ),
                                        color: kConstantBlueColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            side: BorderSide(
                                                color: Colors.white, width: 2)),
                                      ),
                                    ),
                                  ),
                                  ButtonTheme(
                                    height: 38,
                                    minWidth: 100,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditHack(
                                                      hackathon: snapshot.data,
                                                    )));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 4),
                                            child: Text(
                                              'Edit',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 16,
                                                  color: kConstantBlueColor),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 3),
                                            child: Icon(
                                              Icons.edit,
                                              size: 18,
                                              color: kConstantBlueColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
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
      ),
    );
  }
}
