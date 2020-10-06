import 'package:diagnostic_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/loading.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = '/users-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Center(
        child: Loading(
          indicator: BallGridPulseIndicator(),
          size: 100,
          color: Colors.blue,
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
