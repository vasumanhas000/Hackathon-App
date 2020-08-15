import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/loginFlow/loginFormPages/form1.dart';

class Form0 extends StatefulWidget {
  Form0();
  @override
  _Form0State createState() => _Form0State();
}

class _Form0State extends State<Form0> {
String name='',college='',year='';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder:(BuildContext context, int index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'Heading',
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 30),
                    child: Container(
                      child: Text(
                        'Complete your profile',
                        style: TextStyle(fontFamily: 'Muli', fontSize: 30,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              Hero(
                tag: 'Icons',
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/1unfilled.png'),
                        height: 45,
                      ),
                      Image(
                        image: AssetImage('images/blueLine.png'),
                        color: Colors.white,
                      ),
                      Image(
                        image: AssetImage('images/2unfilled.png'),
                        height: 45,
                      ),
                      Image(
                        image: AssetImage('images/blueLine.png'),
                        color: Colors.white,
                      ),
                      Image(
                        image: AssetImage('images/3unfilled.png'),
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 30),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Personal',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Name :',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                 style: TextStyle(
                    color: kConstantBlueColor,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  ),
                  onChanged: (val){
                    setState(() {
                      name=val;
                    });
                  },
                  decoration: kTextFieldDecoration,
                ),
              ),
//              Container(
//                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
//                child: Text(
//                  'Contact Number:',
//                  style: TextStyle(color: Colors.black, fontSize: 18),
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                child: TextField(
//                  decoration: kTextFieldDecoration,
//                ),
//              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'University Name :',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(
                    color: kConstantBlueColor,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  ),
                  onChanged: (val){
                    setState(() {
                      college=val;
                    });
                  },
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Year of Graduation :',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(
                    color: kConstantBlueColor,
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  ),
                  keyboardType: TextInputType.datetime,
                  onChanged: (val){
                    year=val;
                  },
                  decoration: kTextFieldDecoration,
                ),
              ),
              Hero(
                tag: 'BottomIcon',
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 24, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       GestureDetector(
                         onTap: () async{
                           if(name==''||college==''||year==''){
                             final snackBar = SnackBar(
                               content: Text(
                                 'All fields are mandatory.',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                               ),
                               backgroundColor:kConstantBlueColor ,
                             );
                             await Scaffold.of(context).showSnackBar(snackBar);
                             print('empty');
                           }
                           else{
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Form1(name: name,year: year,college: college,)));
                           }
                           },
                         child: Container(
                           height: 50,
                           width: 50,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(40),
                             color: kConstantBlueColor,
                           ),
                           child: Icon(Icons.arrow_forward,color: Colors.white,size: 28,),
                         ),
                       ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
          );
          }
        ),
      ),
    );
  }
}
