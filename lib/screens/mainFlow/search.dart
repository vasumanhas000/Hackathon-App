import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:hackapp/constants.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30,130, 15),
                  child: Container(
                    child: Text(
                      'Team Finder',
                      style: TextStyle(
                        color: Color(0xff293241),
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 17,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 50),
                  child: SearchBar(
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 8, 0, 8),
                      child: Icon(Icons.search,size: 30,color: Color(0xff98c1d9),),
                    ),
                    onSearch: null,
                    hintText: 'Search for teams',
                    hintStyle: TextStyle(color:Color(0xff98c1d9) ),
                    onItemFound: null,
                    searchBarStyle: SearchBarStyle(
                      backgroundColor: kConstantBackgroundColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
