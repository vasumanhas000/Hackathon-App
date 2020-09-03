import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/newHacks.dart';
import 'package:hackapp/screens/teamsPages/createTeam.dart';

class SelectHack extends StatefulWidget {
  final String uid;
  SelectHack({this.uid});
  @override
  _SelectHackState createState() => _SelectHackState();
}

class _SelectHackState extends State<SelectHack> {
  List<dynamic> listItemsGetter(Hackathons hackData) {
    List<dynamic> list = [];
    hackData.hacks.forEach((value) {
      list.add(value);
    });
    return list;
  }

  final auth = FirebaseAuth.instance;
  String Token;
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  Future<Hackathons> sendUsersDataRequest(int page) async {
    Dio _dio = Dio();
    FirebaseUser user = await auth.currentUser();
    Token = await user.getIdToken(refresh: true).then((result) {
      String token = result.token;
      print(token);
      return token;
    });
    try {
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authtoken"] = "$Token";
//        Map<String, String> headers = {"authtoken": Token};
      String url = Uri.encodeFull(
          '$kBaseUrl/events/getevents/$page');
      Response response = await _dio.get(url);
      print(response);
      return Hackathons.fromResponse(response);
    } catch (e) {
      if (e is IOException) {
        return Hackathons.withError('Please check your internet connection.');
      } else {
        print(e.toString());
        return Hackathons.withError('Something went wrong.');
      }
    }
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 100.0,
      child: SpinKitFoldingCube(
        color: kConstantBlueColor,
      ),
    );
  }

  String selectedId;
  Widget listItemBuilder(value, int index) {
    if (widget.uid == value['creatorId']) {
      return SizedBox(height: 0,width: 0,);
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 15, 16, 8),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Radio(
                      value: value['_id'],
                      groupValue: selectedId,
                      onChanged: (val) {
                        setState(() {
                          selectedId = val;
                        });
                      }),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      value['nameOfEvent'],
                      style: TextStyle(color: kConstantBlueColor, fontSize: 26),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget errorWidgetMaker(Hackathons hackData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(hackData.errorMessage),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text('Retry'),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(Hackathons hackData) {
    return Center(
      child: Text('No hackathons found'),
    );
  }

  int totalPagesGetter(Hackathons hackData) {
    return hackData.total;
  }

  bool pageErrorChecker(Hackathons hackData) {
    return hackData.statusCode != 200;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: 'Heading',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Create Your Team',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Muli'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image(
                    image: AssetImage('images/stc.png'),
                    fit: BoxFit.contain,
                    height: SizeConfig.safeBlockVertical * 3.15,
                    color: kConstantBlueColor,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Hero(
            tag: 'Icons',
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image(
                  image: AssetImage('images/1unfilled.png'),
                  height: 45,
                ),
                Image(
                  image: AssetImage('images/blueLine.png'),
                  color: Colors.white,
                ),
                Image(
                  image: AssetImage('images/2unfilled.png'),
                  height: 45,
                ),
              ]),
            ),
          ),
          Expanded(
            child: Paginator.listView(
              key: paginatorGlobalKey,
              pageLoadFuture: sendUsersDataRequest,
              pageItemsGetter: listItemsGetter,
              listItemBuilder: listItemBuilder,
              loadingWidgetBuilder: loadingWidgetMaker,
              errorWidgetBuilder: errorWidgetMaker,
              emptyListWidgetBuilder: emptyListWidgetMaker,
              totalItemsGetter: totalPagesGetter,
              pageErrorChecker: pageErrorChecker,
              scrollPhysics: BouncingScrollPhysics(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 32, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 100,
                  height: 38,
                  child: FlatButton(
                    onPressed:selectedId==null||selectedId==''?(){}: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TeamCreate(id: selectedId)));
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat'),
                    ),
                    color: kConstantBlueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
