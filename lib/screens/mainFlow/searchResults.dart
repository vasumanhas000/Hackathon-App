import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hackapp/components/userSearch.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/invites/userDetails.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hackapp/components/sizeConfig.dart';

class ResultsPage extends StatefulWidget {
  final List list;
  ResultsPage({@required this.list});
  @override
  _ResultsPageState createState() => _ResultsPageState(this.list);
}

class _ResultsPageState extends State<ResultsPage> {
  List list;
  _ResultsPageState(this.list);

  Future getList(List list) async {

    Map<String, String> headers1 = {"authtoken": "vaibhav"};
    var response1 = await http.get(
        "https://hackportal.azurewebsites.net/users/getuserprofile",
        headers: headers1);
    var user=jsonDecode(response1.body);
    if(response1.statusCode==200){
    if (list.length == 0) {
      Map<String, String> headers = {"authtoken": "vaibhav"};
      var response = await http.get(
          "https://hackportal.azurewebsites.net/users/getuserprofiles/1",
          headers: headers);
      List<UserSearch> result = [];
      if (response.statusCode == 200) {
        var resultsJson = jsonDecode(response.body);
        for (var i in resultsJson["documents"]) {
          if(i['_id']!=user['_id']){
          UserSearch user = UserSearch(
            name: i["name"],
            email: i["email"],
            id: i["_id"],
            year: i["expectedGraduation"],
            college: i["college"],
            bio: i["bio"],
            github: i["githubLink"],
            stack: i["stackOverflowLink"],
            link: i["externalLink"],
            skills: i["skills"],
          );
          result.add(user);
        }}
      }
      return result;
    }
    if (list.length != 0) {
      Map<String, String> headers = {
        "authtoken": "vaibhav",
        "Content-Type": "application/json",
      };
      List<UserSearch> result = [];
      var response = await http.post(
          "https://hackportal.herokuapp.com/users/searchuserprofiles/1",
          headers: headers,
          body: jsonEncode({
            "skills": list,
          }));
      if (response.statusCode == 200) {
        var resultsJson = jsonDecode(response.body);
        for (var i in resultsJson["documents"]) {
          if(i['_id']!=user['_id']){
          UserSearch user = UserSearch(
            name: i["name"],
            email: i["email"],
            id: i["_id"],
            year: i["expectedGraduation"],
            college: i["college"],
            bio: i["bio"],
            github: i["githubLink"],
            stack: i["stackOverflowLink"],
            link: i["externalLink"],
            skills: i["skills"],
          );
          result.add(user);
        }}
      }
      return result;
    }}
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16,24,16,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search Results',
                    style: TextStyle(fontSize: 26, fontFamily: 'Muli'),
                  ),
                  Image(image: AssetImage('images/stc.png'),height: SizeConfig.blockSizeVertical*3.15,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: FutureBuilder(
                  future: getList(list),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Container(
                          child: SpinKitFoldingCube(
                            size: 50,
                            color: kConstantBlueColor,
                          ),
                        ),
                      );
                    } else if (snapshot.data.length == 0) {
                      return Center(
                        child: Container(
                          child: Text('No user found'),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index1) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails(user: snapshot.data[index1],)));
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
                                            snapshot.data[index1].name,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 30),
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(26,16,0,0),
                                          child: AutoSizeText(snapshot.data[index1].bio,style: TextStyle(color: Colors.white,fontSize: 16),maxLines: 5,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
