import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MemberView extends StatefulWidget {
  var user;
  final String id;
  MemberView({this.id,this.user});
  @override
  _MemberViewState createState() => _MemberViewState(this.user,this.id);
}

class _MemberViewState extends State<MemberView> {
  bool _isInAsyncCall=false;
  _MemberViewState(this.user,this.id);
  String id;
  var user;
  @override
  Widget build(BuildContext context) {
    print(user);
    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      opacity: 0.5,
      progressIndicator: SpinKitFoldingCube(
        color: kConstantBlueColor,
      ),
      child: Scaffold(
        body: SafeArea(child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) =>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(22, 32, 8, 0),
                    child: FittedBox(child: Text(user['name'],style: TextStyle(fontSize: 32,fontWeight: FontWeight.w600),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 30, 0, 0),
                    child: Text(
                      'Email :',
                      style: TextStyle(color: kConstantBlueColor, fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 5, 8, 0),
                    child: FittedBox(
                      child: Text(
                        user['email'],
                        style: TextStyle(fontSize: 18,),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 25, 0, 0),
                    child: Text(
                      'University Name:',
                      style: TextStyle( fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 5, 8, 0),
                    child: FittedBox(
                      child: Text(
                        user['college'],
                        style: TextStyle(fontSize: 18),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 25, 0, 0),
                    child: Text(
                      'Year of graduation',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 5, 8, 0),
                    child: FittedBox(
                      child: Text(
                        user['expectedGraduation'],
                        style: TextStyle(fontSize: 18),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 25, 8, 0),
                    child: Text(
                      'Description:',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 5, 8, 0),
                    child: Text(
                      user['bio'],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 25, 0, 0),
                    child: Text(
                      'Skills:',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListView.builder(
                      itemCount: user["skills"].length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (user["skills"].length == 0) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Text('No Skills'),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(22, 8, 0, 0),
                            child: Text(
                              user['skills'][index],
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }
                      }),
                ],
              ),
        ),),
      ),
    );
  }
}
