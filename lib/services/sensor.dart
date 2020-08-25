import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:proyecto1/pagina_principal.dart';
import 'package:proyecto1/creditos.dart';

class Sensor extends StatelessWidget {
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xffFF99CC),
        ),
    home: Scaffold(
      appBar: AppBar(
        title: Center(child: new Text("Mexi-Prod",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: 'Gochi'
          ),
        ),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 30.0,
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Creditos()),
                ),
          )
        ],
      ),

    body: GestureDetector(
    onTap: () async {
      bool weCanCheckBiometrics = await localAuth.canCheckBiometrics;

      if (weCanCheckBiometrics) {
        bool authenticated = await localAuth.authenticateWithBiometrics(
          localizedReason: "Authenticate to see your bank statement.",
        );

        if (authenticated) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyMainPage(),
            ),
          );
        }
      }
    },
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Text('Biometric Sensor',style: TextStyle(
          color: Color(0xffFF6EB7),
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Shadow'

      ),
        textAlign: TextAlign.center,
      ),
    Divider(),
    Icon(
    Icons.fingerprint,
    size: 124.0,
    ),
    Text(
    "Touch to Login",
    style: TextStyle(
    fontSize: 16.0,
    color: Color(0xff009688),
    ),
    textAlign: TextAlign.center,
    ),
    ],
    ),
    ),
    ),
    );

  }
}
