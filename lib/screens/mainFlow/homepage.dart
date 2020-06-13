import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final hackathons = [
    'Lorem Ipsum',
    'Lorem Ipsum',
    'Lorem Ipsum',
    'Lorem Ipsum',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 50, 15),
            child: Container(
              child: Text(
                'Hacks happening around you',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: ListView.builder(
            itemCount: hackathons.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(hackathons[index],style: TextStyle(color: Colors.white),),
                  ),
                  height: 190,
                  decoration: BoxDecoration(
                    color: Color(0xff98C1D9),
                    borderRadius: BorderRadius.only(bottomRight:Radius.circular(30),topLeft:Radius.circular(30)  ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
