import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/providers/ListPhotos.dart';
import 'package:flutter_e_photograph_app/src/widgets/MenuWidget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ListCartPhotosPage extends StatefulWidget {
  ListCartPhotosPage({Key key}) : super(key: key);
  static final String routeName = 'list_cart_photo_page';

  @override
  _ListCartPhotosPageState createState() => _ListCartPhotosPageState();
}

class _ListCartPhotosPageState extends State<ListCartPhotosPage> {
  double _scale, _previusScale = 1.0;
  @override
  Widget build(BuildContext context) {
    ListPhoto listPhoto = Provider.of<ListPhoto>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Cart Photos"),
          backgroundColor: Colors.deepPurple[600],
        ),
        drawer: MenuWidget(),
        body: RefreshIndicator(
            onRefresh: getRefresh,
            backgroundColor: Colors.deepPurple[600],
            color: Colors.white,
            child: ListView.builder(
              itemCount: listPhoto.listShoppingCart == null
                  ? 0
                  : listPhoto.listShoppingCart.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  key: ValueKey(index),
                  actionPane: SlidableDrawerActionPane(),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: RawMaterialButton(
                      onPressed: () {
                        _showModalSheet(
                            "https://bucket-e-photo-app-sw1.s3.amazonaws.com/${listPhoto.listShoppingCart[index]["photo_name"]}");
                      },
                      elevation: 2.0,
                      fillColor: Colors.deepPurple,
                      child: Image(
                        image: NetworkImage(
                            "https://bucket-e-photo-app-sw1.s3.amazonaws.com/${listPhoto.listShoppingCart[index]["photo_name"]}"),
                      ),
                      shape: CircleBorder(),
                    ),
                    title: CircleAvatar(
                      radius: 9.0,
                      child: Text(
                        "Price: ${listPhoto.listShoppingCart[index]["price"]} \$us",
                        style: TextStyle(fontSize: 9.0),
                      ),
                      backgroundColor: Colors.deepPurple[600],
                    ),
                    subtitle: Text(
                        "Photo Code: ${listPhoto.listShoppingCart[index]["id"]}",
                        style: TextStyle(fontSize: 10.0)),
                    trailing: FaIcon(FontAwesomeIcons.arrowRight,
                        color: Colors.deepPurple[600]),
                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: "Delete?",
                      color: Colors.red,
                      icon: FontAwesomeIcons.trash,
                      onTap: () {
                        this.setState(() {
                          listPhoto.deletePhoto(
                              listPhoto.listShoppingCart[index]["id"]);
                        });
                      },
                    )
                  ],
                );
              },
            )));
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  void _showModalSheet(String urlImage) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return GestureDetector(
            onScaleStart: (ScaleStartDetails details) {
              print(details);
              _previusScale = _scale;
              setState(() {});
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              print(details);
              _scale = _previusScale * details.scale;
              setState(() {});
            },
            onScaleEnd: (ScaleEndDetails details) {
              print(details);
              _previusScale = 1.0;
              setState(() {});
            },
            child: Container(
              child: RotatedBox(
                quarterTurns: 0,
                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.matrix([
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0
                    ]),
                    child: Image(
                      image: NetworkImage(urlImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              padding: EdgeInsets.all(40.0),
            ),
          );
        });
  }
}
