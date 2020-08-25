import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto1/loader/color_loader.dart';
import 'dart:async';
import 'package:proyecto1/services/sensor.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return initScreen(context);
}

  @override
  void initState() {
    super.initState();
    startTimer();
  }



  startTimer() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Sensor()
    )
    );
  }

  initScreen(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 200, 0, 0),
              child:Text('Mexi- Prod',
                  style:TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFF6EB7),
                      fontFamily: 'Gochi'
                  )) ,
            ),

            Container(
                child:Image.asset(
                  "images/mandala2.gif",
                  height: 200.0,
                  width: 200.0,
                )
            ),

            ColorLoader3(),

          ],
        ),
      ),
    );
  }
}