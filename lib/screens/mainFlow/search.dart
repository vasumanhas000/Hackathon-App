import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:hackapp/screens/mainFlow/searchResults.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int selectWeb,
      selectMobile,
      selectDevOps,
      selectML,
      selectAI,
      selectDesign,
      selectManagement,
      selectBlock,
      selectCyber;
  List skillList = [];
  var toRemove = [];
  String _selectedRadio;
  int selected=1;
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
                padding: const EdgeInsets.fromLTRB(16,24,16,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Choose skills',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                      width:200,
                    ),
                    Image(
                      image: AssetImage('images/stc.png'),
                      height: SizeConfig.safeBlockVertical * 3.15,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 60, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 26,
                        color: selectWeb==1?kConstantBlueColor:Color(0xffD8D8D8),
                      ),
                      onTap: (){
                        setState(() {
                          if(selectWeb!=1){
                            selectWeb=1;}
                          else{
                            selectWeb=0;
                          }
                        });
                      },),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                      width: 200,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Web Development',style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 26,
                        color: selectMobile==1?kConstantBlueColor:Color(0xffD8D8D8),
                      ),
                      onTap: (){
                        setState(() {
                          if(selectMobile!=1){
                            selectMobile=1;}
                          else{
                            selectMobile=0;
                          }
                        });
                      },),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 265,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Mobile App Development',style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 26,
                        color: selectDevOps==1?kConstantBlueColor:Color(0xffD8D8D8),
                      ),
                      onTap: (){
                        setState(() {
                          if(selectDevOps!=1){
                            selectDevOps=1;}
                          else{
                            selectDevOps=0;
                          }
                        });
                      },),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 78,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Devops',style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 26,
                        color: selectML==1?kConstantBlueColor:Color(0xffD8D8D8),
                      ),
                      onTap: (){
                        setState(() {
                          if(selectML!=1){
                            selectML=1;}
                          else{
                            selectML=0;
                          }
                        });
                      },),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 190,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Machine Learning',style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 26,
                        color: selectAI==1?kConstantBlueColor:Color(0xffD8D8D8),
                      ),
                      onTap: (){
                        setState(() {
                          if(selectAI!=1){
                            selectAI=1;}
                          else{
                            selectAI=0;
                          }
                        });
                      },),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 210,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Artificial Intelligence',style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 26,
                        color: selectDesign==1?kConstantBlueColor:Color(0xffD8D8D8),
                      ),
                      onTap: (){
                        setState(() {
                          if(selectDesign!=1){
                            selectDesign=1;}
                          else{
                            selectDesign=0;
                          }
                        });
                      },),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 150,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Design - UI/UX',style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 26,
                        color: selectManagement==1?kConstantBlueColor:Color(0xffD8D8D8),
                      ),
                      onTap: (){
                        setState(() {
                          if(selectManagement!=1){
                            selectManagement=1;}
                          else{
                            selectManagement=0;
                          }
                        });
                      },),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 195,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Management skills',style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 26,
                        color: selectBlock==1?kConstantBlueColor:Color(0xffD8D8D8),
                      ),
                      onTap: (){
                        setState(() {
                          if(selectBlock!=1){
                            selectBlock=1;}
                          else{
                            selectBlock=0;
                          }
                        });
                      },),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 117,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Blockchain',style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 26,
                        color: selectCyber==1?kConstantBlueColor:Color(0xffD8D8D8),
                      ),
                      onTap: (){
                        setState(() {
                          if(selectCyber!=1){
                            selectCyber=1;}
                          else{
                            selectCyber=0;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,0,0,0),
                      child: SizedBox(
                        width: 140,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('CyberSecurity',style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 200,
                      height: 46,
                      child: RaisedButton(
                        onPressed: () {
                          if(selectWeb==1){
                            var count=0;
                            for(var i in skillList){
                              if(i=='Web Dev'){
                                count+=1;
                              }
                            }
                            if(count==0){
                              skillList.add('Web Dev');
                            }
                          }
                          if(selectMobile==1){
                            var count=0;
                            for(var i in skillList){
                              if(i=='App Dev'){
                                count+=1;
                              }
                            }
                            if(count==0){
                              skillList.add('App Dev');
                            }
                          }
                          if(selectDevOps==1){
                            var count=0;
                            for(var i in skillList){
                              if(i=='DevOps'){
                                count+=1;
                              }
                            }
                            if(count==0){
                              skillList.add('DevOps');
                            }
                          }
                          if(selectML==1){
                            var count=0;
                            for(var i in skillList){
                              if(i=='Machine Learning'){
                                count+=1;
                              }
                            }
                            if(count==0){
                              skillList.add('Machine Learning');
                            }
                          }
                          if(selectAI==1){
                            var count=0;
                            for(var i in skillList){
                              if(i=='AI'){
                                count+=1;
                              }
                            }
                            if(count==0){
                              skillList.add('Artificial Intelligence');
                            }
                          }
                          if(selectDesign==1){
                            var count=0;
                            for(var i in skillList){
                              if(i=='Design'){
                                count+=1;
                              }
                            }
                            if(count==0){
                              skillList.add('Design');
                            }

                          }
                          if(selectManagement==1){
                            var count=0;
                            for(var i in skillList){
                              if(i=='Management'){
                                count+=1;
                              }
                            }
                            if(count==0){
                              skillList.add('Management');
                            }
                          }
                          if(selectBlock==1){
                            var count=0;
                            for(var i in skillList){
                              if(i=='BlockChain'){
                                count+=1;
                              }
                            }
                            if(count==0){
                              skillList.add('BlockChain');
                            }
                          }
                          if(selectCyber==1){
                            var count=0;
                            for(var i in skillList){
                              if(i=='CyberSecurity'){
                                count+=1;
                              }
                            }
                            if(count==0){
                              skillList.add('CyberSecurity');
                            }
                          }
                          if(selectWeb!=1){
                            for(var i in skillList){
                              if(i=='Web Dev'){
                                toRemove.add(i);
                              }
                            }
                          }
                          if(selectMobile!=1){
                            for(var i in skillList){
                              if(i=='App Dev'){
                                toRemove.add(i);
                              }
                            }
                          }
                          if(selectDevOps!=1){
                            for(var i in skillList){
                              if(i=='DevOps'){
                                toRemove.add(i);
                              }
                            }
                          }
                          if(selectML!=1){
                            for(var i in skillList){
                              if(i=='Machine Learning'){
                                toRemove.add(i);
                              }
                            }
                          }
                          if(selectAI!=1){
                            for(var i in skillList){
                              if(i=='AI'){
                                toRemove.add(i);
                              }
                            }
                          }
                          if(selectDesign!=1){
                            for(var i in skillList){
                              if(i=='Design'){
                                toRemove.add(i);
                              }
                            }
                          }
                          if(selectManagement!=1){
                            for(var i in skillList){
                              if(i=='Management'){
                                toRemove.add(i);
                              }
                            }
                          }
                          if(selectBlock!=1){
                            for(var i in skillList){
                              if(i=='BlockChain'){
                                toRemove.add(i);
                              }
                            }
                          }
                          if(selectCyber!=1){
                            for(var i in skillList){
                              if(i=='CyberSecurity'){
                                toRemove.add(i);
                              }
                            }
                          }
                          skillList.removeWhere( (e) => toRemove.contains(e));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultsPage(list: skillList)));
                        },
                        child: Text('Search',style: TextStyle(fontSize: 22,fontFamily: 'Muli',color: selected==1?Colors.white:kConstantBlueColor,fontWeight: FontWeight.w600),),
                        color: selected==1?kConstantBlueColor:Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),side: BorderSide(color: kConstantBlueColor,width: 3)),
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
