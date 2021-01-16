import 'dart:io';

import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/helpers/alert.dart';
import 'package:flutter_e_photograph_app/src/models/credit_card.dart';
import 'package:flutter_e_photograph_app/src/providers/ListPhotos.dart';
import 'package:flutter_e_photograph_app/src/providers/PaymentCart.dart';
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
  String _cardNumber = "";
  String _expiryDate = "";
  String _holderName = "";
  String _ccv = "";
  bool _backView = false;
  @override
  Widget build(BuildContext context) {
    PaymentCart paymentDetails = Provider.of<PaymentCart>(context);
    ListPhoto listPhoto = Provider.of<ListPhoto>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.ccStripe),
            Container(child: Text(" Payment Cart"))
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
            cardNumber: this._cardNumber.length > 0
                ? this._cardNumber
                : '5555555555555555',
            expiryDate:
                this._expiryDate.length > 0 ? this._expiryDate : '01/25',
            cardHolderName:
                this._holderName.length > 0 ? this._holderName : 'Rocky Balboa',
            cvvCode: this._ccv.length > 0 ? this._ccv : '213',
            showBackView: this._backView,
          ),
          Divider(
            color: Colors.deepPurple[600],
          ),
          Column(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.deepPurple[600],
                  onChanged: (value) {
                    if (this._backView) {
                      setState(() {
                        _backView = false;
                        _cardNumber = value;
                      });
                    } else {
                      setState(() {
                        _cardNumber = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple[600]),
                        borderRadius: BorderRadius.circular(20.0)),
                    counter: Text("letters: ${this._cardNumber.length}"),
                    labelText: "Card Number",
                    helperText: "Ex. 4242XXXXXXXX",
                    icon: FaIcon(FontAwesomeIcons.creditCard,
                        color: Colors.deepPurple[600]),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 5,
                  cursorColor: Colors.deepPurple[600],
                  onChanged: (value) {
                    if (this._backView) {
                      setState(() {
                        _backView = false;
                        _expiryDate = value;
                      });
                    } else {
                      setState(() {
                        _expiryDate = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple[600]),
                        borderRadius: BorderRadius.circular(20.0)),
                    counter: Text("letters: ${this._expiryDate.length}"),
                    labelText: "Expiry Date",
                    helperText: "Ex. 01/25",
                    icon: FaIcon(FontAwesomeIcons.calendarAlt,
                        color: Colors.deepPurple[600]),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.deepPurple[600],
                  onChanged: (value) {
                    if (this._backView) {
                      setState(() {
                        _backView = false;
                        _holderName = value;
                      });
                    } else {
                      setState(() {
                        _holderName = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple[600]),
                        borderRadius: BorderRadius.circular(20.0)),
                    counter: Text("letters: ${this._holderName.length}"),
                    labelText: "Holder Name",
                    helperText: "Ex. Rocky Balboa",
                    icon: FaIcon(FontAwesomeIcons.user,
                        color: Colors.deepPurple[600]),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.deepPurple[600],
                  onChanged: (value) {
                    if (!this._backView) {
                      setState(() {
                        _backView = true;
                        _ccv = value;
                      });
                    } else {
                      setState(() {
                        _ccv = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple[600]),
                        borderRadius: BorderRadius.circular(20.0)),
                    counter: Text("letters: ${this._ccv.length}"),
                    labelText: "ccv",
                    helperText: "Ex. 213",
                    icon: FaIcon(FontAwesomeIcons.ccMastercard,
                        color: Colors.deepPurple[600]),
                  ),
                )),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.green,
              splashColor: Colors.grey,
              shape: StadiumBorder(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.moneyCheckAlt),
                  Text(" Confirm Payment")
                ],
              ),
              onPressed: () async {
                makeDialog(context: context, message: "Ya valiste vrga");
                await Future.delayed(Duration(milliseconds: 2000));
                paymentDetails.tagert = new CreditTarget(
                    cardNumberHidden: this._cardNumber.substring(0, 3),
                    cvv: this._ccv,
                    cardNumber: this._cardNumber,
                    brand: 'visa',
                    expiracyDate: this._expiryDate,
                    cardHolderName: this._holderName);
                paymentDetails.costTotal = listPhoto.totalCost;
                // paymentDetails.coin =
                // paymentDetails.activeCard
                Navigator.of(context).pop();
              },
            )
          ]), // _button(context, userGuest),
        ],
      ),
    );
  }
}
