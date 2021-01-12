import 'package:flutter/material.dart';

class Event with ChangeNotifier {
  int _code = 0;
  String _dateEvent = "";
  String _description = "";
  String _location = "";
  bool _statusEvent = false;
  String _owner = "";
  String _studioName = "";

  int get code {
    return _code;
  }

  String get description {
    return _description;
  }

  String get dateEvent {
    return _dateEvent;
  }

  String get location {
    return _location;
  }

  bool get statusEvent {
    return _statusEvent;
  }

  String get owner {
    return _owner;
  }

  String get studioName {
    return _studioName;
  }

  set code(int codeNew) {
    this._code = codeNew;
    notifyListeners();
  }

  set description(String descriptionNew) {
    this._description = descriptionNew;
    notifyListeners();
  }

  set dateEvent(String dateEventNew) {
    this._dateEvent = dateEventNew;
    notifyListeners();
  }

  set location(String locationNew) {
    this._location = locationNew;
    notifyListeners();
  }

  set statusEvent(bool statusEventnew) {
    this._statusEvent = statusEventnew;
    notifyListeners();
  }

  set owner(String ownerNew) {
    this._owner = ownerNew;
    notifyListeners();
  }

  set studioName(String newStudio) {
    this._studioName = newStudio;
    notifyListeners();
  }
}
