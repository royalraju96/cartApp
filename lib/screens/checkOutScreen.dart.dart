import 'package:diagnostic_app/screens/CartItems.dart';
import 'package:flutter/material.dart';
import 'package:diagnostic_app/models/diagnostic_tests.dart';

import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  final DiagnosticTests diagnositcTests;

  CartScreen({
    this.diagnositcTests,
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String named;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    //print(cart.total);

    //print(cartValue.mrp);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\u20B9${cart.totalAmount}',
                      style: TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                  ),
                  FlatButton(onPressed: () {}, child: Text("Get Now")),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) => CartItems(
                        cart.items.values.toList()[index].id,
                        cart.items.values.toList()[index].mrp,
                        cart.items.values.toList()[index].qty,
                        cart.items.values.toList()[index].specimen,
                        cart.items.values.toList()[index].test,
                        cart.items.values.toList()[index].rep_time,
                        cart.items.keys.toList()[index],
                      ))),
        ],
      ),
    );
  }
}
