import 'dart:convert';
import 'package:hackapp/components/sizeConfig.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackapp/constants.dart';
import 'teamcreate.dart';
import 'package:hackapp/components/hackathons.dart';
import 'package:url_launcher/url_launcher.dart';

class HackDetails extends StatefulWidget {
  final Hackathon hackathon;
  HackDetails({this.hackathon});
  @override
  _HackDetailsState createState() => _HackDetailsState(this.hackathon);
}

class _HackDetailsState extends State<HackDetails> {
  _HackDetailsState(this.hackathon);
  Hackathon hackathon;
  var _byteImage;

  void convertImage()async{
    ByteData bytes = await rootBundle.load('images/stc.png');
    var buffer = bytes.buffer;
    var m = base64.encode(Uint8List.view(buffer));
    print(m);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var arr= hackathon.image.split(',');
    print(arr.length);
    _byteImage=Base64Decoder().convert(arr[1]);
    convertImage();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff3d5a80),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    hackathon.name,
                    style: TextStyle(
                        fontFamily: 'Muli', fontSize: 34, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      hackathon.location,
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
                      hackathon.start + '-' + hackathon.end,
                      style: TextStyle(
                          fontFamily: 'Muli',
                          fontSize: 22,
                          color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,32,0,16),
                  child: SizedBox(child: FittedBox(fit:BoxFit.fill,child: Image.memory(_byteImage)),height: SizeConfig.safeBlockVertical*16,width: SizeConfig.blockSizeHorizontal*140,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    hackathon.description,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Link:',
                    style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launch(hackathon.url);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      hackathon.url,
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
                                    id: hackathon.id,
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          child: Text('Create Team',style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 16),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
