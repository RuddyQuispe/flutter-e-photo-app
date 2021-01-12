import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterGuest extends StatefulWidget {
  RegisterGuest({Key key}) : super(key: key);
  static final String routeName = 'register_guest';
  @override
  _RegisterGuestState createState() => _RegisterGuestState();
}

class _RegisterGuestState extends State<RegisterGuest> {
  /*
   * Attributes
   */
  final ImagePicker _picker = ImagePicker();
  File _image1;
  File _image2;
  File _image3;
  String nameUser, email, phone, password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("Registrar Cuenta Cliente"),
            backgroundColor: Colors.deepPurple[600]),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          children: <Widget>[
            _createInputName(),
            _createInputEmail(),
            _createInputPhone(),
            _createInputPassword(),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple[600],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(blurRadius: 6.0, offset: Offset(0.0, 5.0))
                          ]),
                      child: _image1 == null
                          ? Image(image: AssetImage('asset/img/no-image.png'))
                          : Image.file(_image1),
                    )),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple[600],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(blurRadius: 6.0, offset: Offset(0.0, 5.0))
                          ]),
                      child: _image2 == null
                          ? Image(image: AssetImage('asset/img/no-image.png'))
                          : Image.file(_image2),
                    )),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple[600],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(blurRadius: 6.0, offset: Offset(0.0, 5.0))
                          ]),
                      child: _image3 == null
                          ? Image(image: AssetImage('asset/img/no-image.png'))
                          : Image.file(_image3),
                    ))
              ],
            ),
            Divider(
              color: Colors.deepPurple,
            ),
            _button(),
          ],
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              bottom: 150.0,
              right: 10.0,
              child: FloatingActionButton(
                backgroundColor: Colors.deepPurple[600],
                heroTag: 'Photo 1',
                onPressed: () {
                  _showPicker(1, context);
                },
                child: Icon(Icons.photo),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            Positioned(
              bottom: 80.0,
              right: 10.0,
              child: FloatingActionButton(
                backgroundColor: Colors.deepPurple[600],
                heroTag: 'Photo 2',
                onPressed: () {
                  _showPicker(2, context);
                },
                child: Icon(Icons.image),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: FloatingActionButton(
                backgroundColor: Colors.deepPurple[600],
                heroTag: 'Photo 3',
                onPressed: () {
                  _showPicker(3, context);
                },
                child: Icon(Icons.photo_album),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            )
          ],
        ));
  }

  void _showPicker(int value, context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _onImageButtonPressed(ImageSource.gallery, value);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _onImageButtonPressed(ImageSource.gallery, value);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _createInputName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            labelText: "Name User Guest",
            helperText: "Name Here",
            icon: Icon(Icons.supervised_user_circle_sharp)),
        validator: (value) {
          if (value.length > 1) {
            return null;
          } else {
            return "value undefined";
          }
        },
        onChanged: (value) {
          setState(() {
            this.nameUser = value;
          });
        },
      ),
    );
  }

  Widget _createInputPhone() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            labelText: "Phone",
            helperText: "Phone Here",
            icon: Icon(Icons.phone)),
        validator: (value) {
          if (value.length > 1) {
            return null;
          } else {
            return "value undefined";
          }
        },
        onChanged: (value) {
          setState(() {
            this.phone = value;
          });
        },
      ),
    );
  }

  Widget _createInputPassword() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: true,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            labelText: "Password",
            helperText: "password Here",
            icon: Icon(Icons.lock)),
        validator: (value) {
          if (value.length > 1) {
            return null;
          } else {
            return "value undefined";
          }
        },
        onChanged: (value) {
          setState(() {
            this.password = value;
          });
        },
      ),
    );
  }

  Widget _createInputEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            labelText: "Email Account",
            helperText: "Email Here",
            icon: Icon(Icons.email)),
        validator: (value) {
          if (value.length > 1) {
            return null;
          } else {
            return "value undefined";
          }
        },
        onChanged: (value) {
          setState(() {
            this.email = value;
          });
        },
      ),
    );
  }

  Future _onImageButtonPressed(ImageSource source, int value) async {
    try {
      var pickedFile = await _picker.getImage(source: source);
      print("object: " + pickedFile.path);
      setState(() {
        switch (value) {
          case 1:
            _image1 = File(pickedFile.path);
            break;
          case 2:
            _image2 = File(pickedFile.path);
            break;
          case 3:
            _image3 = File(pickedFile.path);
            break;
          default:
            print("No selected attribute file");
        }
      });
      print("Done");
    } catch (e) {
      print("Error in pickImager: " + e);
    }
  }

  Widget _button() {
    return RaisedButton.icon(
      icon: Icon(Icons.account_circle),
      textColor: Colors.white,
      color: Colors.green,
      splashColor: Colors.grey,
      shape: StadiumBorder(),
      label: Text("Registrar Cuenta"),
      onPressed: () {
        print(this.nameUser);
        print(this.email);
        print(this.password);
        print(this.phone);
      },
    );
  }
}
