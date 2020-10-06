import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostic_app/screens/product_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:diagnostic_app/models/diagnostic_tests.dart';
import 'package:provider/provider.dart';

class DiagonsticItem extends StatefulWidget {
  final DiagnosticTests diagnositcTests;

  DiagonsticItem(
    this.diagnositcTests,
  );

  @override
  _DiagonsticItemState createState() => _DiagonsticItemState();
}

class _DiagonsticItemState extends State<DiagonsticItem> {
  int qty = 0;
  int m;

  Widget keyValueBuilder(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: <Widget>[
          Text(
            key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ' : ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value == null ? " " : value)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final productId = ModalRoute.of(context).settings.arguments as String;
    // print(cart.id);

    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.only(right: 20.0),
            color: Colors.white70,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      keyValueBuilder('Test Name', widget.diagnositcTests.test),
                      keyValueBuilder(
                          'Test Code', widget.diagnositcTests.test_code),
                      keyValueBuilder(
                          'Test Description', widget.diagnositcTests.specimen),
                      keyValueBuilder(
                          'Rep Time', widget.diagnositcTests.rep_time),
                      keyValueBuilder('B2B Rate',
                          widget.diagnositcTests.b2b_rate.toString()),
                      keyValueBuilder(
                          'MRP', widget.diagnositcTests.mrp.toString())
                    ],
                  ),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      ProductEdit(widget.diagnositcTests.id)));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () => {
                          // Cart.name(name: "yatish"),
                          cart.addItem(
                            productId,
                            widget.diagnositcTests.id,
                            widget.diagnositcTests.test,
                            widget.diagnositcTests.mrp,
                            widget.diagnositcTests.specimen,
                            widget.diagnositcTests.rep_time,
                          ),
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Items added to cart Sucessfully"),
                              duration: Duration(seconds: 3),
                              action: SnackBarAction(
                                  label: "Undo",
                                  onPressed: () {
                                    cart.removeSingleItem(
                                        widget.diagnositcTests.id);
                                  }),
                            ),
                          ),
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      IconButton(
                        onPressed: () {
                          Firestore.instance
                              .collection("products")
                              .document(widget.diagnositcTests.id)
                              .delete();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
