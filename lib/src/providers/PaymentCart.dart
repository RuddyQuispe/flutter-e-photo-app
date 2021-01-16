import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/models/credit_card.dart';

class PaymentCart with ChangeNotifier {
  double _costTotal = 0.0;
  String _coin = "";
  bool _activeCard = false;
  CreditTarget _target = null;

  double get costTotal => this._costTotal;

  String get coin => this._coin;

  bool get activeCard => this._activeCard;

  CreditTarget get target => this._target;

  set costTotal(double newCost) {
    this._costTotal = newCost;
    notifyListeners();
  }

  set coin(String newCoin) {
    this._coin = newCoin;
    notifyListeners();
  }

  set activeCard(bool value) {
    this._activeCard = value;
    notifyListeners();
  }

  set tagert(CreditTarget card) {
    this._target = card;
    notifyListeners();
  }
}
