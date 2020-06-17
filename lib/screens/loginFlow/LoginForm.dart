import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hackapp/constants.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _currText;
  int currentStep = 0;
  bool complete = false;
  bool isChecked = false;
  next() {
    currentStep + 1 != 3
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        isActive: true,
        title: Text(''),
        content: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 195, 30),
              child: Text(
                'Personal',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 245, 0),
              child: Text(
                'Name:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                decoration: kTextFieldDecoration,
                onChanged: (value) {
                  _currText = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 156, 0),
              child: Text(
                'Contact Number:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                decoration: kTextFieldDecoration,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 156, 0),
              child: Text(
                'University Name:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                decoration: kTextFieldDecoration,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 157, 0),
              child: Text(
                'Year Studying In:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                decoration: kTextFieldDecoration,
              ),
            ),
          ],
        ),
      ),
      Step(
        isActive: currentStep >= 1 ? true : false,
        title: Text(''),
        content: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 234, 30),
              child: Text(
                'Skills',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 13, 55, 0),
              child: Text(
                'Brief description about yourself:',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                maxLines: 5,
                decoration: kTextFieldDecoration,
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                    ),
                    Text(
                      'Web Development',
                      style: TextStyle(fontSize: 18,color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      Step(
        isActive: currentStep == 2 ? true : false,
        title: Text(''),
        content: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 180, 0),
              child: Text(
                'Personal',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 132, 30),
              child: Text(
                '(you can skip this section)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 240, 0),
              child: Text(
                'Github:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                decoration: kTextFieldDecoration,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 168, 0),
              child: Text(
                'Stack Overflow:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                decoration: kTextFieldDecoration,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 183, 0),
              child: Text(
                'Your Website:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                decoration: kTextFieldDecoration,
              ),
            ),
          ],
        ),
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 300,maxHeight: 800),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 32, 65, 30),
                    child: Text(
                      'Complete your profile',
                      style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Theme(
                      data: ThemeData(
                        canvasColor: Colors.white,
                        primaryColor: Colors.green,
                      ),
                      child: Stepper(
                        steps: steps,
                        type: StepperType.horizontal,
                        currentStep: currentStep,
                        onStepContinue: next,
                        onStepTapped: (step) => goTo(step),
                        onStepCancel: cancel,
                        controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue,
                            VoidCallback onStepCancel}) {
                          return currentStep < 2
                              ? GestureDetector(
                                  onTap: onStepContinue,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(315, 15, 0, 0),
                                    child: FaIcon(
                                      FontAwesomeIcons.arrowCircleRight,
                                      color: Color(0xff1fce69),
                                      size: 40,
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.fromLTRB(315, 15, 0, 0),
                                  child: FaIcon(
                                    FontAwesomeIcons.solidCheckCircle,
                                    color: Color(0xff1fce69),
                                    size: 40,
                                  ),
                                );
                        },
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
