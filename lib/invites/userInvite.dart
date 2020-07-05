import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/screens/addUserspages/page2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInvite extends StatefulWidget {
  final List admin;
  final String email;
  UserInvite({this.admin,this.email});
  @override
  _UserInviteState createState() => _UserInviteState(this.admin,this.email);
}

class _UserInviteState extends State<UserInvite> {
  String _selectedRadio,email;
  Future sendInvite(String email,String id)async{
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authtoken": "vaibhav"
    };
    String url = 'https://hackportal.herokuapp.com/teams/sendinvite';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index)=>
           Padding(
             padding: const EdgeInsets.fromLTRB(10,0,0,0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(
                       children: [
                         IconButton(icon: Icon(Icons.arrow_back,size: 34,color: kConstantBlueColor,), onPressed: (){
                           Navigator.pop(context);
                         }),
                         Padding(
                           padding: const EdgeInsets.only(left: 10),
                           child: Text('Invite',style: TextStyle(fontFamily: 'Muli',fontSize: 24),),
                         ),
                       ],
                     ),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(0,15,5,0),
                       child: Image(
                         image: AssetImage('images/vector.png'),
                         height: SizeConfig.safeBlockVertical * 10,
                       ),
                     ),
                   ],
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top: 30),
                   child: Text('Choose the team you want to invite to:',style: TextStyle(fontSize: 18),),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(60,30,0,0),
                   child: ListView.builder(
                     itemCount: admin.length,
                     shrinkWrap: true,
                     itemBuilder: (BuildContext context, int index)=>
                         Row(
                           children: [
                             Radio(value: admin[index]['_id'], groupValue: _selectedRadio, onChanged: (val){
                               setState(() {
                                 _selectedRadio=val;
                               });
                             }),
                             Container(
                             child:Text(admin[index]['teamName'],style: TextStyle(fontSize: 19),) ,
                             ),
                           ],
                         ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0,50,15,0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       RaisedButton(onPressed: ()async{
                         if(await sendInvite(email, _selectedRadio)==200){
                           print('success');
                           Navigator.pop(context,'Invite was successfully sent.');
                         }
                         else if(await sendInvite(email, _selectedRadio)==400){
                           final snackBar = SnackBar(
                             content: Text(
                               'User has already been invited to the selected team.',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                             ),
                             backgroundColor:Color(0xff98c1d9) ,
                           );
                           await Scaffold.of(context).showSnackBar(snackBar);
                         }
                         else{
                           final snackBar = SnackBar(
                             content: Text(
                               'Error.Please try again later.',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                             ),
                             backgroundColor:Color(0xff98c1d9) ,
                           );
                           await Scaffold.of(context).showSnackBar(snackBar);
                         }
                       },child: Text('Send',style: TextStyle(color: Colors.white),),color: kConstantBlueColor,),
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
