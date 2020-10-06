// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
    Data({
        this.product,
    });

    List<Product> product;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
    };
}

class Product {
    Product({
        this.id,
        this.b2BRate,
        this.test,
        this.mrp,
        this.testCode,
    });

    String id;
    String b2BRate;
    String test;
    String mrp;
    String testCode;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        b2BRate: json["b2b_rate"],
        test: json["test"],
        mrp: json["mrp"],
        testCode: json["test_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "b2b_rate": b2BRate,
        "test": test,
        "mrp": mrp,
        "test_code": testCode,
    };
}

