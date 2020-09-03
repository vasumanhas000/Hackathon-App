import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/screens/loginFlow/loginFormPages/form1.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Form0 extends StatefulWidget {
  Form0();
  @override
  _Form0State createState() => _Form0State();
}

class _Form0State extends State<Form0> {
String name='',college='';
TextEditingController year=TextEditingController();
DateTime selectedDate = DateTime.now();
Future<Null> _selectDate(
    BuildContext context, TextEditingController controller) async {
  final DateTime picked = await showMonthPicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2024));
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      print(selectedDate);
      List pickedL = picked.toString().split(' ');
      List pickedList = pickedL[0].toString().split('-');
      controller.value = TextEditingValue(
          text:  pickedList[0]);
    });
}
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    year.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 1,
          itemBuilder:(BuildContext context, int index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'Heading',
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 30),
                    child: Container(
                      child: Text(
                        'Complete your profile',
                        style: TextStyle(fontFamily: 'Muli', fontSize: 30,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              Hero(
                tag: 'Icons',
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/1unfilled.png'),
                        height: 45,
                      ),
                      Image(
                        image: AssetImage('images/blueLine.png'),
                        color: Colors.white,
                      ),
                      Image(
                        image: AssetImage('images/2unfilled.png'),
                        height: 45,
                      ),
                      Image(
                        image: AssetImage('images/blueLine.png'),
                        color: Colors.white,
                      ),
                      Image(
                        image: AssetImage('images/3unfilled.png'),
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 30),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Personal',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Name :',
                  style: kHeadingTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: TextField(
                 style: kFieldTextStyle,
                  onChanged: (val){
                    setState(() {
                      name=val;
                    });
                  },
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'University Name :',
                  style: kHeadingTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: TextField(
                  style: kFieldTextStyle,
                  onChanged: (val){
                    setState(() {
                      college=val;
                    });
                  },
                  decoration: kTextFieldDecoration,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Year of Graduation :',
                  style: kHeadingTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: GestureDetector(
                  onTap: (){
                    _selectDate(context, year);
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      style: kFieldTextStyle,
                      keyboardType: TextInputType.datetime,
                      controller: year,
                      decoration: kTextFieldDecoration,
                    ),
                  ),
                ),
              ),
              Hero(
                tag: 'BottomIcon',
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 24, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       GestureDetector(
                         onTap: () async{
                           if(name==''||college==''||year==''){
                             final snackBar = SnackBar(
                               content: Text(
                                 'All fields are mandatory.',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat'),
                               ),
                               backgroundColor:kConstantBlueColor ,
                             );
                             await Scaffold.of(context).showSnackBar(snackBar);
                             print('empty');
                           }
                           else{
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Form1(name: name,year: year.text,college: college,)));
                           }
                           },
                         child: Container(
                           height: 50,
                           width: 50,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(40),
                             color: kConstantBlueColor,
                           ),
                           child: Icon(Icons.arrow_forward,color: Colors.white,size: 28,),
                         ),
                       ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
          );
          }
        ),
      ),
    );
  }
}
