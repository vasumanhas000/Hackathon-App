import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';
import 'package:hackapp/components/sizeConfig.dart';

class UserInvite extends StatefulWidget {
  final List admin;
  UserInvite({this.admin});
  @override
  _UserInviteState createState() => _UserInviteState(this.admin);
}

class _UserInviteState extends State<UserInvite> {
  String _selectedRadio;
  _UserInviteState(this.admin);
  List admin;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
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
                             Radio(value: admin[index]['teamName'], groupValue: _selectedRadio, onChanged: (val){
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
                       RaisedButton(onPressed: (){
                         print(_selectedRadio); 
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
