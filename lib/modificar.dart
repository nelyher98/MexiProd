import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto1/pagina_principal.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:proyecto1/handcraft.dart';
//nuevo para imagenes
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';

File image;
String filename;
FToast fToast;

class ModificarPage extends StatefulWidget{

  final Handcraft handcraft;
  ModificarPage(this.handcraft);

  @override
  ModificarPageState createState() => ModificarPageState();

}

final handcraftReference = FirebaseDatabase.instance.reference().child('handcraft');

class ModificarPageState extends State<ModificarPage> {

  List<Handcraft> items;

  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;
  TextEditingController _currencyController;
  TextEditingController _widthController;
  TextEditingController _heightController;
  String productImage;

  String dropdownValue = 'Peso MX';


  pickerGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.handcraft.name);
    _descriptionController = new TextEditingController(text: widget.handcraft.description);
    _priceController = new TextEditingController(text: widget.handcraft.price);
    _currencyController = new TextEditingController(text: widget.handcraft.currency);
    _widthController = new TextEditingController(text: widget.handcraft.width);
    _heightController = new TextEditingController(text: widget.handcraft.height);
    productImage = widget.handcraft.productImage;
    print(productImage);
    fToast = FToast(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffFF99CC),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
          child: Center(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          height: 30.0,
                          width: 350.0,
                          decoration: BoxDecoration(

                            border: Border.all(
                              color: Color(0xffE5E5E5),
                              width: 1,
                            ),
                          ),
                          child: Text("Modificar producto",
                            style: TextStyle(
                                color: Color(0xffFF6EB7),
                                fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 70, 0, 0),
                          width: 370,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                fillColor: Color(0xffFFFFFF),
                                filled: true,
                                labelText: 'Nombre',
                                labelStyle:  TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xffA8AA92),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 120, 0, 0),
                          width: 370,
                          height: 70,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextField(
                              controller: _descriptionController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),

                                ),
                                fillColor: Color(0xffFFFFFF),
                                filled: true,
                                labelText: 'Descripción',
                                labelStyle:  TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xffA8AA92),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.fromLTRB(10, 200, 0, 0),
                          width: 180,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextField(
                              controller: _priceController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                fillColor: Color(0xffFFFFFF),
                                filled: true,
                                labelText: 'Costo',
                                labelStyle:  TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xffA8AA92),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(10, 200, 0, 0),
                          width: 180,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                  color: Colors.deepPurple
                              ),
                              onChanged: (String newValue){
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'Peso MX','Euro €', 'Dolar \$', 'Libra £'
                              ].map<DropdownMenuItem<String>>((String value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),


                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 250, 0, 0),
                          width: 180,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextField(
                              controller: _widthController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                fillColor: Color(0xffFFFFFF),
                                filled: true,
                                labelText: 'Largo',
                                labelStyle:  TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xffA8AA92),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(10, 250, 0, 0),
                          width: 180,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextField(
                              controller: _heightController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                fillColor: Color(0xffFFFFFF),
                                filled: true,
                                labelText: 'Ancho',
                                labelStyle:  TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xffA8AA92),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),


                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 300, 0, 0),
                          width: 370,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child:  RaisedButton(
                              onPressed: pickerGallery,
                              child: const Text('Imagen',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  )
                              ),
                              color: Color(0xffFF99CC),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(150, 360, 0, 0),
                          height: 100.0,
                          width: 100.0,
                          decoration: new BoxDecoration(
                            border: new Border.all(color: Color(0xff4D4D4D), width: 2.0),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          padding: new EdgeInsets.all(7.0),
                          child:image == null ? Text('Imagen'): Image.file(image),
                        ),
                      ],
                    ),


                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 480, 0, 0),
                          width: 165,
                          height: 35,
                          child: RaisedButton(
                            onPressed:(){
                              _nameController.clear();
                              _descriptionController.clear();
                              _priceController.clear();
                              _currencyController.clear();
                              _widthController.clear();
                              _heightController.clear();
                              image = null;

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
                            child: Text('Limpiar',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff009688),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(20, 480, 0, 0),
                          width: 165,
                          height: 35,
                          child: RaisedButton(
                            onPressed: (){
                              if (widget.handcraft.id != null) {

                                var now = formatDate(
                                    new DateTime.now(), [yyyy, '-', mm, '-', dd]);
                                var fullImageName =
                                    '${_nameController.text}-$now' + '.jpg';
                                var fullImageName2 =
                                    '${_nameController.text}-$now' + '.jpg';

                                final StorageReference ref =
                                FirebaseStorage.instance.ref().child(fullImageName);
                                final StorageUploadTask task = ref.putFile(image);

                                var part1 =
                                    'https://firebasestorage.googleapis.com/v0/b/mexiprod.appspot.com/o/';

                                var fullPathImage = part1 + fullImageName2;

                                handcraftReference.child(widget.handcraft.id).set(
                                    {
                                      'name': _nameController.text,
                                      'description': _descriptionController.text,
                                      'price': _priceController.text,
                                      'currency': dropdownValue,
                                      'width': _widthController.text,
                                      'height': _heightController.text,
                                      'ProductImage': '$fullPathImage'

                                    }).then((_) {
                                  Navigator.pop(context);
                                });
                              }else{

                                var now = formatDate(
                                    new DateTime.now(), [yyyy, '-', mm, '-', dd]);
                                var fullImageName =
                                    '${_nameController.text}-$now' + '.jpg';
                                var fullImageName2 =
                                    '${_nameController.text}-$now' + '.jpg';

                                final StorageReference ref =
                                FirebaseStorage.instance.ref().child(fullImageName);
                                final StorageUploadTask task = ref.putFile(image);

                                var part1 =
                                    'https://firebasestorage.googleapis.com/v0/b/mexiprod.appspot.com/o/'; //esto cambia segun su firestore

                                var fullPathImage = part1 + fullImageName2;

                                productReference.push().set(
                                    {
                                      'name': _nameController.text,
                                      'description': _descriptionController.text,
                                      'price': _priceController.text,
                                      'currency': dropdownValue,
                                      'width': _widthController.text,
                                      'height': _heightController.text,
                                      'ProductImage': '$fullPathImage'

                                    }).then((_) {
                                  Navigator.pop(context);
                                });

                              }
                              _showToastModificado(context);
                            },
                            color: Color(0xff009688),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18.0))),
                            child: Text('Guardar',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),

                        ),
                      ],
                    ) ,

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


void  _showToastModificado(BuildContext context) {
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
        Text("Producto modificado",
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
