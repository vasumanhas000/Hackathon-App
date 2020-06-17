import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';

class CreateTeam extends StatefulWidget {
  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          _dismissKeyboard(context);
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 300,maxHeight: 2000),
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomPadding: false,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color(0xff3d5a80),
                              size: 28,
                            ),
                            onPressed: (){Navigator.pop(context);}),
                        Container(
                          child: Text(
                            'Create Your Team',
                            style: TextStyle(fontSize: 24,fontFamily: 'Muli',),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 222, 0),
                    child: Text(
                      'Team name:',
                      style: TextStyle(color: Color(0xff293241), fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextField(
                      decoration: kTextFieldDecoration,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 174, 0),
                    child: Text(
                      'Hackathon name:',
                      style: TextStyle(color: Color(0xff293241), fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextField(
                      decoration: kTextFieldDecoration,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 190, 0),
                    child: Text(
                      'Hackathon link:',
                      style: TextStyle(color: Color(0xff293241), fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextField(
                      decoration: kTextFieldDecoration,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 243, 0),
                    child: Text(
                      'Team size:',
                      style: TextStyle(color: Color(0xff293241), fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextField(
                      decoration: kTextFieldDecoration,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 158, 0),
                    child: Text(
                      'Project Description:',
                      style: TextStyle(color: Color(0xff293241), fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextField(
                      maxLines: 6,
                      decoration: kTextFieldDecoration,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
