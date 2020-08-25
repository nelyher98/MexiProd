import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:proyecto1/handcraft.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast fToast;

class ProductInformation extends StatefulWidget {
  final Handcraft handcraft;
  ProductInformation(this.handcraft);
  @override
  _ProductInformationState createState() => _ProductInformationState();
}

final productReference = FirebaseDatabase.instance.reference().child('handcraft');

class _ProductInformationState extends State<ProductInformation> {

  List<Handcraft> items;

  String productImage;//nuevo

  @override
  void initState() {
    super.initState();
    productImage = widget.handcraft.productImage;
    print(productImage);
    fToast = FToast(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    new Text(" ${widget.handcraft.name}", style: TextStyle(
                      color: Color(0xff009688),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Dekko',
                    ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    Container(
                      height: 300.0,
                      width: 300.0,
                      child: Center(
                        child: productImage == ''
                            ? Text('No Image')
                            : Image.network(productImage+'?alt=media'),//nuevo para traer la imagen de firestore
                      ),
                    ),
                    new Text(" ${widget.handcraft.description}", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("Medidas: ${widget.handcraft.height} cm X ${widget.handcraft.width} cm", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),
                    new Text("Precio: ${widget.handcraft.price} ${widget.handcraft.currency}", style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0),),
                    Divider(),

                  ],
                ),

                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(30,0, 0, 0),
                      width: 130,
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
                      width: 130,
                      height: 35,
                      child: RaisedButton(
                        onPressed: () {
                          _showToastComprado(context);
                        },
                        color: Color(0xff009688),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18.0))),
                        child: Text('Comprar',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


void  _showToastComprado(BuildContext context) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Color(0xff009688),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check, color:Color(0xffFF6EB7) ,),
        SizedBox(
          width: 12.0,
        ),
        Text("Producto comprado",
          style: TextStyle(
            fontSize: 16.0,
            color: Color(0xffFFFFFF),
          ),
        ),
      ],
    ),
  );
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 5),
  );
}