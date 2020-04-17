import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

void main (){
  runApp(Userinfo());
}

getVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List userDetails = preferences.getStringList('UserDetails');
  return userDetails;
}

setVisitingFlagOut() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool('alreadyVisited', false);
}

class Userinfo extends StatefulWidget {
  @override
  _UserinfoState createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  Future details;

  void initState() {
    // TODO: implement initState
    super.initState();
    details = _getfuture();
  }

  var userinfo;
  _getfuture() async {
    userinfo = await getVisitingFlag();
    print(userinfo);
    //await Future.delayed(Duration(seconds: 2));

    return userinfo;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                  child:
                      //1st card
                      Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(25),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.orange[50], Colors.orange[300]])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder<Object>(
                              future: details,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(70.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              NetworkImage(userinfo[2]),
                                          radius: 60,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 10),
                                        child: Text(
                                          userinfo[0],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black54),
                                        ),
                                      ),
                                      Text(
                                        userinfo[1],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        height: 200,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20)),
                                          child: Text(
                                            'SIGN OUT',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 20,
                                                letterSpacing: 2),
                                          ),
                                          onPressed: () async {
                                            signOutGoogle();
                                            await setVisitingFlagOut();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()));
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return CircularProgressIndicator(
                                      backgroundColor: Colors.orange);
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                )
                ;
  }
}