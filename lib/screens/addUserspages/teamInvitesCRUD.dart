import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/addUserspages/teamDetails.dart';
import 'package:hackapp/screens/addUserspages/teamInvites.dart';

class InviteCRUD extends StatefulWidget {
  var user;
  final String id;
  InviteCRUD({this.user,this.id});
  @override
  _InviteCRUDState createState() => _InviteCRUDState(this.user,this.id);
}

class _InviteCRUDState extends State<InviteCRUD> {
  var user;
  String id;
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
      child: Scaffold(
        body: SafeArea(child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) =>
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'Email:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: FittedBox(
                  child: Text(
                    user['email'],
                    style: TextStyle(fontSize: 21),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'University Name:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: FittedBox(
                  child: Text(
                    user['college'],
                    style: TextStyle(fontSize: 21),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'Year of graduation',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: FittedBox(
                  child: Text(
                    user['expectedGraduation'],
                    style: TextStyle(fontSize: 21),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'Description:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 6, 0),
                child: Text(
                  user['bio'],
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                  'Skills:',
                  style: TextStyle(color: Color(0xff293241), fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
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
                          padding: const EdgeInsets.fromLTRB(60, 5, 0, 0),
                          child: Text(
                            user['skills'][index],
                            style: TextStyle(fontSize: 17),
                          ),
                        );
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,40,13,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(onPressed: (){},child: Text('Cancel Invite',style: TextStyle(color: Colors.white),),color: kConstantBlueColor,)
                  ],
                ),
              ),
            ],
          ),
        ),),
      ),
    );
  }
}
