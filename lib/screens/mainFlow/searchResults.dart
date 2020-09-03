import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paginator/flutter_paginator.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/invites/userDetails.dart';
import 'package:hackapp/components/sizeConfig.dart';

class ResultsPage extends StatefulWidget {
  final List list;
  ResultsPage({@required this.list});
  @override
  _ResultsPageState createState() => _ResultsPageState(this.list);
}

class _ResultsPageState extends State<ResultsPage> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  List list;
  _ResultsPageState(this.list);
  List<dynamic> listItemsGetter(Users hackData) {
    List<dynamic> list = [];
    hackData.users.forEach((value) {
      list.add(value);
    });
    return list;
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 100.0,
      child: SpinKitFoldingCube(color: kConstantBlueColor,),
    );
  }

  Future<Users> sendUsersDataRequest(int page) async {
    FirebaseUser user = await _auth.currentUser();
    Token= await user.getIdToken().then((result) {
      String token = result.token;
      print(token);
      return token;
    });
    await getUser();
    if(list.length==0){
    try {
      Map<String, String> headers = {"authtoken": Token};
      String url = Uri.encodeFull(
          '$kBaseUrl/users/getuserprofiles/$page');
      http.Response response = await http.get(url,headers:headers);
      print(response);
      return Users.fromResponse(response);
    } catch (e) {
      if (e is IOException) {
        return Users.withError(
            'Please check your internet connection.');
      } else {
        print(e.toString());
        return Users.withError('Something went wrong.');
      }
    }
  }
    if(list.length!=0){
      print(list);
      try {
        Map<String, String> headers = {"authtoken": Token,"Content-Type": "application/json"};
        String url = Uri.encodeFull(
            '$kBaseUrl/users/searchuserprofiles/$page');
        http.Response response = await http.post(url,headers:headers,body: jsonEncode({
          "skills": list,
        }));
        print(response);
        return Users.fromResponse(response);
      } catch (e) {
        if (e is IOException) {
          return Users.withError(
              'Please check your internet connection.');
        } else {
          print(e.toString());
          return Users.withError('Something went wrong.');
        }
      }
    }

  }

  Widget listItemBuilder(value, int index){
    if(value['_id']==userId){
      return SizedBox(height: 0,);
    }
    else{
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails(user: value,)));
        },
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: kConstantBlueColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16,16,8,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    value['name'],
                    style: TextStyle(
                        color: Colors.white, fontSize: 26),
                  ),
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(26,16,0,0),
                  child: Text(truncateWithEllipsis(250, value['bio']),style: TextStyle(color: Colors.white,fontSize: 14),),
                ),
              ],
            ),
          ),
        ),
      ),
    );}
  }

  Widget errorWidgetMaker(Users hackData, retryListener) {
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

  Widget emptyListWidgetMaker(Users hackData) {
    return Center(
      child: Text('No user found'),
    );
  }

  int totalPagesGetter(Users hackData) {
    return hackData.total;
  }

  Future getUser() async{
    Map<String, String> headers = {"authtoken": Token};
    var response = await http.get(
        "https://hackportal.azurewebsites.net/users",
        headers: headers);
    if (response.statusCode == 200) {
      var usersJson = jsonDecode(response.body);
      userId=usersJson['_id'];}
    print(userId);
  }
  String userId;
  bool pageErrorChecker(Users hackData) {
    return hackData.statusCode != 200;
  }
  final _auth = FirebaseAuth.instance;
  String Token;
  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16,24,16,24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search Results',
                        style: TextStyle(fontSize: 26, fontFamily: 'Muli',fontWeight: FontWeight.w600),
                      ),
                      Image(image: AssetImage('images/stc.png'),height: SizeConfig.blockSizeVertical*3.15,)
                    ],
                  ),
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
        ),
    );
  }
}

//Padding(
//padding: const EdgeInsets.only(top: 24),
//child: FutureBuilder(
//future: getList(list),
//builder: (BuildContext context, AsyncSnapshot snapshot) {
//if (snapshot.data == null) {
//return Padding(
//padding: const EdgeInsets.only(top: 300),
//child: Container(
//child: SpinKitFoldingCube(
//size: 50,
//color: kConstantBlueColor,
//),
//),
//);
//} else if (snapshot.data.length == 0) {
//return Center(
//child: Padding(
//padding: const EdgeInsets.only(top: 300),
//child: Container(
//child: Text('No user found'),
//),
//),
//);
//} else {
//return ListView.builder(
//physics: NeverScrollableScrollPhysics(),
//shrinkWrap: true,
//itemCount: snapshot.data.length,
//itemBuilder: (BuildContext context, int index1) {
//return Padding(
//padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//child: GestureDetector(
//onTap: (){
//Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails(user: snapshot.data[index1],)));
//},
//child: Container(
//height: 200,
//decoration: BoxDecoration(
//color: kConstantBlueColor,
//borderRadius: BorderRadius.only(
//bottomRight: Radius.circular(30),
//topLeft: Radius.circular(30)),
//),
//child: Padding(
//padding: const EdgeInsets.fromLTRB(16,16,8,0),
//child: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: [
//FittedBox(
//child: Text(
//snapshot.data[index1].name,
//style: TextStyle(
//color: Colors.white, fontSize: 26),
//),
//fit: BoxFit.contain,
//),
//Padding(
//padding: const EdgeInsets.fromLTRB(26,16,0,0),
//child: Text(truncateWithEllipsis(250, snapshot.data[index1].bio),style: TextStyle(color: Colors.white,fontSize: 14),),
//),
//],
//),
//),
//),
//),
//);
//});
//}
//}),
//),

class Users {
  List<dynamic> users;
  int statusCode;
  String errorMessage;
  int total;
  int nItems;

  Users.fromResponse(http.Response response) {
    this.statusCode = response.statusCode;
    var jsonData = json.decode(response.body);
    print(jsonData);
    users = jsonData['documents'];
    total = jsonData['totalCount'];
    nItems = users.length;
  }
  Users.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}