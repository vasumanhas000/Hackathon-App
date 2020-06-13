import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListSearch extends StatefulWidget {
  @override
  _ListSearchState createState() => _ListSearchState();
}

class _ListSearchState extends State<ListSearch> {

  List<User> _users= List<User>();

  Future<List<User>> getUsers() async{
   var response= await http.get("https://next.json-generator.com/api/json/get/4JG1T5Ki_");

   var users=List<User>();
   if(response.statusCode==200){
     var usersJson=json.decode(response.body);
     for(var u in usersJson ){

     }
   }
   return users;
  }

  @override
  Widget build(BuildContext context) {
    getUsers().then((value){
      setState(() {
        _users.addAll(value);
      });
    });
    return ListView.builder(
      itemCount: _users.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: Colors.white,
            ),
            child: Center(child: Text(_users[index].name)),
          );
        },
    );
  }
}

class User{
  String name,location;
  User(this.location,this.name);
  User.fromJson(Map<String, dynamic> json){
    name=json['name'];
    location=json['location'];
  }
}