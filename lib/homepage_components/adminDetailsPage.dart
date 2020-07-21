import 'dart:convert';
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
  AdminDetailsPage({this.hackathon});
  @override
  _AdminDetailsPageState createState() => _AdminDetailsPageState(this.hackathon);
}

class _AdminDetailsPageState extends State<AdminDetailsPage> {
  void _moveToSignInScreen(BuildContext context) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => FlowPage(
            currentIndex: 0,
          )));
   Future deleteHack(String id)async{
     Map<String, String> headers = {"authtoken": "vaibhav"};
     var response = await http.delete(
         'https://hackportal.azurewebsites.net/events/deleteevent/$id',
         headers: headers);
     print(response.statusCode);
     return response.statusCode;
   }
  _AdminDetailsPageState(this.hackathon);
  bool _isInAsyncCall = false;
  Hackathon hackathon;
  var _byteImage;
  void initState() {
    // TODO: implement initState
    super.initState();
    var arr= hackathon.image.split(',');
    print(arr.length);
    _byteImage=Base64Decoder().convert(arr[1]);
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
                      padding: const EdgeInsets.fromLTRB(0, 32, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: RaisedButton(onPressed: ()async{
                              setState(() {
                                _isInAsyncCall=true;
                              });
                             if(await deleteHack(hackathon.id)==200){
                               setState(() {
                                 _isInAsyncCall=false;
                               });
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FlowPage(currentIndex: 0,)));
                             }
                            },child: Text('Delete',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),),color: kConstantBlueColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color: Colors.white)),),
                          ),
                          RaisedButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditHack(hackathon: hackathon,)));
                          },child: Text('Edit',style: TextStyle(fontFamily: 'Montserrat'),),color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
