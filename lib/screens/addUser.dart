import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hackapp/components/iconContainer.dart';
import 'package:hackapp/constants.dart';
import 'screen0.dart';
import 'screen1.dart';
import 'screen2.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  int buttonIndex = 1;
  static List<Widget> _selectedScreen = [
    Screen0(),
    Screen1(),
    Screen2(),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: IconContainer(
                      iconData: Icons.add,
                      iconColor: buttonIndex == 0 ? Colors.white : Colors.black,
                      backgroundColor: buttonIndex == 0
                          ? kConstantBlueColor
                          : kConstantBackgroundColor),
                  onTap: () {
                    setState(() {
                      buttonIndex = 0;
                    });
                  },
                ),
                GestureDetector(
                  child: IconContainer(
                    iconData: Icons.assignment_ind,
                    iconColor: buttonIndex == 1 ? Colors.white : Colors.black,
                    backgroundColor: buttonIndex == 1
                        ? kConstantBlueColor
                        : kConstantBackgroundColor,
                  ),
                  onTap: () {
                    setState(() {
                      buttonIndex = 1;
                    });
                  },
                ),
                GestureDetector(
                  child: IconContainer(
                      iconData: Icons.filter_none,
                      iconColor: buttonIndex == 2 ? Colors.white : Colors.black,
                      backgroundColor: buttonIndex == 2
                          ? kConstantBlueColor
                          : kConstantBackgroundColor),
                  onTap: () {
                    setState(
                      () {
                        buttonIndex = 2;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
           child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: _selectedScreen.elementAt(buttonIndex),
          ),
        ),
      ],
    );
  }
}
