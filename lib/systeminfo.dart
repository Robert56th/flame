import 'package:flutter/material.dart';

void main() {
  runApp(Systeminfo());
}

class Systeminfo extends StatefulWidget {
  @override
  _SysteminfoState createState() => _SysteminfoState();
}

class _SysteminfoState extends State<Systeminfo> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
          color: Colors.orange[200],
          elevation: 2,
          child: InkWell(
            child: SizedBox(
              height: 200,
              width: 150,
              child: Center(child: Text('Temperature: UR HOT'),),
            ),
            onTap: () {},
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
          color: Colors.orange[300],
          elevation: 2,
          child: SizedBox(
            height: 200,
            width: 150,
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
          color: Colors.orange[400],
          elevation: 2,
          child: SizedBox(
            height: 200,
            width: 150,
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
          color: Colors.orange[500],
          elevation: 2,
          child: SizedBox(
            height: 200,
            width: 150,
          ),
        )
      ],
    );
  }
}
