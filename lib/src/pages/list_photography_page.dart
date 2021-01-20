import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/libs/http.dart';
import 'package:flutter_e_photograph_app/src/pages/list_cart_photos_page.dart';
import 'package:flutter_e_photograph_app/src/providers/Event.dart';
import 'package:flutter_e_photograph_app/src/providers/ListPhotos.dart';
import 'package:flutter_e_photograph_app/src/providers/UserGuest.dart';
import 'package:flutter_e_photograph_app/src/widgets/MenuWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

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
  double _scale, _previusScale = 1.0;
  String _message = "Loading";
  HTTP _http = new HTTP();

  _getProductList(int codeEvent, String emailGuest) async {
    Map data = await _http.get(
        "/api/photography_manage/list_photographies/$codeEvent/$emailGuest");
    var val = data['list_photographies'];
    if (val.length > 0) {
      setState(() {
        _listPhotographies = val;
      });
    } else {
      setState(() {
        _listPhotographies = val;
        _message = "You Doesn't have photos";
      });
    }
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
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.pushNamed(context, ListCartPhotosPage.routeName);
                  }),
            )
          ],
        ),
        drawer: MenuWidget(),
        body: _getHomePageBody(context, event, listPhoto));
  }

  Widget _getHomePageBody(
      BuildContext context, Event event, ListPhoto listPhoto) {
    if (_listPhotographies.length > 0 && state) {
      MediaQueryData queryData = MediaQuery.of(context);
      return SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: queryData.size.width * 0.20),
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
                    return Builder(
                      builder: (context) {
                        return Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                                ListTile(
                                  contentPadding: EdgeInsets.only(left: 40.0),
                                  title: Text(
                                      "Price: ${photography["price"]} \$us",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28.0,
                                          color: Colors.black)),
                                  subtitle: Text(
                                    "Photographer: ${photography["name"]}\nEmail: ${photography["email"]}",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black54),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black38,
                                  height: 20,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Row(
                                  children: getSocialRedPhotographer(
                                      photography["array"]),
                                ),
                                Divider(
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
                                  label: Text("Add to Cart"),
                                  onPressed: () {
                                    Toast.show(
                                        "Added to Shopping Cart photo #${photography["id"]}",
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                    print("Register");
                                    addShoppingCart(
                                        photography["id"],
                                        double.parse(photography["price"]),
                                        photography["photo_name"],
                                        listPhoto);
                                  },
                                )
                              ],
                            ));
                      },
                    );
                  }).toList()))
        ],
      ));
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
                      _message,
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
            padding: EdgeInsets.all(10.0),
            child: PinchZoomImage(
              image: ColorFiltered(
                colorFilter: ColorFilter.matrix([
                  1,
                  -0.2,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                  -0.1,
                  0,
                  0,
                  1.2,
                  1,
                  0.1,
                  0,
                  0,
                  0,
                  1.7,
                  1,
                  0
                ]),
                child: CachedNetworkImage(
                  imageUrl: urlImage,
                ),
              ),
              zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
            ),
          );
        });
  }

  List getSocialRedPhotographer(List<dynamic> listRedSocial) {
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
            onPressed: () async {
              if (await canLaunch(redSocialList[1])) {
                await launch(redSocialList[1]);
              } else {
                throw "Could not launch ${redSocialList[1]}";
              }
            },
          ));
          break;
        case 2:
          listWidget.add(RaisedButton(
            color: Colors.blue[400],
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
            onPressed: () async {
              if (await canLaunch(redSocialList[1])) {
                await launch(redSocialList[1]);
              } else {
                throw "Could not launch ${redSocialList[1]}";
              }
            },
          ));
          break;
        case 3:
          listWidget.add(RaisedButton(
            color: Colors.pink,
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
            onPressed: () async {
              if (await canLaunch(redSocialList[1])) {
                await launch(redSocialList[1]);
              } else {
                throw "Could not launch ${redSocialList[1]}";
              }
            },
          ));
          break;
        case 4:
          listWidget.add(RaisedButton(
            color: Colors.black,
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.tiktok, color: Colors.white),
            onPressed: () async {
              if (await canLaunch(redSocialList[1])) {
                await launch(redSocialList[1]);
              } else {
                throw "Could not launch ${redSocialList[1]}";
              }
            },
          ));
          break;
        default:
          listWidget.add(RaisedButton(
            color: Colors.black,
            shape: CircleBorder(),
            child: FaIcon(FontAwesomeIcons.tiktok, color: Colors.white),
            onPressed: () async {
              if (await canLaunch(redSocialList[1])) {
                await launch(redSocialList[1]);
              } else {
                throw "Could not launch ${redSocialList[1]}";
              }
            },
          ));
      }
    }
    return listWidget;
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
