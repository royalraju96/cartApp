import 'package:diagnostic_app/screens/about_screen.dart';
import 'package:diagnostic_app/screens/home_screen.dart';
import 'package:diagnostic_app/screens/product_screen.dart';
import 'package:diagnostic_app/screens/users_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      String title, IconData icon, Function tabHandler, BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onTap: tabHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Diagnostic Center',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Home', Icons.home, () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }, context),
          buildListTile('Products', Icons.apps, () {
            Navigator.of(context).pushReplacementNamed(ProductScreen.routeName);
          }, context),
          buildListTile('Users', Icons.supervised_user_circle, () {
            Navigator.of(context).pushReplacementNamed(UsersScreen.routeName);
          }, context),
          buildListTile('About Us', Icons.person, () {
            Navigator.of(context).pushReplacementNamed(AboutScreen.routeName);
          }, context),
          buildListTile('Logout', Icons.person, () {}, context)
        ],
      ),
    );
  }
}
