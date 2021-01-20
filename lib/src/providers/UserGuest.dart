import 'package:flutter/material.dart';

class UserGuest with ChangeNotifier {
  String _email = "user@host.com";
  String _password = "XXXXX";
  String _name = "user e-photo-app";
  String _token = "";
  String _profile1 = "";
  String _profile2 = "";
  String _profile3 = "";

  String get email {
    return _email;
  }

  get password {
    return _password;
  }

  get name {
    return _name;
  }

  get token {
    return _token;
  }

  get profile1 {
    return _profile1;
  }

  get profile2 {
    return _profile2;
  }

  get profile3 {
    return _profile3;
  }

  set email(String emailInput) {
    this._email = emailInput;
    notifyListeners();
  }

  set password(String passwd) {
    this.password = passwd;
    notifyListeners();
  }

  set name(String nameUser) {
    this._name = nameUser;
    notifyListeners();
  }

  set token(String jwt) {
    this._token = jwt;
    notifyListeners();
  }

  set profile1(String photo) {
    this._profile1 = photo;
    notifyListeners();
  }

  set profile2(String photo) {
    this._profile2 = photo;
    notifyListeners();
  }

  set profile3(String photo) {
    this._profile3 = photo;
    notifyListeners();
  }
}
