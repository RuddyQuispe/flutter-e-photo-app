import 'package:flutter/material.dart';

class ListPhoto with ChangeNotifier {
  List<Map<String, dynamic>> _listShoppingCart = [];
  double _totalCost = 0;

  List<Map<String, dynamic>> get listShoppingCart {
    return this._listShoppingCart;
  }

  double get totalCost {
    return this._totalCost;
  }

  int getCountPhotosAdded() {
    return this._listShoppingCart.length;
  }

  addListPhoto(Map<String, dynamic> photoDataAdd) {
    this._listShoppingCart.add(photoDataAdd);
    _totalCost += photoDataAdd["price"];
    notifyListeners();
  }
}
