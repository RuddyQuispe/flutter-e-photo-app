import 'dart:io';

import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/helpers/alert.dart';
import 'package:flutter_e_photograph_app/src/providers/ListPhotos.dart';
import 'package:flutter_e_photograph_app/src/providers/UserGuest.dart';
import 'package:flutter_e_photograph_app/src/services/stripie_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key key}) : super(key: key);
  static final String routeName = 'payment_page';

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    ListPhoto listPhoto = Provider.of<ListPhoto>(context);
    UserGuest userGuest = Provider.of<UserGuest>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.ccStripe),
            Container(child: Text(" Thanks for your purchase"))
          ],
        ),
        backgroundColor: Colors.deepPurple[600],
        actions: [
          IconButton(
              icon: FaIcon(Platform.isIOS
                  ? FontAwesomeIcons.apple
                  : FontAwesomeIcons.android),
              onPressed: () => Toast.show(
                  "You're ${Platform.isIOS ? "iOS" : "Android"} Platform",
                  context,
                  duration: Toast.LENGTH_SHORT,
                  gravity: Toast.BOTTOM)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: <Widget>[
          CreditCardWidget(
            cardNumber: '4242 4242 4242 4242',
            expiryDate: 'XX/XX',
            cardHolderName: userGuest.name,
            cvvCode: '123',
            showBackView: false,
          ),
          Divider(
            color: Colors.deepPurple[600],
          ),
          Column(
            children: getListPurchase(listPhoto),
          ),
          Divider(
            color: Colors.deepPurple[600],
          ),
          Text(
            "Total: ${listPhoto.totalCost} \$us",
            style: TextStyle(
                fontSize: 30.0, backgroundColor: Colors.lightGreenAccent[400]),
          )
        ],
      ),
    );
  }

  List<Widget> getListPurchase(ListPhoto listPhoto) {
    List<Widget> listWidgets = new List<Widget>();
    for (var index = 0; index < listPhoto.listShoppingCart.length; index++) {
      listWidgets.add(
        ListTile(
          // contentPadding: EdgeInsets.all(10.0),
          leading: Image(
            image: NetworkImage(
                "https://bucket-e-photo-app-sw1.s3.amazonaws.com/${listPhoto.listShoppingCart[index]["photo_name"]}"),
          ),
          title: Row(
            children: [
              FaIcon(FontAwesomeIcons.moneyBillAlt, color: Colors.green),
              Text(
                "  Price: ${listPhoto.listShoppingCart[index]["price"]} \$us",
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          subtitle: Text(
              "Photo Code: ${listPhoto.listShoppingCart[index]["id"]}",
              style: TextStyle(fontSize: 15.0)),
        ),
      );
    }
    return listWidgets;
  }
}
