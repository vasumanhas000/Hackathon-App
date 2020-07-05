import 'package:flutter/material.dart';
import 'homepage.dart';
import 'search.dart';
import 'addUsers.dart';
import 'Profile.dart';

class FlowPage extends StatefulWidget {
  final int currentIndex;
  FlowPage({this.currentIndex});
  @override
  _FlowPageState createState() => _FlowPageState(this.currentIndex);
}

class _FlowPageState extends State<FlowPage> {
  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
  _FlowPageState(this.currentIndex);
  int currentIndex;
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
        body: SafeArea(child: _widgetOptions.elementAt(currentIndex)),
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
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
