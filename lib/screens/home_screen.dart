import 'package:diagnostic_app/screens/about_screen.dart';
import 'package:diagnostic_app/screens/product_screen.dart';
import 'package:diagnostic_app/screens/users_screen.dart';
import 'package:diagnostic_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  Widget buildActions(
      BuildContext context, IconData icon, String title, String routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(routeName);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 10,
        color: Colors.lightBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              childAspectRatio: 2 / 1,
              crossAxisCount: 2,
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                buildActions(
                  context,
                  Icons.local_hospital,
                  'Products',
                  ProductScreen.routeName,
                ),
                buildActions(
                  context,
                  Icons.supervised_user_circle,
                  'Users',
                  UsersScreen.routeName,
                ),
                buildActions(
                  context,
                  Icons.person,
                  'About Us',
                  AboutScreen.routeName,
                )
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
