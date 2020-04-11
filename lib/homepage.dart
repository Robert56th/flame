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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,200),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<Object>(
                  future: details,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(x[2]),
                            radius: 60,
                          ),
                        ],
                      );
                    }else {
                      return CircularProgressIndicator(backgroundColor: Colors.orange);
                    }
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,60,0,0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                  child: Text('SIGN OUT', style: TextStyle(fontFamily: 'Michroma', fontSize: 20),),
                  onPressed: () async {
                    signOutGoogle();
                    await setVisitingFlagOut();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

