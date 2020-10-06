import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNewProduct extends StatefulWidget {
  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final _testDec = TextEditingController();

  final _testCode = TextEditingController();

  final _testSpeciman = TextEditingController();

  final _testRepTime = TextEditingController();

  final _mrp = TextEditingController();

  final _b2bRate = TextEditingController();

  void _submitData() {
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
    print('hello');
    Firestore.instance.collection("products").add({
      "test": _testDec.text,
      "test_code": _testCode.text,
      "speciman": _testSpeciman.text,
      "rep_time": _testRepTime.text,
      "b2b_rate": int.parse(_b2bRate.text),
      "mrp": int.parse(_mrp.text),
      "createdAt": DateTime.now(),
    }).then(
      (value) => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  onPressed: _submitData,
                  child: Text(
                    'Add Test',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
