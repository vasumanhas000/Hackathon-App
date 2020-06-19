import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/sizeConfig.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _selectedRadio;
  int selected;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Text(
                        '''Choose a skill
you are looking for''',
                        style: TextStyle(
                            fontSize: 29, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Image(
                        image: AssetImage('images/vector.png'),
                        height: SizeConfig.safeBlockVertical * 15,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Web Development',style: TextStyle(color: Color(0xff293241),fontFamily: 'Montserrat',fontSize: 19),),
                leading: Radio(
                  value: 'Web',
                  groupValue: _selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadio = value;
                      selected=1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Mobile App Development',style: TextStyle(color: Color(0xff293241),fontFamily: 'Montserrat',fontSize: 19),),
                leading: Radio(
                  value: 'Mobile',
                  groupValue: _selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadio = value;
                      selected=1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('DevOps',style: TextStyle(color: Color(0xff293241),fontFamily: 'Montserrat',fontSize: 19),),
                leading: Radio(
                  value: 'DevOps',
                  groupValue: _selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadio = value;
                      selected=1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Machine Learning',style: TextStyle(color: Color(0xff293241),fontFamily: 'Montserrat',fontSize: 19),),
                leading: Radio(
                  value: 'ML',
                  groupValue: _selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadio = value;
                      selected=1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Artificial Intelligence',style: TextStyle(color: Color(0xff293241),fontFamily: 'Montserrat',fontSize: 19),),
                leading: Radio(
                  value: 'AI',
                  groupValue: _selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadio = value;
                      selected=1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Design - UI/UX',style: TextStyle(color: Color(0xff293241),fontFamily: 'Montserrat',fontSize: 19),),
                leading: Radio(
                  value: 'Design',
                  groupValue: _selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadio = value;
                      selected=1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Management skills',style: TextStyle(color: Color(0xff293241),fontFamily: 'Montserrat',fontSize: 19),),
                leading: Radio(
                  value: 'Management',
                  groupValue: _selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadio = value;
                      selected=1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Blockchain and Cryptocurrency',style: TextStyle(color: Color(0xff293241),fontFamily: 'Montserrat',fontSize: 19),),
                leading: Radio(
                  value: 'Block',
                  groupValue: _selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadio = value;
                      selected=1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('CyberSecurity',style: TextStyle(color: Color(0xff293241),fontFamily: 'Montserrat',fontSize: 19),),
                leading: Radio(
                  value: 'Cyber',
                  groupValue: _selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadio = value;
                      selected=1;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 200,
                      height: 46,
                      child: RaisedButton(
                        onPressed: () {
                          if(selected==1){
                          print(_selectedRadio);}
                        },
                        child: Text('Search',style: TextStyle(fontSize: 22,fontFamily: 'Muli',color: selected==1?Colors.white:kConstantBlueColor,fontWeight: FontWeight.w600),),
                        color: selected==1?kConstantBlueColor:Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22),side: BorderSide(color: kConstantBlueColor,width: 3)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
