import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackapp/components/sizeConfig.dart';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddHack extends StatefulWidget {
  @override
  _AddHackState createState() => _AddHackState();
}

class _AddHackState extends State<AddHack> {
  bool _isInAsyncCall = false;
  File file1;
  String base64img;
  final _auth = FirebaseAuth.instance;
  String Token;
  Future getImage() async {
    File file = await FilePicker.getFile(type: FileType.image);
    setState(() {
      file1 = file;
    });
    String fileName = file.path.split('/').last;
    final bytes = File(file.path).readAsBytesSync();
    String type = fileName.split('.')[1];
    String img = base64Encode(bytes);
    base64img = 'data:image/$type;base64,' + img;
  }

  Future postHack(String name, String image, String start, String end,
      String venue, String bio, String link, int max, int min) async {
    FirebaseUser user = await _auth.currentUser();
    Token = await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authtoken": Token
    };
    String url = 'https://hackportal.azurewebsites.net/events/setevent';
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "nameOfEvent": name,
          "startDate": start,
          "endDate": end,
          "location": venue,
          "description": bio,
          "minimumTeamSize": min,
          "maximumTeamSize": max,
          "eventImage": image,
          'eventUrl': link,
        }));
    print(response.statusCode);
    return response.statusCode;
  }

  TextEditingController startDate=TextEditingController(), endDate=TextEditingController();
  String name, venue, description, link;
  int min, max;
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  DateTime selectedDate = DateTime.now();
  void _moveToSignInScreen(BuildContext context) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => FlowPage(
                currentIndex: 0,
              )));
  Future<Null> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      List pickedL=  picked.toString().split(' ');
      List pickedList= pickedL[0].toString().split('-');
        controller.value = TextEditingValue(text: pickedList[2] +'/'+ pickedList[1]+ "/" + pickedList[0]);
      });
  }
 String getMonth(int number){
    String month;
    if(number==01){
      setState(() {
        month='January';
      });
    }
    if(number==02){
      setState(() {
        month='February';
      });
    }
    if(number==03){
      setState(() {
        month='March';
      });
    }
    if(number==04){
      setState(() {
        month='April';
      });
    }
    if(number==05){
      setState(() {
        month='May';
      });
    }
    if(number==06){
      setState(() {
        month='June';
      });
    }
    if(number==07){
      setState(() {
        month='July';
      });
    }
    if(number==08){
      setState(() {
        month='August';
      });
    }
    if(number==09){
      setState(() {
        month='September';
      });
    }
    if(number==10){
      setState(() {
        month='October';
      });
    }
    if(number==11){
      setState(() {
        month='November';
      });
    }
    if(number==12){
      setState(() {
        month='December';
      });
    }
    return month;
 }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startDate.dispose();
    endDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        _dismissKeyboard(context);
      },
      child: WillPopScope(
        onWillPop: () {
          _moveToSignInScreen(context);
        },
        child: Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: _isInAsyncCall,
            opacity: 0.5,
            progressIndicator: SpinKitFoldingCube(color: kConstantBlueColor),
            child: SafeArea(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Add Hack',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Image(
                            image: AssetImage('images/stc.png'),
                            fit: BoxFit.contain,
                            height: SizeConfig.safeBlockVertical * 3.15,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Text(
                        'Hackathon name :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: kTextFieldDecoration,
                        style: TextStyle(
                          color: kConstantBlueColor,
                          fontFamily: 'Montserrat',
                        ),
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Hackathon Image :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await getImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: file1 == null
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(41, 50, 65, 0.1)),
                                height: SizeConfig.safeBlockVertical * 16,
                                width: SizeConfig.blockSizeHorizontal * 140,
                                child: Center(
                                  child: Text('Tap to add an Image'),
                                ),
                              )
                            : SizedBox(
                                height: SizeConfig.safeBlockVertical * 16,
                                width: SizeConfig.blockSizeHorizontal * 140,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.file(file1),
                                ),
                              ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Start Date :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context, startDate);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            keyboardType: TextInputType.datetime,
                            decoration: kTextFieldDecoration,
                            controller: startDate,
                            style: TextStyle(
                              color: kConstantBlueColor,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'End Date :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context, endDate);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: endDate,
                            decoration: kTextFieldDecoration,
                            style: TextStyle(
                              color: kConstantBlueColor,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Minimum Team Size :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecoration,
                        style: TextStyle(
                          color: kConstantBlueColor,
                          fontFamily: 'Montserrat',
                        ),
                        onChanged: (value) {
                          min = int.parse(value);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Maximum Team Size :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecoration,
                        style: TextStyle(
                          color: kConstantBlueColor,
                          fontFamily: 'Montserrat',
                        ),
                        onChanged: (value) {
                          max = int.parse(value);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Venue :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        style: TextStyle(
                          color: kConstantBlueColor,
                          fontFamily: 'Montserrat',
                        ),
                        decoration: kTextFieldDecoration,
                        onChanged: (value) {
                          venue = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Description :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        style: TextStyle(
                          color: kConstantBlueColor,
                          fontFamily: 'Montserrat',
                        ),
                        decoration: kTextFieldDecoration,
                        maxLines: 7,
                        onChanged: (value) {
                          description = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Link to website/registration link :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextField(
                        style: TextStyle(
                          color: kConstantBlueColor,
                          fontFamily: 'Montserrat',
                        ),
                        decoration: kTextFieldDecoration,
                        onChanged: (value) {
                          link = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 24, 24, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: ButtonTheme(
                              height: 38,
                              minWidth: 100,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                        color: kConstantBlueColor, width: 2)),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FlowPage(
                                                currentIndex: 0,
                                              )));
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: kConstantBlueColor,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 100,
                            height: 38,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              onPressed: () async {
                                setState(() {
                                  _isInAsyncCall = true;
                                });
                                if (await postHack(
                                        name,
                                        base64img,
                                        startDate.text,
                                        endDate.text,
                                        venue,
                                        description,
                                        link,
                                        max,
                                        min) ==
                                    200) {
                                  setState(() {
                                    _isInAsyncCall = false;
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FlowPage(
                                                currentIndex: 0,
                                              )));
                                }
                                ;
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 16),
                              ),
                              color: kConstantBlueColor,
                            ),
                          ),
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
