import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/pages/home_page.dart';
import 'package:flutter_e_photograph_app/src/providers/UserGuest.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserGuest userGuest = Provider.of<UserGuest>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              margin: EdgeInsets.only(top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.white),
                      Text(" " + userGuest.name,
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.white),
                      Text(" " + userGuest.email,
                          style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('asset/img/menu-img.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.deepPurple[600]),
            title: Text('Home'),
            subtitle: Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, HomePage.routeName);
            },
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.deepPurple[600]),
              title: Text('Exit'),
              subtitle: Text('Close App'),
              onTap: () {
                Toast.show("Close to the app", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                // Navigator.pushNamed(context, SettingPage.routeName);
              }),
        ],
      ),
    );
  }
}
