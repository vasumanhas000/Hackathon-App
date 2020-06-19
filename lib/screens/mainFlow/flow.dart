import 'package:flutter/material.dart';
import 'homepage.dart';
import 'search.dart';
import 'addUsers.dart';
import 'Profile.dart';

class FlowPage extends StatefulWidget {
  @override
  _FlowPageState createState() => _FlowPageState();
}

class _FlowPageState extends State<FlowPage> {
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  int _currentIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    UserScreen(name: 1,),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _dismissKeyboard(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: _widgetOptions.elementAt(_currentIndex)),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xffEE6C4D),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_shared),
              title: Text(''),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person),title:Text(''))
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
