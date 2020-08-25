import 'package:flutter/material.dart';
import 'package:proyecto1/pagina_principal.dart';
import 'package:fluttertoast/fluttertoast.dart';



FToast fToast;

class Creditos extends StatefulWidget {
  @override
  _CreditosState createState() => _CreditosState();
}


class _CreditosState extends State<Creditos> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
        primaryColor: Color(0xffFF99CC),
    ),
    home: Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,size: 40.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyMainPage()),
              );
            },
          ),
          title: Center(child: new Text("Mexi-Prod",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontFamily: 'Gochi'
            ),
          )
          ),

      ),
      body: Container(
        height: 800.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        child:Image.asset(
                          "images/alebrije.gif",
                          height: 200.0,
                          width: 200.0,
                        )
                    ),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("Desarrollador: Nely Hernández García", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("Esta app fue desarrollada para la materia de Programación para móviles II, proyecto progresivo de todo el cuatri. El objetivo de esta app es promover los productos mexicanos :D", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("¡Muchas gracias por su atención! :3", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("Hecha con: Dart y amor <3 ", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("Fecha: 22/08/2020", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),

                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    ),
    );
  }


}
