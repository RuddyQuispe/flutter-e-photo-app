import 'package:flutter/material.dart';

class UserGuest with ChangeNotifier {
  String _email = "user@host.com";
  String _password = "XXXXX";
  String _name = "user e-photo-app";
  String _token = "";
  ThemeData _theme = ThemeData.light();

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

  get theme {
    return _theme;
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

  set theme(ThemeData theme) {
    this._theme = theme;
    notifyListeners();
  }
}
