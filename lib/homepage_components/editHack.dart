import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/components/hackathons.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/homepage_components/adminDetailsPage.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:file_picker/file_picker.dart';

class EditHack extends StatefulWidget {
  final Hackathon hackathon;
  EditHack({this.hackathon});
  @override
  _EditHackState createState() => _EditHackState(this.hackathon);
}

class _EditHackState extends State<EditHack> {
  _EditHackState(this.hackathon);
  Hackathon hackathon;
  File file1;
  String base64img;
  Future getImage() async {
    File file = await FilePicker.getFile(type: FileType.image);
    setState(() {
      file1 = file;
    });
    String fileName = file.path.split('/').last;
    final bytes = File(file.path).readAsBytesSync();
    String type = fileName.split('.')[1];
    String img = base64Encode(bytes);
    base64img = 'data:image/$type;base64,' + img;
  }

  void _moveToSignInScreen(BuildContext context) =>
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminDetailsPage(hackathon: hackathon,)));
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  var _byteImage;
  void initState() {
    // TODO: implement initState
    super.initState();
    var arr= hackathon.image.split(',');
    print(arr.length);
    _byteImage=Base64Decoder().convert(arr[1]);
  }
  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: hackathon.name);
    final start = TextEditingController(text: hackathon.start);
    final end= TextEditingController(text: hackathon.end);
    final min=TextEditingController(text: hackathon.min.toString());
    final max=TextEditingController(text: hackathon.max.toString());
    final venue=TextEditingController(text: hackathon.location);
    final bio=TextEditingController(text: hackathon.description);
    final link=TextEditingController(text: hackathon.url);

    SizeConfig().init(context);
    return GestureDetector(
      onTap: (){
        _dismissKeyboard(context);
      },
      child: WillPopScope(
        onWillPop: (){
          _moveToSignInScreen(context);
        },
        child: Scaffold(
          body: SafeArea(child: ListView.builder(itemCount: 1,itemBuilder: (BuildContext context, int index)=>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Add Hack',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Muli',
                          ),
                        ),
                      ),
                      Image(
                        image: AssetImage('images/stc.png'),
                        fit: BoxFit.contain,
                        height: SizeConfig.safeBlockVertical * 3.15,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                  child: Text(
                    'Hackathon Name :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: kTextFieldDecoration,
                    controller: name,
                    style: TextStyle(
                      color: kConstantBlueColor,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Hackathon Image :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                GestureDetector(
                  onTap: getImage,
                  child: file1==null?Padding(
                    padding: const EdgeInsets.fromLTRB(20,10,20,10),
                    child: SizedBox(child: FittedBox(fit:BoxFit.fill,child: Image.memory(_byteImage)),height: SizeConfig.safeBlockVertical*16,width: SizeConfig.blockSizeHorizontal*140,),
                  ):SizedBox(
                    height: SizeConfig.safeBlockVertical * 16,
                    width: SizeConfig.blockSizeHorizontal * 140,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.file(file1),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Start Date :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    decoration: kTextFieldDecoration,
                    controller: start,
                    style: TextStyle(
                      color: kConstantBlueColor,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'End Date :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: kTextFieldDecoration,
                    controller: end,
                    style: TextStyle(
                      color: kConstantBlueColor,
                      fontFamily: 'Montserrat',
                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Minimum Team Size :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: kTextFieldDecoration,
                    controller: min,
                    style: TextStyle(
                      color: kConstantBlueColor,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Maximum Team Size :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    decoration: kTextFieldDecoration,
                    controller: max,
                    style: TextStyle(
                      color: kConstantBlueColor,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Venue :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: venue,
                    style: TextStyle(
                      color: kConstantBlueColor,
                      fontFamily: 'Montserrat',
                    ),
                    decoration: kTextFieldDecoration,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Description :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: bio,
                    style: TextStyle(
                      color: kConstantBlueColor,
                      fontFamily: 'Montserrat',
                    ),
                    decoration: kTextFieldDecoration,
                    maxLines: 7,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Link to website/registration link :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: link,
                    style: TextStyle(
                      color: kConstantBlueColor,
                      fontFamily: 'Montserrat',
                    ),
                    decoration: kTextFieldDecoration,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,24,24,8),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: RaisedButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminDetailsPage(hackathon: hackathon,)));
                        },child: Text('Cancel',style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat'),),color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color: kConstantBlueColor)),),
                      ),
                      RaisedButton(onPressed: (){},child: Text('Confirm',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),),color: kConstantBlueColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),),
                    ],
                  ),
                ),
              ],
            ),
          ))
        ),
      ),
    );
  }
}
