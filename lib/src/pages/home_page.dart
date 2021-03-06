import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_e_photograph_app/src/pages/list_photography_page.dart';
import 'package:flutter_e_photograph_app/src/providers/Event.dart';
import 'package:flutter_e_photograph_app/src/widgets/MenuWidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter_e_photograph_app/src/providers/UserGuest.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static final String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final userGuest = Provider.of<UserGuest>(context);
    final event = Provider.of<Event>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dashboard E-photo App'),
        backgroundColor: Colors.deepPurple[600],
      ),
      drawer: MenuWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('asset/img/e-photo-app.png')),
            Text(
              "Welcome ${userGuest.name} :-)",
              style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _scanQR(context, event);
        },
        label: Text('Scanner Event'),
        icon: Icon(Icons.qr_code),
        backgroundColor: Colors.deepPurple[600],
      ),
    );
  }

  _scanQR(BuildContext context, Event event) async {
    try {
      await Permission.storage.request();
      String dataQr = await scanner.scan();
      print("**********************************");
      print("futureString: $dataQr");
      Map data = jsonDecode(dataQr);
      print(data);
      print("**********************************");
      if (data != null) {
        print("There is information");
        event.code = data["code"];
        event.dateEvent = data["date_event"];
        event.description = data["description"];
        event.location = data["location"];
        event.statusEvent = data["status_event"];
        event.owner = data["owner"];
        event.studioName = data["studio_name"];
        //location to next view HERE!!!
        Navigator.pushNamed(context, ListPhotographyPage.routeName);
      } else {
        print("There isnt information");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
