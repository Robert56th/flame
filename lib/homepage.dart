import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Login.dart';

void main() {
  runApp(Homepage());
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

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future details;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    details = _getfuture();
  }

  var x;
  _getfuture() async {
    x = await getVisitingFlag();
    print(x);
    //await Future.delayed(Duration(seconds: 2));

    return x;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'H O M E',
                style: TextStyle(fontFamily: 'Michroma'),
              ),
              backgroundColor: Colors.orange[600],
            ),
            //PAGE VIEW
            body: PageView(
              scrollDirection: Axis.horizontal,
              controller: PageController(initialPage: 2),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: 
                  //1st card
                  Card(
                    elevation: 2,
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
                                      padding: const EdgeInsets.all(25.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(x[2]),
                                        radius: 60,
                                      ),
                                    ),
                                    SizedBox (
                                      width: 300,
                                      height: 300,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(20)),
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
                                                  builder: (context) => Login()));
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
                //2nd Card
                Card()
              ],
            )));
  }
}