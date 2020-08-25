import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto1/nuevo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:proyecto1/modificar.dart';
import 'package:proyecto1/handcraft.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto1/informacion.dart';
import 'package:proyecto1/creditos.dart';

FToast fToast;


class MyMainPage extends StatefulWidget{

@override
MyMainPageState createState() => MyMainPageState();

}

final productReference = FirebaseDatabase.instance.reference().child('handcraft');


class MyMainPageState extends State<MyMainPage>{

  List<Handcraft> items;
  StreamSubscription<Event> _onProductAddedSubscription;
  StreamSubscription<Event> _onProductChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onProductAddedSubscription =
        productReference.onChildAdded.listen(_onProductAdded);
    _onProductChangedSubscription =
        productReference.onChildChanged.listen(_onProductUpdate);
    fToast = FToast(null);

  }

  @override
  void dispose() {
    super.dispose();
    _onProductAddedSubscription.cancel();
    _onProductChangedSubscription.cancel();
  }


@override
  Widget build(BuildContext context){
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
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 3.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(
                    height: 2.0,
                  ),
                  Container(
                    padding: new EdgeInsets.all(3.0),
                    child: Card(
                      child:Center(
                      child:Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              //nuevo imagen
                              Expanded(
                                child: ListTile(
                                    title: Text(
                                      '${items[position].name}',
                                      style: TextStyle(
                                          color: Color(0xffFF6EB7),
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        fontFamily: 'Shadow'

                                      ),
                                    ),
                                    subtitle: Text(
                                      '${items[position].description}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontFamily: 'Dekko'
                                      ),
                                    ),
                                    ),
                              ),
                              Container(
                                padding: new EdgeInsets.all(5.0),
                                child: '${items[position].productImage}' == ''
                                    ? Text('No image')
                                    : Image.network(
                                  '${items[position].productImage}' +
                                      '?alt=media',
                                  fit: BoxFit.fill,
                                  height: 80.0,
                                  width: 80.0,
                                ),
                              ),

                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Color(0xffFF99CC),
                                  ),
                                  onPressed: () =>
                                      _navigateToProduct(context, items[position]),
                              ),

                              IconButton(
                                  icon: Icon(
                                    Icons.mode_edit,
                                    color: Color(0xffFF99CC),
                                  ),
                                  onPressed: () =>  _navigateToProductInformation(
                                      context, items[position]),

                              ),

                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Color(0xffFF99CC),
                                ),
                                onPressed: () { _showDialog(context, position);}
                              ),

                            ],
                          )
                        ],

                      ),

                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () => _createNewProduct(context),
        child: Icon(Icons.add),
        backgroundColor: Color(0xff009688),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child:Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)
              ),
            ),
            child:Row(
              children: <Widget>[
                Text("Desarrollado por: Nely Hernández García",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'Redressed'
                  ),
                ),
              ],
            ),
          ),
        ),
        color: Colors.white,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
}

  void _showDialog(context, position) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
                      padding: new EdgeInsets.all(5.0),
                      child: '${items[position].productImage}' == ''
                          ? Text('No image')
                          : Image.network(
                        '${items[position].productImage}' +
                            '?alt=media',
                        fit: BoxFit.fill,
                        height: 80.0,
                        width: 80.0,
                      ),
                    ),
                    ListTile(
                      title:Container(
                        margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        child:Text(
                          '${items[position].name}',
                          style: TextStyle(
                            color: Color(0xff009688),
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Dekko',
                          ),
                        ),
                      ),
                      subtitle: Text(
                        '¿Seguro que desea eliminar este producto?',
                        style: TextStyle(
                            color: Color(0xffFF6EB7),
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Dekko'
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(25,0, 0, 0),
                              width: 105,
                              height: 35,
                              child: RaisedButton(
                                onPressed:(){
                                  Navigator.of(context).pop();
                                },
                                color: Color(0xffFFFFFF),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(18.0)),
                                    side: BorderSide(
                                      width: 2,
                                      color: Color(0xff009688),
                                    )
                                ),
                                child: Text('Volver',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff009688),
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              width: 105,
                              height: 35,
                              child: RaisedButton(
                                onPressed: () {
                                  _deleteProduct(context, items[position], position);
                                },
                                color: Color(0xff009688),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18.0))),
                                child: Text('Confirmar',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }


  void _onProductAdded(Event event) {
    setState(() {
      items.add(new Handcraft.fromSnapShot(event.snapshot));
    });
  }

  void _onProductUpdate(Event event) {
    var oldProductValue =
    items.singleWhere((product) => product.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldProductValue)] =
      new Handcraft.fromSnapShot(event.snapshot);
    });
  }

  void _navigateToProductInformation(
      BuildContext context, Handcraft handcraft) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ModificarPage(handcraft)),
    );
  }


  void _navigateToProduct(BuildContext context, Handcraft handcraft) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductInformation(handcraft)),
    );
  }

void _deleteProduct(BuildContext context, Handcraft handcraft, int position) async {
  await productReference.child(handcraft.id).remove().then((_) {
    setState(() {
      items.removeAt(position);
      Navigator.of(context).pop();
    });
  });
}


void _createNewProduct(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>
            NuevoPage(Handcraft( null,'', '', '', '', '', '',""))),
  );
}

}
