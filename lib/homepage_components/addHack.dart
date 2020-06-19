import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

class AddHack extends StatefulWidget {
  @override
  _AddHackState createState() => _AddHackState();
}

class _AddHackState extends State<AddHack> {
  Future postHack(String name, String start, String end, String venue,
      String description, String link) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authtoken": "test"
    };
    String url = 'https://hackportal.herokuapp.com/hackathons/sethackathon';
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode(<String, String>{
          "nameOfEvent": name,
          "startDate": start,
          "endDate": end,
          "location": venue,
          "description": description,
          "eventUrl": link
        }));
    print(response.statusCode);
    return response.statusCode;
  }

  String name, startDate, endDate, venue, description, link;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: kConstantBlueColor,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Text(
                      'Add your hack here',
                      style: TextStyle(fontSize: 28, fontFamily: 'Muli'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 40, 0, 0),
                child: Text(
                  'Hackathon name:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: kTextFieldDecoration,
                  style: TextStyle(
                    color: Colors.black,
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
                  'Start Date',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  decoration: kTextFieldDecoration,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                  onChanged: (value) {
                    startDate = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'End Date',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  decoration: kTextFieldDecoration,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                  onChanged: (value) {
                    endDate = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Venue',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
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
                  'Description:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
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
                  'Link to website/registration link:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    link = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                        color: Colors.white,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (await postHack(name, startDate, endDate, venue,
                                description, link) ==
                            201) {
                          final snackBar = SnackBar(
                            content: Text(
                              'Hackathon has been added',
                            ),
                            action:
                                SnackBarAction(label: 'OK', onPressed: () {
                                  Navigator.pop(context);
                                },textColor: Colors.purple,),
                          );
                       await Scaffold.of(context).showSnackBar(snackBar);
                        }
                        else{
                          final snackBar = SnackBar(
                            content: Text(
                              'Error.Please try again later',
                            ),
                            action:
                            SnackBarAction(label: 'Ok', onPressed: () {}),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: kConstantBlueColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
