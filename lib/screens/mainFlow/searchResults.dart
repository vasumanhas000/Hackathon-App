import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hackapp/components/userSearch.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/invites/userDetails.dart';

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
        "https://hackportal.herokuapp.com/users/getuserprofile",
        headers: headers1);
    var user=jsonDecode(response1.body);
    if(response1.statusCode==200){
    if (list.length == 0) {
      Map<String, String> headers = {"authtoken": "vaibhav"};
      var response = await http.get(
          "https://hackportal.herokuapp.com/users/getuserprofiles/1",
          headers: headers);
      List<UserSearch> result = [];
      if (response.statusCode == 200) {
        var resultsJson = jsonDecode(response.body);
        for (var i in resultsJson) {
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
        for (var i in resultsJson) {
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 33,
                          color: kConstantBlueColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Search Results',
                      style: TextStyle(fontSize: 26, fontFamily: 'Muli'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
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
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails(user: snapshot.data[index1],)));
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: kConstantBlueColor,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(30)),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          snapshot.data[index1].name,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 22),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                            itemCount: snapshot
                                                .data[index1].skills.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                Text(
                                              snapshot.data[index1].skills[index] +
                                                  '  ',
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        )
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
