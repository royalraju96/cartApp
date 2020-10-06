import 'package:diagnostic_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About US'),
      ),
      body: Center(
        child: Text('About Screen'),
      ),
      drawer: MainDrawer(),
    );
  }
}
