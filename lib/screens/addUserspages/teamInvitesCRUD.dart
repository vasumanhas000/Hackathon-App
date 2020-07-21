import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/addUserspages/teamDetails.dart';
import 'package:hackapp/screens/addUserspages/teamInvites.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InviteCRUD extends StatefulWidget {
  var user;
  final String id;
  InviteCRUD({this.user,this.id});
  @override
  _InviteCRUDState createState() => _InviteCRUDState(this.user,this.id);
}

class _InviteCRUDState extends State<InviteCRUD> {
  Future cancelInvite(String id,String userID)async{
    Map<String, String> headers = {"authtoken": "vaibhav","Content-Type": "application/json"};
    var response = await http.post(
        "https://hackportal.azurewebsites.net/teams/cancelinvite",
        headers: headers,body: jsonEncode({
      "teamId":id,
      "inviteeId":userID,
    }));
    print(response.statusCode);
    print(response.body);
    return response.statusCode;
  }
  var user;
  String id;
  bool _isInAsyncCall = false;
  _InviteCRUDState(this.user,this.id);
  void _moveToSignInScreen(BuildContext context) =>
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TeamDetails(id: id,)));
  @override
  Widget build(BuildContext context) {
    print(user);
    return WillPopScope(
      onWillPop: (){
        _moveToSignInScreen(context);
      },
      child: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.5,
        progressIndicator: SpinKitFoldingCube(
          color: kConstantBlueColor,
        ),
        child: Scaffold(
          body: SafeArea(child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) =>
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(22, 32, 8, 0),
                  child: FittedBox(child: Text(user['name'],style: TextStyle(fontSize: 32),)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 30, 8, 5),
                  child: Text(
                    'Email:',
                    style: TextStyle(color: kConstantBlueColor, fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 8, 5),
                  child: FittedBox(
                    child: Text(
                      user['email'],
                      style: TextStyle(fontSize: 22),
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 8, 5),
                  child: Text(
                    'University Name:',
                    style: TextStyle( fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 8, 5),
                  child: FittedBox(
                    child: Text(
                      user['college'],
                      style: TextStyle(fontSize: 22),
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 8, 5),
                  child: Text(
                    'Year of graduation',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 8, 5),
                  child: FittedBox(
                    child: Text(
                      user['expectedGraduation'],
                      style: TextStyle(fontSize: 22),
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 8, 5),
                  child: Text(
                    'Description:',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 8, 8),
                  child: Text(
                    user['bio'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 8, 5),
                  child: Text(
                    'Skills:',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                ListView.builder(
                    itemCount: user["skills"].length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (user["skills"].length == 0) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Text('No Skills'),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(22, 3, 0, 5),
                          child: Text(
                            user['skills'][index],
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,32,16,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(onPressed: ()async{
                        setState(() {
                          _isInAsyncCall=true;
                        });
                        if(await cancelInvite(id, user['_id'])==200){
                          setState(() {
                            _isInAsyncCall=false;
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TeamDetails(id: id,)));
                        }
                      },child: Text('Cancel Invite',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),),color: kConstantBlueColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),)
                    ],
                  ),
                ),
              ],
            ),
          ),),
        ),
      ),
    );
  }
}
