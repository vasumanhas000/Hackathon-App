import 'package:flutter/cupertino.dart';

class Hackathon{
  String name,start,end,location,description,url,id,creatorID,image;
  int min,max;
  bool teamCreated;
  Hackathon({this.description,this.name,this.end,this.location,this.start,this.url,@required this.id,this.image,this.min,this.max,this.creatorID,this.teamCreated});
}
