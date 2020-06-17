import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackapp/screens/addUserspages/page0.dart';
import 'package:hackapp/screens/addUserspages/page1.dart';
import 'package:hackapp/screens/addUserspages/page2.dart';

class UserScreen extends StatefulWidget {
 final int name;
  UserScreen({@required this.name});
  @override
  _UserScreenState createState() => _UserScreenState(this.name);
}

class _UserScreenState extends State<UserScreen> {
    int name;
    _UserScreenState(this.name);
    List<Widget> _screens=[
      Page0(),
      Page1(),
      Page2(),
    ];
    _dismissKeyboard(BuildContext context) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                _dismissKeyboard(context);
              },
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 800),
                child: SafeArea(
                  child: Scaffold(
                    body: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: name == 0
                                          ? Color(0xff3d5a80)
                                          : Colors.white,
                                      border:
                                      Border.all(color: name == 0
                                          ? Color(0xff3d5a80)
                                          : Color(0xff98c1d9), width: 4),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: name == 0 ? Colors.white : Color(
                                            0xff98c1d9),
                                      ),
                                      onPressed: () {
                                        setState(
                                                () {
                                              name = 0;
                                            });
                                      }),
                                  height: 50,
                                  width: 50,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: name == 1
                                          ? Color(0xff3d5a80)
                                          : Colors.white,
                                      border:
                                      Border.all(color: name == 1
                                          ? Color(0xff3d5a80)
                                          : Color(0xff98c1d9), width: 4),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.assignment_ind,
                                        color: name == 1 ? Colors.white : Color(
                                            0xff98c1d9),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          name = 1;
                                        });
                                      }),
                                  height: 50,
                                  width: 50,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: name == 2
                                          ? Color(0xff3d5a80)
                                          : Colors.white,
                                      border:
                                      Border.all(color: name == 2
                                          ? Color(0xff3d5a80)
                                          : Color(0xff98c1d9), width: 4),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.mail,
                                        color: name == 2 ? Colors.white : Color(
                                            0xff98c1d9),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          name = 2;
                                        });
                                      }),
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          _screens[name],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
