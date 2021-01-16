import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/pages/list_cart_photos_page.dart';
import 'package:flutter_e_photograph_app/src/pages/list_photography_page.dart';
import 'package:flutter_e_photograph_app/src/pages/login_page.dart';
import 'package:flutter_e_photograph_app/src/pages/payment_page.dart';
import 'package:flutter_e_photograph_app/src/pages/register_guest.dart';
import 'package:flutter_e_photograph_app/src/providers/Event.dart';
import 'package:flutter_e_photograph_app/src/providers/ListPhotos.dart';
import 'package:flutter_e_photograph_app/src/providers/PaymentCart.dart';
import 'package:flutter_e_photograph_app/src/providers/UserGuest.dart';
import 'package:provider/provider.dart';

import 'package:flutter_e_photograph_app/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserGuest()),
        ChangeNotifierProvider(create: (_) => Event()),
        ChangeNotifierProvider(create: (_) => ListPhoto()),
        ChangeNotifierProvider(create: (_) => PaymentCart())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Photo-App',
          initialRoute: PaymentPage.routeName,
          routes: {
            HomePage.routeName: (BuildContext context) => HomePage(),
            LoginPage.routeName: (BuildContext context) => LoginPage(),
            RegisterGuest.routeName: (BuildContext context) => RegisterGuest(),
            ListPhotographyPage.routeName: (BuildContext context) =>
                ListPhotographyPage(),
            ListCartPhotosPage.routeName: (BuildContext context) =>
                ListCartPhotosPage(),
            PaymentPage.routeName: (BuildContext context) => PaymentPage()
          },
          theme: ThemeData.light()),
    );
  }
}
