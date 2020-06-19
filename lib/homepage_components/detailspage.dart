import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'teamcreate.dart';
import 'package:hackapp/components/hackathons.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

class HackDetails extends StatefulWidget {
  final Hackathon hackathon;
  HackDetails({this.hackathon});
  @override
  _HackDetailsState createState() => _HackDetailsState(this.hackathon);
}

class _HackDetailsState extends State<HackDetails> {
  _HackDetailsState(this.hackathon);
  Hackathon hackathon;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff3d5a80),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index)=>
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 13, 0, 0),
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.arrowCircleLeft,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Container(
                            child: Text(
                              'Create a team',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateTeam(),
                                    ));
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    hackathon.name,
                    style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 39,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(31, 30, 0, 0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    hackathon.location,
                    style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 28,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(31, 30, 0, 0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    hackathon.start + '-' + hackathon.end,
                    style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 26,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(31, 30, 10, 0),
                child: Text(
                 hackathon.description,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(31, 30, 10, 0),
                child: Text(
                  'Link:',
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(31,0,0, 0),
                child: GestureDetector(
                  onTap: (){
                    launch('https://vit.ac.in/school-computer-science-and-engineering-scope/hack4cause');
                  },
                  child: Text(
                    hackathon.url,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
