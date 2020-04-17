import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './Login.dart';
import 'homepage.dart';

void main() => runApp(Login());

String name;
String email;
String number;
String photo;

var detailList;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<FirebaseUser> handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  print("signed in " + user.displayName);

  name = user.displayName;
  email = user.email;
  photo = user.photoUrl;
  detailList = [name, email, photo];
  //print(detailList);

  return user;
}

setVisitingFlagIn() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool('alreadyVisited', true);
  preferences.setStringList('UserDetails', detailList);

}

void signOutGoogle() async {
  await _googleSignIn.signOut();
  print('User has signed out');
}





class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: (Text(
        //     'WELCOME',
        //     style: TextStyle(fontFamily: 'Michroma', letterSpacing: 7),
        //   )),
        //   backgroundColor: Colors.orange[400],
        // ),
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Colors.orange[100], Colors.orangeAccent])),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 170, 0, 0),
                  child: SizedBox(height: 300,child: Image.asset('assets/applogo.png')),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30)),color: Colors.grey[200],
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 30, child: Image.asset('assets/Glogo.png')),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          child: Text('LOG IN', style: TextStyle(fontFamily: 'Montserrat', letterSpacing: 4, fontSize: 20),),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      await handleSignIn();
                      await setVisitingFlagIn();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
