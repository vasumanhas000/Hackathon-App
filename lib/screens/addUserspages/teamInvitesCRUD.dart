import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
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
  @override
  Widget build(BuildContext context) {
    print(user);
    return Scaffold(
      body: SafeArea(child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) =>
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                    image: AssetImage('images/Top-Rectangle.png')),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,7,8,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back,color: kConstantBlueColor,size: 38,), onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TeamInvites(id:id)));
                      }),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(14, 26, 0, 0),
                          child: Text(user['name'],
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
    );
  }
}
