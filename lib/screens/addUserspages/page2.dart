import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/sizeConfig.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 120, 0),
            child: Container(
              child: Text(
                'Send Email Invite',
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Container(
                  child: TextField(
                    decoration: kTextFieldDecoration,
                  ),
                  width: SizeConfig.blockSizeHorizontal * 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 42,
                      color: kConstantBlueColor,
                    ),
                    onPressed: null),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,105,0),
            child: Container(
              child: Text('View Applications',style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Muli',
                  fontWeight: FontWeight.w600),),
            ),
          ),
        ],
      ),
    );
  }
}
