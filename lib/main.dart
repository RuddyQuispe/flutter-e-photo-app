import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/pages/login_page.dart';
import 'package:flutter_e_photograph_app/src/pages/register_guest.dart';
import 'package:flutter_e_photograph_app/src/providers/Event.dart';
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
        ChangeNotifierProvider(create: (_) => Event())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Photo-App',
          initialRoute: LoginPage.routeName,
          routes: {
            HomePage.routeName: (BuildContext context) => HomePage(),
            LoginPage.routeName: (BuildContext context) => LoginPage(),
            RegisterGuest.routeName: (BuildContext context) => RegisterGuest()
          },
          theme: ThemeData.light()),
    );
  }
}
