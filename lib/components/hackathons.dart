class Hackathon{
  String name,start,end,location,description,url;
  Hackathon({this.description,this.name,this.end,this.location,this.start,this.url});

  Map toJson() => {
    'name': name,
    'description': description,
  };
}
