import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/mainFlow/myTeams.dart';
import 'package:hackapp/screens/mainFlow/newHomepage.dart';
import 'search.dart';
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
    NewHomePage(),
    SearchPage(),
    MyTeams(),
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
        body: IndexedStack(index:currentIndex ,children: <Widget>[
          NewHomePage(),
          SearchPage(),
          MyTeams(),
          ProfilePage(),
        ],),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: kConstantBlueColor,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_shared),
              title: Text('Teams',),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person),title:Text('Profile'))
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
