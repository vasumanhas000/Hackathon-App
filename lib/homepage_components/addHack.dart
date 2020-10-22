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
    String url = '$kBaseUrl/events/setevent';
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
    print(response.body);
    return response.statusCode;
  }

  TextEditingController startDate = TextEditingController(),
      endDate = TextEditingController();
  String name = '', venue = '', description = '', link = '';
  int min, max;
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String getUrl(String url) {
    String webpage = url;
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      webpage = "http://" + url;
    }
    return webpage.trim();
  }

  DateTime selectedDate = DateTime.now();
  void _moveToSignInScreen(BuildContext context) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => FlowPage(
                currentIndex: 0,
              )));
  TextEditingController startingDate = TextEditingController();
  TextEditingController endingDate = TextEditingController();
  Future<Null> _selectDate(BuildContext context,
      TextEditingController controller, TextEditingController typeDate) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    String date = pickedDate.toString().split(" ")[0] +
        " " +
        pickedTime.format(context).toString() +
        ":00.000";
    controller.value = TextEditingValue(
        text: pickedDate.toString().split(" ")[0] +
            " " +
            pickedTime.format(context).toString());
    typeDate.value =
        TextEditingValue(text: DateTime.parse(date).toUtc().toIso8601String());
  }

  String getMonth(int number) {
    String month;
    if (number == 01) {
      setState(() {
        month = 'January';
      });
    }
    if (number == 02) {
      setState(() {
        month = 'February';
      });
    }
    if (number == 03) {
      setState(() {
        month = 'March';
      });
    }
    if (number == 04) {
      setState(() {
        month = 'April';
      });
    }
    if (number == 05) {
      setState(() {
        month = 'May';
      });
    }
    if (number == 06) {
      setState(() {
        month = 'June';
      });
    }
    if (number == 07) {
      setState(() {
        month = 'July';
      });
    }
    if (number == 08) {
      setState(() {
        month = 'August';
      });
    }
    if (number == 09) {
      setState(() {
        month = 'September';
      });
    }
    if (number == 10) {
      setState(() {
        month = 'October';
      });
    }
    if (number == 11) {
      setState(() {
        month = 'November';
      });
    }
    if (number == 12) {
      setState(() {
        month = 'December';
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
    startingDate.dispose();
    endingDate.dispose();
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
                                  fontSize: 30,
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Image(
                            image: AssetImage('images/stc.png'),
                            color: kConstantBlueColor,
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
                        style: kHeadingTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: kTextFieldDecoration,
                        style: kFieldTextStyle,
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Hackathon Image :',
                        style: kHeadingTextStyle,
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
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                    border: Border(
                                        top: BorderSide(
                                          color: kConstantBlueColor,
                                          width: 0.5,
                                        ),
                                        bottom: BorderSide(
                                          color: kConstantBlueColor,
                                          width: 0.5,
                                        ),
                                        right: BorderSide(
                                          color: kConstantBlueColor,
                                          width: 0.5,
                                        ),
                                        left: BorderSide(
                                          color: kConstantBlueColor,
                                          width: 0.5,
                                        ))),
                                height: SizeConfig.safeBlockVertical * 16,
                                width: SizeConfig.blockSizeHorizontal * 140,
                                child: Center(
                                  child: Text(
                                    'Tap to add an Image',
                                    style: TextStyle(color: Color(0xff9499A0)),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: SizeConfig.safeBlockVertical * 16,
                                width: SizeConfig.blockSizeHorizontal * 140,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Image.file(file1),
                                ),
                              ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text('Start Date :', style: kHeadingTextStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context, startDate, startingDate);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                              keyboardType: TextInputType.datetime,
                              decoration: kTextFieldDecoration,
                              controller: startDate,
                              style: kFieldTextStyle),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'End Date :',
                        style: kHeadingTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context, endDate, endingDate);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: endDate,
                            decoration: kTextFieldDecoration,
                            style: kFieldTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Minimum Team Size :',
                        style: kHeadingTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecoration,
                        style: kFieldTextStyle,
                        onChanged: (value) {
                          min = int.parse(value);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Maximum Team Size :',
                        style: kHeadingTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecoration,
                        style: kFieldTextStyle,
                        onChanged: (value) {
                          max = int.parse(value);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        'Venue :',
                        style: kHeadingTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: TextField(
                        style: kFieldTextStyle,
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
                        style: kHeadingTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: TextField(
                        style: kFieldTextStyle,
                        decoration: kBigTextFieldDecoration,
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
                        style: kHeadingTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: TextField(
                        style: kFieldTextStyle,
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
                                print(startingDate.text);
                                print(endingDate.text);
                                if (name == '' ||
                                    venue == '' ||
                                    description == '' ||
                                    link == '' ||
                                    min == null ||
                                    max == null) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'All fields are mandatory',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    backgroundColor: kConstantBlueColor,
                                  );
                                  await Scaffold.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  if (min > max) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'Minimum team size cannot be greater than Maximum team size',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat'),
                                      ),
                                      backgroundColor: kConstantBlueColor,
                                    );
                                    await Scaffold.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    setState(() {
                                      _isInAsyncCall = true;
                                    });
                                    if (await postHack(
                                            name,
                                            base64img,
                                            startingDate.text,
                                            endingDate.text,
                                            venue,
                                            description,
                                            getUrl(link),
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
                                    } else {
                                      setState(() {
                                        _isInAsyncCall = false;
                                      });
                                      final snackBar = SnackBar(
                                        content: Text(
                                          'Error.Please try again later.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat'),
                                        ),
                                        backgroundColor: kConstantBlueColor,
                                      );
                                      await Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }
                                }
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
