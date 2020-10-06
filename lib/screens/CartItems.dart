import 'package:diagnostic_app/models/diagnostic_tests.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String specimen;
  final String test;
  final String rep_time;
  final String productId;
  final int mrp;
  final int qty;

  CartItems(this.id, this.mrp, this.qty, this.specimen, this.test,
      this.rep_time, this.productId);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40.0,
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(right: 20.0),
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(test),
                Text(rep_time != null ? rep_time : "Rep Time: Not avaliable")
              ],
            ),
            subtitle: Row(
              children: [
                Text(
                  'Total : \u20B9${mrp * qty}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(specimen != null ? specimen : 'Description: Not Avaliable')
              ],
            ),
            trailing: Text(
              '$qty x',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ),
      ),
    );
  }
}
