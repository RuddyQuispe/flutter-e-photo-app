import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              margin: EdgeInsets.only(top: 60.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person, color: Colors.white),
                  FlatButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, OwnerActivity.routeName);
                    },
                    child: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.deepPurple[600]),
            title: Text('Home'),
            subtitle: Text('Menu Principal'),
            onTap: () {
              // Navigator.pushNamed(context, HomePage.routeName);
            },
          ),
          ListTile(
              leading:
                  Icon(Icons.business_center, color: Colors.deepPurple[600]),
              title: Text('Registrar Producto'),
              subtitle: Text(
                  'Registra tu producto aquí, no importa si tienes o no garantía'),
              onTap: () {
                // Navigator.pushNamed(context, ProductPage.routeName);
              }),
          ListTile(
              leading: Icon(Icons.list, color: Colors.deepPurple[600]),
              title: Text('Lista de Productos'),
              subtitle: Text("Aqui podrás ver todos tus productos registrados"),
              onTap: () {
                // Navigator.pushNamed(context, ProductList.routeName);
              }),
          ListTile(
              leading: Icon(Icons.center_focus_strong,
                  color: Colors.deepPurple[600]),
              title: Text('Solicitud Servicio Soporte Técnico'),
              subtitle: Text('Envía tu solicitud de soporte para ser atendido'),
              onTap: () {
                // Navigator.pushNamed(context, RequestSupport.routeName);
              }),
          ListTile(
            leading: Icon(Icons.art_track, color: Colors.deepPurple[600]),
            title: Text('Mis Facturas'),
            subtitle:
                Text("Aquí podrás ver tus facturas Emitidas con RestTeam"),
            onTap: () {
              // Navigator.pushNamed(context, InvoiceList.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.list, color: Colors.deepPurple[600]),
            title: Text('Lista de Polizas de Garantia'),
            subtitle: Text("Aqui podras ver tus polizas de garantia"),
            onTap: () {
              // Navigator.pushNamed(context, GuaranteePolicytList.routeName);
            },
          ),
          ListTile(
              leading: Icon(Icons.settings, color: Colors.deepPurple[600]),
              title: Text('Configuración'),
              subtitle: Text('Aqui puedes Personalizar la app'),
              onTap: () {
                // Navigator.pushNamed(context, SettingPage.routeName);
              }),
        ],
      ),
    );
  }
}
