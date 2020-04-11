
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Login.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

var x;
var y;

getVisitingFlag () async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
  print (alreadyVisited);
  return alreadyVisited;
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //@override
  checker ()async{
    x = await getVisitingFlag();
    setState(() {
       y = x;
    });
    return y;
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    checker();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: y == true ? Homepage() : Login(),
    );
  }
}

