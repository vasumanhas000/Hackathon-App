import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackapp/screens/loginFlow/loginPage.dart';
import 'editUser.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/components/User.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  String Token;
  Future logOut()async{
    FirebaseUser user= await _auth.currentUser();
    _dioCacheManager.clearAll();
    if(user!=null){
     await _auth.signOut();
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
  }
  DioCacheManager _dioCacheManager;
  Future<User> getUser() async {
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(Duration(days: 7),forceRefresh: true);
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    FirebaseUser user = await _auth.currentUser();
    Token= await user.getIdToken().then((result) {
      String token = result.token;
      return token;
    });
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authtoken"] = "$Token";
//    Map<String, String> headers = {"authtoken": Token};
    Response response = await _dio.get(
        "https://hackportal.azurewebsites.net/users",options: _cacheOptions);
    if (response.statusCode == 200) {
      var usersJson = response.data;
      User user = User(
        name: usersJson['name'],
        college: usersJson['college'],
        bio: usersJson['bio'],
        year: usersJson['expectedGraduation'],
        email: usersJson['email'],
        github: usersJson['githubLink'],
        stack: usersJson['stackOverflowLink'],
        link: usersJson['externalLink'],
        id: usersJson["_id"],
        skills: usersJson["skills"],
      );
      return (user);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    getUser();
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Container(
                  child: SpinKitFoldingCube(
                    size: 50,
                    color: kConstantBlueColor,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22,32,8,0),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(snapshot.data.name,
                                style: TextStyle(fontSize: 32,fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Padding(
                          child: Text(
                            'Email :',
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                          ),
                          padding: EdgeInsets.fromLTRB(22, 30, 8, 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 0, 8, 5),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                snapshot.data.email,
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                        Padding(
                          child: Text(
                            'University Name :',
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                          ),
                          padding: EdgeInsets.fromLTRB(22, 20, 8, 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 0, 8, 5),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              snapshot.data.college,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          child: Text(
                            'Year of graduation :',
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                          ),
                          padding: EdgeInsets.fromLTRB(22, 20, 8, 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 0, 8, 5),
                          child: Text(
                            snapshot.data.year,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          child: Text(
                            'Description :',
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                          ),
                          padding: EdgeInsets.fromLTRB(22, 20, 0, 8),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 0, 8, 8),
                          child: Text(
                            snapshot.data.bio,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          child: Text(
                            'Skills :',
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                          ),
                          padding: EdgeInsets.fromLTRB(22, 20, 0, 0),
                        ),
                        ListView.builder(
                            itemCount: snapshot.data.skills.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index1) {
                              if (snapshot.data.skills.length == 0) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                  child: Text('No Skills'),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(22, 8, 0, 0),
                                  child: Text(
                                    snapshot.data.skills[index1],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,48,24,8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 18),
                                child: ButtonTheme(
                                  height: 38,
                                  minWidth: 100,
                                  child: FlatButton(onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditUser(user: snapshot.data)));
                                  },color: Colors.white,child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text('Edit',style: TextStyle(color: kConstantBlueColor,fontFamily: 'Montserrat',fontSize: 16),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5,0,0,3),
                                        child: Icon(Icons.edit,size: 18,color: kConstantBlueColor,),
                                      ),
                                    ],
                                  ),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color: kConstantBlueColor,width: 2)),
                                  ),
                                ),
                              ),
                              ButtonTheme(
                                minWidth: 100,
                                height: 38,
                                child: FlatButton(onPressed: ()async{
                                  await logOut();
                                },color: kConstantBlueColor,child: Text('Sign Out',style: TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontSize: 16),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
