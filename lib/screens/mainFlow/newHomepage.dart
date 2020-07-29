import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/homepage_components/addHack.dart';
import 'package:hackapp/homepage_components/adminDetailsPage.dart';
import 'package:hackapp/homepage_components/detailspage.dart';
import 'package:http/http.dart' as http;
import 'package:hackapp/components/newHacks.dart';
class NewHomePage extends StatefulWidget {
  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }
  List<dynamic> listItemsGetter(Hackathons hackData) {
    List<dynamic> list = [];
    hackData.hacks.forEach((value) {
      list.add(value);
    });
    return list;
  }
  Future getUser() async{
    Map<String, String> headers = {"authtoken": Token};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/users/getuserprofile",
        headers: headers);
    if (response.statusCode == 200) {
      var usersJson = jsonDecode(response.body);
      id=usersJson['_id'];}
    print(id);
  }
  String id;
  Widget listItemBuilder(value, int index) {
    return GestureDetector(
      onTap: (){
        if(value['creatorId']==id){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminDetailsPage(hackId: value['_id'],)));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HackDetails(hackID: value['_id'],)));
        }

      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 15, 16, 8),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14,22,16,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    value['nameOfEvent'],
                    style: TextStyle(
                        color: Colors.white, fontSize: 26),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 14, 4),
                  child: Text(
                    truncateWithEllipsis(285, value['description']),
                    style: TextStyle(
                        color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          height: 220,
          decoration: BoxDecoration(
            color: kConstantBlueColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30)),
          ),
        ),
      ),
    );
  }
  final auth = FirebaseAuth.instance;
  String Token;
  Future<Hackathons> sendUsersDataRequest(int page) async {
    FirebaseUser user = await auth.currentUser();
    Token= await user.getIdToken().then((result) {
      String token = result.token;
      print(token);
      return token;
    });
      try {
        await getUser();
        Map<String, String> headers = {"authtoken": Token};
        String url = Uri.encodeFull(
            'https://hackportal.herokuapp.com/events/getevents/$page');
        http.Response response = await http.get(url,headers:headers);
        print(response);
        return Hackathons.fromResponse(response);
      } catch (e) {
        if (e is IOException) {
          return Hackathons.withError(
              'Please check your internet connection.');
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
      child: SpinKitFoldingCube(color: kConstantBlueColor,),
    );
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
      child: Text('No workers found'),
    );
  }

  int totalPagesGetter(Hackathons hackData) {
    return hackData.total;
  }

  bool pageErrorChecker(Hackathons hackData) {
    return hackData.statusCode != 200;
  }
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddHack()));
      },child: Icon(Icons.add,color: kConstantBlueColor,size: 32,),backgroundColor: Colors.white,),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16,24,16,24),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Hacks',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Muli'
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Image(image: AssetImage('images/stc.png'),fit: BoxFit.contain,height: SizeConfig.safeBlockVertical*3.15,color: kConstantBlueColor,),
              )
            ],
          ),
          Expanded(
            flex: 8,
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
        ],
      ),
    );
  }
}


//Padding(
//padding: const EdgeInsets.only(bottom: 10),
//child: Column(
//children: <Widget>[
//ListTile(
//leading: Icon(Icons.person,color: kConstantBlueColor,),
//title: Text(value['skill'],style: TextStyle(fontFamily: 'Eina',fontWeight: FontWeight.w600,color: kConstantBlueColor),),
//subtitle: Text(value['district'],style: TextStyle(fontFamily: 'Eina'),),
//trailing: GestureDetector(child: Icon(Icons.phone,color: kConstantBlueColor,),onTap: (){
//_launchDialer(value['mobile']);
//},),
//),
//Divider(),
//],
//),
//);