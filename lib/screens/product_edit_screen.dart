import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/loading.dart';

class ProductEdit extends StatefulWidget {
  static const routeName = '/product-edit';
  final String docId;

  ProductEdit(this.docId);

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  bool isLoading = true;

  var _testDec = TextEditingController();

  var _testCode = TextEditingController();

  var _testSpeciman = TextEditingController();

  var _testRepTime = TextEditingController();

  var _mrp = TextEditingController();

  var _b2bRate = TextEditingController();

  @override
  void initState() {
    Firestore.instance
        .collection('products')
        .document(widget.docId)
        .get()
        .then((value) {
      setState(() {
        _testDec.text = value['test'];
        _testCode.text = value['test_code'];
        _testSpeciman.text = value['speciman'];
        _testRepTime.text = value['rep_time'];
        _mrp.text = value['mrp'].toString();
        _b2bRate.text = value['b2b_rate'].toString();
        isLoading = false;
      });
    });
    super.initState();
  }

  void _updateData() {
    if (_testDec.text.isEmpty) {
      return;
    }
    if (_testCode.text.isEmpty) {
      if (int.parse(_testCode.text) <= 0) {
        return;
      }
    }
    if (_testSpeciman.text.isEmpty) {
      return;
    }
    if (_testRepTime.text.isEmpty) {
      return;
    }
    if (_mrp.text.isEmpty) {
      if (int.parse(_mrp.text) <= 0) {
        return;
      }
    }
    if (_b2bRate.text.isEmpty) {
      if (int.parse(_b2bRate.text) <= 0) {
        return;
      }
    }

    isLoading = true;

    Firestore.instance
        .collection("products")
        .document(widget.docId)
        .updateData({
      "test": _testDec.text,
      "test_code": _testCode.text,
      "speciman": _testSpeciman.text,
      "rep_time": _testRepTime.text,
      "b2b_rate": int.parse(_b2bRate.text),
      "mrp": int.parse(_mrp.text),
      "createdAt": DateTime.now(),
    }).then(
      (value) {
        Navigator.of(context).pop();
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Test'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: Loading(
                  indicator: BallGridPulseIndicator(),
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 1,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Test Name'),
                        controller: _testDec,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Text Code'),
                        controller: _testCode,
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Test Speciman'),
                        controller: _testSpeciman,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Rep Time'),
                        controller: _testRepTime,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'B2B MRP'),
                        controller: _b2bRate,
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'MRP'),
                        controller: _mrp,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: _updateData,
                          child: Text(
                            'Update Test',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
