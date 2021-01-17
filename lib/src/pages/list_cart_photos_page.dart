import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/helpers/alert.dart';
import 'package:flutter_e_photograph_app/src/libs/http.dart';
import 'package:flutter_e_photograph_app/src/pages/payment_page.dart';
import 'package:flutter_e_photograph_app/src/providers/ListPhotos.dart';
import 'package:flutter_e_photograph_app/src/providers/UserGuest.dart';
import 'package:flutter_e_photograph_app/src/services/stripie_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ListCartPhotosPage extends StatefulWidget {
  ListCartPhotosPage({Key key}) : super(key: key);
  static final String routeName = 'list_cart_photo_page';

  @override
  _ListCartPhotosPageState createState() => _ListCartPhotosPageState();
}

class _ListCartPhotosPageState extends State<ListCartPhotosPage> {
  HTTP http = new HTTP();
  @override
  Widget build(BuildContext context) {
    ListPhoto listPhoto = Provider.of<ListPhoto>(context);
    UserGuest userGuest = Provider.of<UserGuest>(context);
    StripeService service = new StripeService();
    service.init();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cart Photos of ${userGuest.name}"),
        backgroundColor: Colors.deepPurple[600],
      ),
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
                  // contentPadding: EdgeInsets.all(10.0),
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
                  title: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.moneyBillAlt,
                          color: Colors.green),
                      Text(
                        "  Price: ${listPhoto.listShoppingCart[index]["price"]} \$us",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  subtitle: Text(
                      "Photo Code: ${listPhoto.listShoppingCart[index]["id"]}",
                      style: TextStyle(fontSize: 15.0)),
                  trailing: FaIcon(FontAwesomeIcons.angleRight,
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
          )),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Confirm Purchase ${listPhoto.totalCost} \$us"),
        icon: FaIcon(FontAwesomeIcons.moneyCheckAlt),
        backgroundColor: Colors.deepPurple[600],
        onPressed: () async {
          makeDialog(
              context: context, message: "please wait, I'm making the payment");
          final response = await service.buyNewCard(
              amount: (listPhoto.totalCost * 100).floor().toString(),
              currency: 'USD');
          if (response.success) {
            Toast.show("payment made successfully", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            List<int> listCodePhoto = new List<int>();
            for (var i = 0; i < listPhoto.listShoppingCart.length; i++) {
              listCodePhoto.add(listPhoto.listShoppingCart[i]["id"]);
            }
            print(listCodePhoto);
            Map response = await http
                .post('/api/sale_note_manage/register_sale_note_guest', {
              "list_photography": listCodePhoto,
              "email_guest": userGuest.email,
              "total_cost": listPhoto.totalCost
            });
            print("object: $response");
            Navigator.of(context).pop();
            Toast.show(response["message"], context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            Navigator.pushNamed(context, PaymentPage.routeName);
          } else {
            Navigator.of(context).pop();
            Toast.show("Sorry, I had trouble paying", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        },
      ),
    );
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  void _showModalSheet(String urlImage) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: PinchZoomImage(
              image: ColorFiltered(
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
                child: CachedNetworkImage(
                  imageUrl: urlImage,
                ),
              ),
              zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
            ),
          );
        });
  }
}
