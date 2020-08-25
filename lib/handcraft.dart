import 'package:firebase_database/firebase_database.dart';

class Handcraft{
  String _id;
  String _name;
  String _description;
  String _price;
  String _currency;
  String _width;
  String _height;
  String _productImage;

  Handcraft(this._id,this._name,this._description,this._price,
      this._currency,this._width, this._height,this._productImage);

  Handcraft.map(dynamic obj){
    this._name = obj['name'];
    this._description = obj['description'];
    this._price = obj['price'];
    this._currency = obj['currency'];
    this._width = obj['width'];
    this._height = obj['height'];
    this._productImage = obj['ProductImage'];
  }

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get price => _price;
  String get currency => _currency;
  String get width => _width;
  String get height => _height;
  String get productImage => _productImage;


  Handcraft.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _description = snapshot.value['description'];
    _price = snapshot.value['price'];
    _currency = snapshot.value['currency'];
    _width= snapshot.value['width'];
    _height = snapshot.value['height'];
    _productImage = snapshot.value['ProductImage'];
  }


}
