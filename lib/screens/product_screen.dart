import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostic_app/data/badge.dart';
import 'package:diagnostic_app/models/diagnostic_tests.dart';
import 'package:diagnostic_app/screens/search_screen.dart';
import 'package:diagnostic_app/widgets/add_new_product.dart';
import 'package:diagnostic_app/widgets/diagonstic_item.dart';
import 'package:diagnostic_app/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product-screen';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchContoller = TextEditingController();

  bool isSearching = false;

  int qty;
  int mrp;

  String name;

  bool isLoggedIn;
  Stream data = Firestore.instance
      .collection("products")
      .orderBy("createdAt", descending: true)
      .snapshots();

  clearSearch() {
    searchContoller.clear();
  }

  void _addNewProduct(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddNewProduct(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    print(cart.itemCount.toString());
    print(cart.itemCount.hashCode);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: !isSearching
            ? Text('Home')
            : TextField(
                controller: searchContoller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search Product here",
                    hintStyle: TextStyle(color: Colors.white)),
                onChanged: (String query) {},
              ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              }),
          SizedBox(
            width: 10.0,
          ),
          Consumer<Cart>(
            builder: (_, value, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
          ),
        ],
      ),
      body: SafeArea(
              child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                  stream: data,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Loading(
                        indicator: BallGridPulseIndicator(),
                        size: 100,
                        color: Theme.of(context).primaryColor,
                      );
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading...');
                      default:
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot products =
                                snapshot.data.documents[index];
                            print(products.documentID);

                            return Container(
                              margin: EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.all(9.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: DiagonsticItem(
                                DiagnosticTests(
                                  id: products.documentID,
                                  b2b_rate: products['b2b_rate'],
                                  mrp: products['mrp'],
                                  rep_time: products['rep_time'],
                                  specimen: products['specimen'],
                                  test: products['test'],
                                  test_code: products['test_code'],
                                ),
                              ),
                            );
                          },
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewProduct(context),
        tooltip: 'Add Phelloroducts',
        child: Icon(Icons.add),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  // void _removeProduct() {
  //   setState(() {
  //     if (qty != 0) {
  //       qty--;
  //     }
  //   });
  // }
}
