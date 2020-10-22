import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/components/hackathons.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/homepage_components/adminDetailsPage.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hackapp/screens/mainFlow/flow.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditHack extends StatefulWidget {
  final Hackathon hackathon;
  EditHack({this.hackathon});
  @override
  _EditHackState createState() => _EditHackState(this.hackathon);
}

class _EditHackState extends State<EditHack> {
  String getUrl(String url) {
    String webpage = url;
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      webpage = "http://" + url;
    }
    return webpage.trim();
  }

  final _auth = FirebaseAuth.instance;
  String Token;
  _EditHackState(this.hackathon);
  Hackathon hackathon;
  File file1;
  String base64img;
  Future editHack(
      String name,
      String image,
      String start,
      String end,
      String venue,
      String bio,
      String link,
      int max,
      int min,
      String id) async {
    FirebaseUser user = await _auth.currentUser();
    Token = await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authtoken": Token,
    };
    String url = '$kBaseUrl/events/updateevent/$id';
    var response = await http.patch(url,
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

  void _moveToSignInScreen(BuildContext context) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => AdminDetailsPage(
                hackId: hackathon.id,
              )));
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  bool _isInAsyncCall = false;
  var _byteImage;
  TextEditingController name,
      start,
      end,
      min,
      max,
      venue,
      bio,
      link,
      startingDate,
      endingDate;
  DateTime selectedDate = DateTime.now();
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

  void initState() {
    // TODO: implement initState
    super.initState();
    var arr = hackathon.image.split(',');
    print(arr.length);
    _byteImage = Base64Decoder().convert(arr[1]);
    name = TextEditingController(text: hackathon.name);
    startingDate = TextEditingController(text: hackathon.start);
    endingDate = TextEditingController(text: hackathon.end);
    start = TextEditingController(
        text: DateTime.parse(hackathon.start).toLocal().toString());
    end = TextEditingController(
        text: DateTime.parse(hackathon.end).toLocal().toString());
    min = TextEditingController(text: hackathon.min.toString());
    max = TextEditingController(text: hackathon.max.toString());
    venue = TextEditingController(text: hackathon.location);
    bio = TextEditingController(text: hackathon.description);
    link = TextEditingController(text: hackathon.url);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    start.dispose();
    end.dispose();
    startingDate.dispose();
    endingDate.dispose();
    min.dispose();
    max.dispose();
    venue.dispose();
    bio.dispose();
    link.dispose();
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
        child: ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          opacity: 0.5,
          progressIndicator: SpinKitFoldingCube(color: kConstantBlueColor),
          child: Scaffold(
              body: SafeArea(
                  child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Edit Hack',
                          style: TextStyle(
                              fontSize: 30,
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
                    'Hackathon Name :',
                    style: kHeadingTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: kTextFieldDecoration,
                    controller: name,
                    style: kFieldTextStyle,
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
                  onTap: getImage,
                  child: file1 == null
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: SizedBox(
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.memory(_byteImage)),
                            height: SizeConfig.safeBlockVertical * 16,
                            width: SizeConfig.blockSizeHorizontal * 140,
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
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Start Date :',
                    style: kHeadingTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context, start, startingDate);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                          keyboardType: TextInputType.datetime,
                          decoration: kTextFieldDecoration,
                          controller: start,
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
                      _selectDate(context, end, endingDate);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        keyboardType: TextInputType.datetime,
                        decoration: kTextFieldDecoration,
                        controller: end,
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
                    controller: min,
                    style: kFieldTextStyle,
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
                    controller: max,
                    style: kFieldTextStyle,
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
                    controller: venue,
                    style: kFieldTextStyle,
                    decoration: kTextFieldDecoration,
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: bio,
                    style: kFieldTextStyle,
                    decoration: kBigTextFieldDecoration,
                    maxLines: 7,
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
                    controller: link,
                    style: kFieldTextStyle,
                    decoration: kTextFieldDecoration,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 24, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: ButtonTheme(
                          height: 38,
                          minWidth: 100,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminDetailsPage(
                                            hackId: hackathon.id,
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(
                                    color: kConstantBlueColor, width: 2)),
                          ),
                        ),
                      ),
                      ButtonTheme(
                        height: 38,
                        minWidth: 100,
                        child: FlatButton(
                          onPressed: () async {
                            if (name.text == '' ||
                                venue.text == '' ||
                                bio.text == '' ||
                                link.text == '' ||
                                min.text == '' ||
                                max.text == '') {
                              final snackBar = SnackBar(
                                content: Text(
                                  'All fields are mandatory',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat'),
                                ),
                                backgroundColor: kConstantBlueColor,
                              );
                              await Scaffold.of(context).showSnackBar(snackBar);
                            } else {
                              if (int.parse(min.text) > int.parse(max.text)) {
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
                                if (file1 == null) {
                                  if (await editHack(
                                          name.text,
                                          hackathon.image,
                                          startingDate.text,
                                          endingDate.text,
                                          venue.text,
                                          bio.text,
                                          link.text,
                                          int.parse(max.text),
                                          int.parse(min.text),
                                          hackathon.id) ==
                                      200) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminDetailsPage(
                                                  hackId: hackathon.id,
                                                )));
                                    _isInAsyncCall = false;
                                  } else {
                                    _isInAsyncCall = false;
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
                                } else {
                                  if (await editHack(
                                          name.text,
                                          base64img,
                                          startingDate.text,
                                          endingDate.text,
                                          venue.text,
                                          bio.text,
                                          getUrl(link.text),
                                          int.parse(max.text),
                                          int.parse(min.text),
                                          hackathon.id) ==
                                      200) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FlowPage(
                                                  currentIndex: 0,
                                                )));
                                    _isInAsyncCall = false;
                                  } else {
                                    _isInAsyncCall = false;
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))),
        ),
      ),
    );
  }
}
