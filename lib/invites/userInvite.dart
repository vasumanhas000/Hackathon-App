import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/screens/addUserspages/page2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UserInvite extends StatefulWidget {
  final List admin;
  final String email;
  UserInvite({this.admin,this.email});
  @override
  _UserInviteState createState() => _UserInviteState(this.admin,this.email);
}

class _UserInviteState extends State<UserInvite> {
  final _auth = FirebaseAuth.instance;
  String Token;
  String _selectedRadio,email;
  Future sendInvite(String email,String id)async{
    FirebaseUser user1 = await _auth.currentUser();
    Token= await user1.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authtoken": Token
    };
    String url = 'https://hackportal.azurewebsites.net/teams/sendinvite';
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "inviteeEmail":email,
          "teamId":id,
        }));
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }
  _UserInviteState(this.admin,this.email);
  List admin;
  bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          opacity: 0.5,
          progressIndicator: SpinKitFoldingCube(
            color: kConstantBlueColor,
          ),
          child: SafeArea(
            child: ListView.builder(
              itemCount: 1,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index)=>
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Padding(
                         padding: const EdgeInsets.fromLTRB(16,0,6,0),
                         child: FittedBox(child: Text('Send Invite',style: TextStyle(fontFamily: 'Muli',fontSize: 28,fontWeight: FontWeight.w600),maxLines: 1,),fit: BoxFit.contain,),
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(0,15,16,0),
                         child: Image(
                           image: AssetImage('images/vector.png'),
                           height: SizeConfig.safeBlockVertical * 10,
                         ),
                       ),
                     ],
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(20, 30, 8, 0),
                     child: Text('Choose team :',style: TextStyle(fontSize: 22,color: Colors.black),),
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(6,30,0,0),
                     child: ListView.builder(
                       itemCount: admin.length,
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (BuildContext context, int index)=>
                           Row(
                             children: [
                               Radio(value: admin[index]['_id'], groupValue: _selectedRadio, onChanged: (val){
                                 setState(() {
                                   _selectedRadio=val;
                                 });
                               }),
                               FittedBox(fit: BoxFit.contain,child: Text(admin[index]['teamName'],style: TextStyle(fontSize: 19),)),
                             ],
                           ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(0,64,32,0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         ButtonTheme(
                           height: 38,
                           minWidth: 100,
                           child: FlatButton(onPressed: ()async{
                             setState(() {
                               _isInAsyncCall=true;
                             });
                             if(await sendInvite(email, _selectedRadio)==200){
                               setState(() {
                                 _isInAsyncCall=false;
                               });
                               print('success');
                               Navigator.pop(context,'Invite was successfully sent.');
                             }
                             else if(await sendInvite(email, _selectedRadio)==400){
                               setState(() {
                                 _isInAsyncCall=false;
                               });
                               final snackBar = SnackBar(
                                 content: Text(
                                   'User has already been invited to the selected team.',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                                 ),
                                 backgroundColor:kConstantBlueColor ,
                               );
                               await Scaffold.of(context).showSnackBar(snackBar);
                             }
                             else{
                               final snackBar = SnackBar(
                                 content: Text(
                                   'Error.Please try again later.',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                                 ),
                                 backgroundColor:kConstantBlueColor ,
                               );
                               await Scaffold.of(context).showSnackBar(snackBar);
                             }
                           },child: Text('Send',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontSize: 16),),color: kConstantBlueColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),),
                         ),
                       ],
                     ),
                   )
                 ],
               ),
            ),
          ),
        ),
    );
  }
}
