import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/libs/http.dart';
import 'package:flutter_e_photograph_app/src/providers/Event.dart';
import 'package:flutter_e_photograph_app/src/providers/ListPhotos.dart';
import 'package:flutter_e_photograph_app/src/providers/UserGuest.dart';
import 'package:flutter_e_photograph_app/src/widgets/MenuWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ListPhotographyPage extends StatefulWidget {
  ListPhotographyPage({Key key}) : super(key: key);
  static final String routeName = 'list_photography_page';

  @override
  _ListPhotographyPageState createState() => _ListPhotographyPageState();
}

class _ListPhotographyPageState extends State<ListPhotographyPage> {
  List _listPhotographies = [];
  bool state = false;
  bool selected = false;
  HTTP _http = new HTTP();

  _getProductList(int codeEvent, String emailGuest) async {
    Map data = await _http.get(
        "/api/photography_manage/list_photographies/$codeEvent/$emailGuest");
    var val = data['list_photographies'];
    setState(() {
      _listPhotographies = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Event event = Provider.of<Event>(context);
    UserGuest userGuest = Provider.of<UserGuest>(context);
    ListPhoto listPhoto = Provider.of<ListPhoto>(context);
    if (_listPhotographies.length == 0 && !state) {
      _getProductList(event.code, userGuest.email);
      state = true;
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(event.description),
          backgroundColor: Colors.deepPurple[600],
          actions: [
            Badge(
              position: BadgePosition.topEnd(top: 0, end: 3),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                listPhoto.getCountPhotosAdded().toString(),
                style: TextStyle(color: Colors.white),
              ),
              child:
                  IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
            )
          ],
        ),
        drawer: MenuWidget(),
        body: _getHomePageBody(context, event, listPhoto));
  }

  Widget _getHomePageBody(
      BuildContext context, Event event, ListPhoto listPhoto) {
    if (_listPhotographies.length > 0 && state) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 600.0,
                  initialPage: 2,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 3),
                  scrollDirection:
                      Axis.horizontal, // carousell on vertical or horizontal
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  aspectRatio: 2.0,
                ),
                items: _listPhotographies.map((var photography) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Builder(
                      builder: (context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment
                                      .bottomLeft, // 10% of the width, so there are ten blinds.
                                  end: Alignment.topRight, // 10% of the width, so there are ten blinds.
                                  colors: [
                                    Colors.deepPurple[100],
                                    Colors.deepPurple[500]
                                  ]),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 6.0,
                                    offset: Offset(2.0, 5.0))
                              ]),
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  child: Image(
                                      image: NetworkImage(
                                          "https://bucket-e-photo-app-sw1.s3.amazonaws.com/${photography["photo_name"]}")),
                                  height: 280,
                                  width: 300,
                                ),
                                onTap: () => showModalSheet(
                                    "https://bucket-e-photo-app-sw1.s3.amazonaws.com/${photography["photo_name"]}"),
                              ),
                              Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.all(5),
                                    title: Text(
                                        "Price: ${photography["price"]} \$us",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Colors.black)),
                                    subtitle: Text(
                                      "Photographer: ${photography["name"]}\nEmail: ${photography["email"]}",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                    height: 20,
                                    thickness: 2,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: getSocialRedPhotographer(
                                        photography["array"]),
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                    height: 20,
                                    thickness: 2,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  RaisedButton.icon(
                                    icon: Icon(Icons.shopping_cart),
                                    textColor: Colors.white,
                                    color: Colors.green,
                                    splashColor: Colors.grey,
                                    shape: StadiumBorder(),
                                    label: Text("Buy"),
                                    onPressed: () {
                                      Toast.show(
                                          "Added to Shopping Cart photo #${photography["id"]}",
                                          context,
                                          duration: Toast.LENGTH_SHORT,
                                          gravity: Toast.BOTTOM);
                                      print("Register");
                                      addShoppingCart(
                                          int.parse(photography["id"]),
                                          double.parse(photography["price"]),
                                          photography["photo_name"],
                                          listPhoto);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: Center(
          child: AnimatedContainer(
              width: selected ? 200.0 : 100.0,
              height: selected ? 100.0 : 200.0,
              color: selected ? Colors.deepPurple[200] : Colors.deepPurple[400],
              alignment:
                  selected ? Alignment.center : AlignmentDirectional.topCenter,
              duration: Duration(milliseconds: 1500),
              curve: Curves.fastOutSlowIn,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud,
                        color: selected ? Colors.black87 : Colors.white70),
                    Text(
                      "Loading",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selected ? Colors.black87 : Colors.white70),
                    )
                  ],
                ),
              )),
        ),
      );
    }
  }

  void showModalSheet(String urlImage) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: Image(
              image: NetworkImage(urlImage),
            ),
            padding: EdgeInsets.all(40.0),
          );
        });
  }

  Row getSocialRedPhotographer(List<dynamic> listRedSocial) {
    List<Widget> listWidget = new List<Widget>();
    for (var i = 0; i < listRedSocial.length; i++) {
      String redSocial = listRedSocial[i];
      redSocial = redSocial.substring(1, redSocial.length - 1);
      List redSocialList = redSocial.split(',');
      switch (int.parse(redSocialList[0])) {
        case 1:
          listWidget.add(RaisedButton(
            shape: CircleBorder(),
            color: Colors.blue,
            child: FaIcon(FontAwesomeIcons.facebookF, color: Colors.white),
            onPressed: () {},
          ));
          break;
        case 2:
          listWidget.add(RaisedButton(
            color: Colors.blue[400],
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
            onPressed: () {},
          ));
          break;
        case 3:
          listWidget.add(RaisedButton(
            color: Colors.pink,
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
            onPressed: () {},
          ));
          break;
        case 4:
          listWidget.add(RaisedButton(
            color: Colors.black,
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.tiktok, color: Colors.white),
            onPressed: () {},
          ));
          break;
        default:
          listWidget.add(RaisedButton(
            color: Colors.black,
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.tiktok, color: Colors.white),
            onPressed: () {},
          ));
      }
    }
    return Row(
      children: listWidget,
    );
  }

  void addShoppingCart(
      int photography, double price, String photoName, ListPhoto listPhoto) {
    Map<String, dynamic> mapDataToAdd = new Map();
    mapDataToAdd["id"] = photography;
    mapDataToAdd["price"] = price;
    mapDataToAdd["photo_name"] = photoName;
    listPhoto.addListPhoto(mapDataToAdd);
  }
}
