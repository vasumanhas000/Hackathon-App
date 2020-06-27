import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';

class EditUser extends StatefulWidget {
  final User user;
  EditUser({@required this.user});
  @override
  _EditUserState createState() => _EditUserState(this.user);
}

class _EditUserState extends State<EditUser> {
  _EditUserState(this.user);
  User user;

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: user.name);
    final email = TextEditingController(text: user.email);
    final university = TextEditingController(text: user.college);
    final bio = TextEditingController(text: user.bio);
    final year = TextEditingController(text: user.year);
    final github = TextEditingController(text: user.github);
    final stack = TextEditingController(text: user.stack);
    final link = TextEditingController(text: user.link);

    _printLatestValue() {
      print("text field: ${name.text}");
    }
    name.addListener(_printLatestValue);
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image(image: AssetImage('images/editRectangle.png')),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,5,8,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back,color: kConstantBlueColor,size: 42,), onPressed: (){
                          Navigator.pop(context);
                        }),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('Save',style: TextStyle(fontSize: 28),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Text(
                  'Name:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                  controller: name,
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Email:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                  controller: email,
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'University Name:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                  controller: university,
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Year of graduation:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                  controller: year,
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Description:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                  maxLines: 6,
                  controller: bio,
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Github:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                  controller: github,
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Stack Overflow:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                  controller: stack,
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Your Website:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 15),
                  controller: link,
                  decoration: kTextFieldDecoration,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
