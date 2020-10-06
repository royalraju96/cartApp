import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DiagnosticTests {
  final String id;
  // final String productId;
  final int b2b_rate;
  final int mrp;
  final String rep_time;
  final String specimen;
  final String test;
  final String test_code;
  final int qty;

  const DiagnosticTests({
    @required this.id,
    //this.productId,
    this.b2b_rate,
    @required this.mrp,
    this.rep_time,
    @required this.specimen,
    @required this.test,
    this.test_code,
    this.qty,
  });
}

class Cart with ChangeNotifier {
  // String name = "MindCom";
  // double total = 0.0;
  // String id = "";
  // int b2b_rate;
  // int mrp;
  // String rep_time;
  // String specimen;
  // String test = "";
  // String test_code;
  // int qty;

  // Cart.name({@required this.name});
  // Cart({
  //   this.id,
  //   this.mrp,
  //   this.test,
  //   this.specimen,
  // });

  final List<DiagnosticTests> _item = [];

  Map<String, DiagnosticTests> _items = {};

  Map<String, DiagnosticTests> get items {
    return {..._items};
  }

  get itemCount {
    return _item.length;
  }

  double get totalAmount {
    var total = 0.0;
    print(items);

    _items.forEach((key, cartItem) {
      total += cartItem.mrp * cartItem.qty;
    });

    return total;
  }

  void addTotal() {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.qty * cartItem.mrp;
    });
  }

  // void addProduct(BuildContext context) {
  //   var productNew =
  //       DiagnosticTests(id: id, mrp: mrp, specimen: specimen, test: test);
  //   productNew.id;
  //   // print(productNew.id);
  // }

  void addItem(
    String id,
    String productId,
    String test,
    int mrp,
    String specimen,
    String rep_time,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
          productId,
          (existingCardItem) => DiagnosticTests(
                id: existingCardItem.id,
                // productId: existingCardItem.productId,
                test: existingCardItem.test,
                mrp: existingCardItem.mrp,
                qty: existingCardItem.qty + 1,
                specimen: existingCardItem.specimen,
                test_code: existingCardItem.test_code,
                rep_time: existingCardItem.rep_time,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => DiagnosticTests(
                id: DateTime.now().toString(),
                test: test,
                mrp: mrp,
                qty: 1,
                specimen: specimen,
                rep_time: rep_time,
              ));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    print(id);
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].qty > 1) {
      // reduce quantity...

      _items.update(
          productId,
          (existingCardItem) => DiagnosticTests(
                id: existingCardItem.id,
                //productId: existingCardItem.productId,
                test: existingCardItem.test,
                mrp: existingCardItem.mrp,
                qty: existingCardItem.qty - 1,
                specimen: existingCardItem.specimen,
                b2b_rate: existingCardItem.b2b_rate,
                test_code: existingCardItem.test_code,
                rep_time: existingCardItem.rep_time,
              ));
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
